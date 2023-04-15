from flask import Blueprint, request, jsonify, make_response
import json
from src import db


analysts = Blueprint('analysts', __name__)

# Get all analysts from the DB
@analysts.route('/analysts', methods=['GET'])
def get_analysts():
    cursor = db.get_db().cursor()
    cursor.execute('select first_name from Players')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get analyst detail for analyst with particular userID
@analysts.route('/analysts/<userID>', methods=['GET'])
def get_analyst(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from analysts where id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response