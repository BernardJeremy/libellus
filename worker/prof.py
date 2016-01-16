#!/usr/bin/env python3

import requests
import sys
import re
import psycopg2

rate_link = None
refresh_time = 3

try:
    conn = psycopg2.connect("dbname=libellus user=sevauk password=dev1 host=localhost")
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

    m = re.search(r'<div class="grade">(\d\.\d)</div>', prof_html)
    grade = m.group(1)
    return grade

def look_for_prof(name):

    query_params = {'queryoption':'HEADER',
            'queryBy':'teacherName',
            'schoolName':'',
            'schoolID':'',
            'query':name}

    #quickfix
    name = name.replace(' ', '+')
    r = requests.get('http://www.ratemyprofessors.com/search.jsp?queryoption=HEADER&queryBy=teacherName&schoolName=&schoolID=&query=' + name)

    if r.status_code != 200:
        exit(1)

    tid = extract_prof_id_from_html(r.text)
    return load_prof_page(tid)

def add_teacher(name):

    rating = extract_rating(name)

    cur = conn.cursor()
    cur.execute("INSERT INTO teacher VALUES(DEFAULT, '{}', {}, '{}', NOW())".format(name, rating, rate_link))
    conn.commit()

def check_db():

    cur = conn.cursor()
    #cur.execute("SELECT * FROM teacher WHERE refresh < NOW() - INTERVAL '{} SECONDS'".format(refresh_time))
    cur.execute("SELECT * FROM teacher")

    rows = cur.fetchall()
    cur.close()
    if rows != []:
        print('must update')
        print(rows)
    else:
        print('no record')

add_teacher('Elleni Wolde')
check_db()
#print(extract_rating(prof_name))
