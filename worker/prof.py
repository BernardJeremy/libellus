#!/usr/bin/env python3

import requests
import sys
import re

if len(sys.argv) != 2:
    sys.stderr.write('usage: ./ratemyprof name\n')
    exit(1)

prof_name = sys.argv[1]

def extract_prof_id_from_html(html):

    m = re.search(r'<a href="/ShowRatings.jsp\?tid=(([0-9])+)"', html)
    return m.group(1)

def load_prof_page(pid):

    r = requests.get('http://www.ratemyprofessors.com/ShowRatings.jsp?tid={}'.format(pid))
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

print(extract_rating(prof_name))
