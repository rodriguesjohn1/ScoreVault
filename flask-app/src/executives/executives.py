from flask import Blueprint, request, jsonify, make_response
import json
from src import db


executives = Blueprint('executives', __name__)

# Get all the executives from the database
@executives.route('/executives', methods=['GET'])
def get_executives():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of executives
    cursor.execute('SELECT id, executive_code, executive_name, list_price FROM executives')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get the top 5 executives from the database
@executives.route('/mostExpensive')
def get_most_pop_executives():
    cursor = db.get_db().cursor()
    query = '''
        SELECT executive_code, executive_name, list_price, reorder_level
        FROM executives
        ORDER BY list_price DESC
        LIMIT 5
    '''
    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)