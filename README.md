# ScoreVault
This project is called ScoreVault, a web application developed to allow fans, analysts, and club executives stay in touch with the world of soccer. ScoreVault aims to be a centralized location for all parties interested in soccer to find out anything about players, teams, and games. The back-end database stores data for numerous entities within the field of soccer, including players, club teams, games, stadiums, and international teams. Currently there are four main webpages that users can utilize to interact with the database.
1. Stat Page for Analysts: Analysts can view player stats and details, club team stats and details, international team stats and details, and game stats and details. Analysts can update game score on this page as well as see player or club news.
2. News Page for Analysts: Analysts can view news articles about players or clubs. Analysts can add news articles about players or clubs.
3. Player Relations page for Executives: Executives can view player information and player agent information. Executives can also edit player information about their contract end date. Additionally, executives can add or delete players here.
4. Team Relations page for Executives: Executives can view club team information and manager information. Executives can also edit game information and add games for club teams.

Additional pages can be configured using Appsmith and using existing routes or creating new routes to use. 


# Docker Set up

This repo contains setup for spinning up 3 Docker containers: 
1. A MySQL 8 container that has the ScoreVault database. This container 
2. A Python Flask container to implement a REST API to run the web application back-end endpoints
3. A Local AppSmith Server for displaying the UI for the webpages

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

# Accessing the application
Once the docker containers have been started, the appsmith webpages can be reached by going to localhost:8080 in any browser window.

To view any details page on a table, click on the row that you would like to see details for and a modal should pop up!

# Interpreting the Flask API
The endpoints for the Flask API are seperated in two blueprints: executives and analysts. These blueprints correspond to the user that is using the web application. In each blueprint, there are various endpoints/routes that are labelled by the type of request they take and their respective route. For any endpoint in the executive blueprint, the route would be localhost:8001/e/ + whatever the resource URL is for that route. For any endpoint in the analyst blueprint, the route would be localhost:8001/a/ + whatever the resource URL is for that route. 

# Video Demo 
Below is a video demo of ScoreVault.


https://drive.google.com/file/d/1rsemi1-HTGjhWNuYpHuMUCecrxr-V0RF/view?usp=sharing