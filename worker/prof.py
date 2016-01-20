#!/usr/bin/env python3

import requests
import traceback
import sys
import re
import psycopg2

rate_link = None
refresh_time = 60 * 60 * 24 # refresh every 24 hours

try:
#    conn = psycopg2.connect("dbname=libellus user=dev host=localhost")
    conn = psycopg2.connect("dbname=libellus user=libellus_api host=localhost")
except psycopg2.Error as e:
    print('could not connect to db {}'.format(e))
    exit(1)

def extract_prof_id_from_html(html):

    m = re.search(r'<a href="/ShowRatings.jsp\?tid=(([0-9])+)"', html)
    return m.group(1)

def load_prof_page(pid):

    global rate_link
    rate_link = 'http://www.ratemyprofessors.com/ShowRatings.jsp?tid={}'.format(pid)
    r = requests.get('{}'.format(rate_link))
    if r.status_code != 200:
        exit(1)

    return r.text

def extract_rating(prof_name):

    prof_html = look_for_prof(prof_name)
    grade = 0

    m = re.search(r'<div class="grade">(\d\.\d)</div>', prof_html)
    grade = m.group(1)

    return grade

def look_for_prof(name):

    query_params = {'queryoption':'HEADER',
            'queryBy':'teacherName',
            'schoolName':'California State University Long Beach',
            'schoolID':'',
            'query':name}

    r = requests.get('http://www.ratemyprofessors.com/search.jsp', params=query_params)

    if r.status_code != 200:
        exit(1)

    tid = extract_prof_id_from_html(r.text)
    return load_prof_page(tid)

def update_teacher(name):

    rating = extract_rating(name)

    cur = conn.cursor()
    cur.execute("UPDATE teachers SET rate = {}, \"rateLastUpdated\" = NOW(), \"rateLink\" = '{}' WHERE name = '{}'".format(rating, rate_link, name.replace("'", "''")))
    conn.commit()
    print('libellus worker: {} has been updated'.format(name))

def check_db():

    cur = conn.cursor()
    cur.execute("SELECT * FROM teachers WHERE \"rateLastUpdated\" IS NULL OR \"rateLastUpdated\" < NOW() - INTERVAL '{} SECONDS' ".format(refresh_time))

    rows = cur.fetchall()
    cur.close()
    if rows != []:
        for r in rows:
            try:
              update_teacher(r[1])
            except:
              print('an error occured when parsing {} professor'.format(r[1]))
    else:
        print('libellus worker: nothing to update')

check_db()
