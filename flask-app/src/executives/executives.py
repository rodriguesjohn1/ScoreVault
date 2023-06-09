# Routes to define:
# /players: Post, Get
# /players/{id}: Get, Put, Delete
# /games: Post, Get
# /games/{id}: Get
# /teams: Get
# /teams/{name}/ceo: Get

from flask import Blueprint, request, jsonify, make_response
import json
from src import db


executives = Blueprint('executives', __name__)

# GET Route to get a list of players in the database


@executives.route('/players')
def getAllPlayers():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT player_id, age, first_name, last_name, position, goals, assists,'
                   + 'jersey_number, nationality, contract_end_date, team_name, international_team FROM Players')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@executives.route('/players', methods=['POST'])
def addPlayerToDB():
    reqData = request.get_json()

    playerAge = reqData['age']
    firstName = reqData['firstName']
    lastName = reqData['lastName']
    position = reqData['position']
    goals = reqData['goals']
    assists = reqData['assists']
    jerseyNumber = reqData['jerseyNumber']
    nationality = reqData['nationality']
    contractEndDate = reqData['contractEndDate']
    clubTeam = reqData['club']
    internationalTeam = reqData['internationalTeam']

    if (clubTeam == "null") & (internationalTeam != "null"):
        insert_statement = 'INSERT INTO Players (age, first_name, last_name, position, goals, assists, jersey_number, nationality, contract_end_date, team_name, international_team) VALUES ("{0}","{1}","{2}","{3}","{4}","{5}", "{6}", "{7}", "{8}", {9}, "{10}")'.format(
            playerAge,
            firstName,
            lastName,
            position,
            goals,
            assists,
            jerseyNumber,
            nationality,
            contractEndDate,
            clubTeam,
            internationalTeam)

    if (clubTeam != "null") & (internationalTeam == "null"):
        insert_statement = 'INSERT INTO Players (age, first_name, last_name, position, goals, assists, jersey_number, nationality, contract_end_date, team_name, international_team) VALUES ("{0}","{1}","{2}","{3}","{4}","{5}", "{6}", "{7}", "{8}", "{9}", {10})'.format(
            playerAge,
            firstName,
            lastName,
            position,
            goals,
            assists,
            jerseyNumber,
            nationality,
            contractEndDate,
            clubTeam,
            internationalTeam)

    if (clubTeam == "null") & (internationalTeam == "null"):
        insert_statement = 'INSERT INTO Players (age, first_name, last_name, position, goals, assists, jersey_number, nationality, contract_end_date, team_name, international_team) VALUES ("{0}","{1}","{2}","{3}","{4}","{5}", "{6}", "{7}", "{8}", {9}, {10})'.format(
            playerAge,
            firstName,
            lastName,
            position,
            goals,
            assists,
            jerseyNumber,
            nationality,
            contractEndDate,
            clubTeam,
            internationalTeam)

    if (clubTeam != "null") & (internationalTeam != "null"):
        insert_statement = 'INSERT INTO Players (age, first_name, last_name, position, goals, assists, jersey_number, nationality, contract_end_date, team_name, international_team) VALUES ("{0}","{1}","{2}","{3}","{4}","{5}", "{6}", "{7}", "{8}", "{9}", "{10}")'.format(
            playerAge,
            firstName,
            lastName,
            position,
            goals,
            assists,
            jerseyNumber,
            nationality,
            contractEndDate,
            clubTeam,
            internationalTeam)

    cursor = db.get_db().cursor()
    cursor.execute(insert_statement)
    db.get_db().commit()
    return "Success"

# Route to get a specific player


@executives.route('/players/<playerID>')
def getSpecificPlayer(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT age, first_name, last_name, position, goals, assists,'
                   + 'jersey_number, nationality, contract_end_date, team_name, international_team FROM Players WHERE player_id = ' + playerID)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to update a specific player
# Executives should only be able to update the contract end date


@executives.route('/players/<playerID>', methods=['PUT'])
def updatePlayer(playerID):
    reqData = request.get_json()

    contractEndDate = reqData['contractEndDate']

    update_Statement = 'UPDATE Players SET contract_end_date = "' + \
        contractEndDate + '" WHERE player_id = ' + playerID

    cursor = db.get_db().cursor()
    cursor.execute(update_Statement)
    db.get_db().commit()

    cursor.execute('SELECT age, first_name, last_name, position, goals, assists,'
                   + 'jersey_number, nationality, contract_end_date, team_name, international_team FROM Players WHERE player_id = ' + playerID)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to delete a player


@executives.route('/players/<playerID>', methods=['DELETE'])
def removePlayer(playerID):
    cursor = db.get_db().cursor()

    cursor.execute('SELECT count(*) FROM Players')

    data = cursor.fetchall()
    for row in data:
        initialCount = row[0]

    cursor.execute('DELETE FROM Players WHERE player_id = ' + playerID)

    db.get_db().commit()

    cursor.execute('SELECT count(*) FROM Players')

    data = cursor.fetchall()
    for row in data:
        finalCount = row[0]

    rowsDeleted = initialCount - finalCount

    return "Success. Rows deleted: " + str(rowsDeleted)

# GET Route to get a list of games in the database


@executives.route('/games')
def getGames():
    cursor = db.get_db().cursor()

    cursor.execute(
        'SELECT home_score, away_score, home_team, away_team, game_date, venue FROM Game')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Route to add a game to the database
@executives.route('/games', methods=['POST'])
def addGameToDB():
    reqData = request.get_json()

    home_team = reqData['home_team']
    away_team = reqData['away_team']
    game_date = reqData['game_date']
    venue = reqData['venue']

    insert_statement = 'INSERT INTO Game (home_team, away_team, game_date, venue) VALUES ("{0}","{1}","{2}","{3}")'.format(
        home_team,
        away_team,
        game_date,
        venue)
    cursor = db.get_db().cursor()
    cursor.execute(insert_statement)
    db.get_db().commit()
    return "Success"

# Route to get a specific game from the database


@executives.route('/games/<gameID>')
def getSpecificGame(gameID):
    cursor = db.get_db().cursor()

    cursor.execute(
        'SELECT home_score, away_score, home_team, away_team, game_date, venue FROM Game WHERE game_id = ' + gameID)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get a list of all teams in the database


@executives.route('/club')
def getAllTeams():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Club')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get the ceo information for a ceo of a specific team


@executives.route('/club/<clubName>/ceo')
def getCEOInfo(clubName):
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM CEO WHERE team_name = "' + clubName + '"')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get Manager info about the manager of a specific club


@executives.route('/managers/<clubName>')
def getManagerInfo(clubName):
    cursor = db.get_db().cursor()

    cursor.execute(
        'SELECT first_name, last_name, team_name, age, salary, contract_end_date FROM Manager WHERE team_name = "{0}"'.format(clubName))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get a list of all stadiums


@executives.route('/stadiums')
def getStadiums():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Stadium')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get player agent info for a specifc player


@executives.route('/players/agent/<playerID>')
def getAgentInfo(playerID):
    cursor = db.get_db().cursor()
    cursor.execute(
        'SELECT first_name, last_name, email, phone, company FROM Agent WHERE player_id = ' + playerID)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Route to get a list of games by team name


@executives.route('/games/club/<clubName>')
def getGamesByTeam(clubName):
    cursor = db.get_db().cursor()

    cursor.execute(
        'SELECT home_score, away_score, home_team, away_team, game_date, venue FROM Game WHERE home_team = "{0}" OR away_team = "{0}"'.format(clubName))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
