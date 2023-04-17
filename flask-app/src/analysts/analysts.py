from flask import Blueprint, request, jsonify, make_response
import json
from src import db


analysts = Blueprint('analysts', __name__)


##########################################################
#################       GET ROUTES:
##########################################################

# Get all players from the DB


@analysts.route('/players', methods=['GET'])
def get_analysts():
    cursor = db.get_db().cursor()
    cursor.execute('select player_id, first_name, last_name, age, goals, '
                   + 'assists, team_name, international_team from Players')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get player detail for player with particular first name and last name


@analysts.route('/players/<playerID>', methods=['GET'])
def get_analyst(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('select player_id, first_name, last_name, age, goals, '
                   + 'assists, team_name, international_team from Players where player_id="{0}"'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all clubs from the DB


@analysts.route('/clubs', methods=['GET'])
def get_clubs():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Club')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get club detail for club with particular team name


@analysts.route('/clubs/<teamName>', methods=['GET'])
def get_club(teamName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Club where team_name="{0}"'.format(teamName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all players on club teams from the DB


@analysts.route('/clubs/<teamName>/roster', methods=['GET'])
def get_clubs_roster(teamName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Club join '
                   + 'Players p on Club.team_name = '
                   + 'p.team_name where p.team_name="{0}"'.format(teamName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all international teams from the DB


@analysts.route('/internationalteams', methods=['GET'])
def get_intlTeams():
    cursor = db.get_db().cursor()
    cursor.execute('select * from InternationalTeam')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all players on international teams from the DB


@analysts.route('/internationalteams/<teamName>/roster', methods=['GET'])
def get_intlTeams_roster(teamName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from InternationalTeam join '
                   + 'Players p on InternationalTeam.country = '
                   + 'p.international_team where p.international_team="{0}"'.format(teamName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get International Team detail for International Team with particular team nickname


@analysts.route('/internationalteams/<teamName>', methods=['GET'])
def get_intlTeam(teamName):
    cursor = db.get_db().cursor()
    cursor.execute(
        'select * from InternationalTeam where nickname="{0}"'.format(teamName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all stadiums from the DB


@analysts.route('/stadiums', methods=['GET'])
def get_stadiums():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Stadium')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get Stadiums detail for Stadiums with particular Stadium name


@analysts.route('/stadiums/<stadiumName>', methods=['GET'])
def get_stadium(stadiumName):
    cursor = db.get_db().cursor()
    cursor.execute(
        'select * from Stadium where stadium_name="{0}"'.format(stadiumName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all Games from the DB


@analysts.route('/games', methods=['GET'])
def get_games():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Game')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get Games detail for Games with particular Game id


@analysts.route('/games/<gameID>', methods=['GET'])
def get_game(gameID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Game where game_id="{0}"'.format(gameID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all News from the DB


@analysts.route('/news', methods=['GET'])
def get_allNews():
    cursor = db.get_db().cursor()
    cursor.execute('select * from News')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@analysts.route('/news/<newsID>', methods=['GET'])
def get_news_detail(newsID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from News where news_id={0}'.format(newsID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get Players News with particular player ID


@analysts.route('/news/player/<playerID>', methods=['GET'])
def get_player_news(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from News join Player_News pn on '
                   + 'News.news_id = pn.news_id where player_id={0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get Club News with particular club ID


@analysts.route('/news/club/<teamName>', methods=['GET'])
def get_team_news(teamName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from News join Team_News tn on '
                   + 'News.news_id = tn.news_id where team_name="{0}"'.format(teamName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response



##########################################################
#################       POST ROUTES:
##########################################################



# Post a news article


@analysts.route('/news', methods=['POST'])
def post_news():
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('insert into News(outlet,author_first,author_last,title,article_description,news_date) VALUES ("{0}","{1}","{2}","{3}","{4}","{5}")'.format(
        request.json["outlet"],
        request.json["author_first"],
        request.json["author_last"],
        request.json["title"],
        request.json["article_description"],
        request.json["news_date"]))
    database.commit()

    cursor.execute('select * from News order by news_id desc limit 1')

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 201
    the_response.mimetype = 'application/json'

    return the_response

# Connect News Article to Team


@analysts.route('/news/club/<teamName>', methods=['POST'])
def post_team_news(teamName):
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('insert ignore into Team_News(team_name,news_id) VALUES("{0}","{1}")'.format(
        teamName, request.json["news_id"]))
    database.commit()

    cursor.execute(
        'select * from News where news_id={0}'.format(request.json["news_id"]))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 201
    the_response.mimetype = 'application/json'

    return the_response

# Connect News Article to Player


@analysts.route('/news/player/<playerID>', methods=['POST'])
def post_player_news(playerID):
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('insert ignore into Player_News(player_id,news_id) VALUES("{0}","{1}")'.format(
        playerID, request.json["news_id"]))
    database.commit()

    cursor.execute(
        'select * from News where news_id={0}'.format(request.json["news_id"]))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 201
    the_response.mimetype = 'application/json'

    return the_response

##########################################################
#################       DELETE ROUTES:
##########################################################

# Delete a news article


@analysts.route('/news', methods=['DELETE'])
def delete_news():
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('delete from News where news_id={0}'.format(
        request.json["news_id"]))
    database.commit()

    the_response = make_response()
    the_response.status_code = 204
    the_response.mimetype = 'application/json'

    return the_response

# Delete a news article from club


@analysts.route('/news/club', methods=['DELETE'])
def delete_club_news():
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('delete from Team_News where news_id={0}'.format(
        request.json["news_id"]))
    database.commit()

    the_response = make_response()
    the_response.status_code = 204
    the_response.mimetype = 'application/json'

    return the_response

# Delete a news article from player


@analysts.route('/news/player', methods=['DELETE'])
def delete_player_news():
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('delete from Player_News where news_id={0}'.format(
        request.json["news_id"]))
    database.commit()

    the_response = make_response()
    the_response.status_code = 204
    the_response.mimetype = 'application/json'

    return the_response


##########################################################
#################       PUT ROUTES:
##########################################################


# Update Player Stats
@analysts.route('/players/<playerID>', methods=['PUT'])
def put_player_stats(playerID):
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('update Players set goals={0},assists={1} where player_id={2}'.format(
        request.json["goals"], request.json["assists"], playerID))
    database.commit()

    cursor.execute('select player_id, first_name, last_name, age, goals, '
                   + 'assists, team_name, international_team from Players where player_id="{0}"'.format(playerID))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response

# Update Game Stats


@analysts.route('/games/<gameID>', methods=['PUT'])
def put_game_stats(gameID):
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('update Game set home_score={0},away_score={1} where game_id={2}'.format(
        request.json["home_score"], request.json["away_score"], gameID))
    database.commit()

    cursor.execute('select * from Game where game_id="{0}"'.format(gameID))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response

# Update News


@analysts.route('/news/<newsID>', methods=['PUT'])
def put_news(newsID):
    cursor = db.get_db().cursor()
    database = db.get_db()

    cursor.execute('update News set outlet="{0}",author_first="{1}",author_last="{2}",title="{3}",article_description="{4}" where news_id={5}'.format(
        request.json["outlet"], request.json["author_first"], request.json["author_last"], request.json["title"], request.json["article_description"], newsID))

    database.commit()

    cursor.execute('select * from News where news_id={0}'.format(newsID))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response
