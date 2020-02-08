#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bs4 import BeautifulSoup
import mysql.connector
import os


# not used in code, but for reference
# VISA_TYPE_IDX = 2
# VISA_ENTRY_IDX = 3
# CONSULATE_IDX = 4
# MAJOR_IDX = 5
# STATUS_IDX = 6
# CHECK_DATE_IDX = 7
# COMPLETE_DATE_IDX = 8
# WAIT_DAYS_IDX = 9
DIR = "data/"

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="H1B"
)

mycursor = mydb.cursor()

for filename in os.listdir(DIR):
    if filename.endswith(".htm"):
        # Must be ISO-8859-1 instead of utf-8
        original_html = open(DIR + filename, encoding = "ISO-8859-1").read()
        soup = BeautifulSoup(original_html, "html.parser")
        # Each record is in a <tr> tag
        for tr in soup.find_all('tr'):
            try:
                content = {}
                for idx, val in enumerate(tr.children):
                    # Kind of ugly, but these are indexes of those attributes that we care
                    if idx >= 2 and idx <= 9:
                        content[idx] = val.__dict__.get("contents")[0]
                sql = "INSERT INTO `H1B-status` (`visa-type`, `visa-entry`, `consulate`, `major`, `status`, `check-date`, `complete-date`, `waiting-days`)" +\
                      " VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', %s)"
                vals = []
                for i in range(2, 10):
                    vals.append(content.get(i))
                vals = tuple(vals)
                mycursor.execute(sql % vals)
            except Exception as e:
                print(str(e))
        mydb.commit()


