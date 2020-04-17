# README

## Description
David, describe your baby here!

This application utilizes Ruby on Rails, JavaScript, HTML, CSS, Materialize, and authentication via OmniAuth.
## [View Ghost Diary in Heroku](https://turing-ghost-diary.herokuapp.com/)
<img width="1389" alt="Ghost Diary Homepage" src="app/assets/images/ghost_diary_homepage.png">

## Schema
![Alt text](app/assets/images/ghost_diary_db_diagram.png)

## Getting Started

To run Ghost Diary on your local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

$ git clone https://github.com/d-atkins/ghost-diary-gateway.git   
$ cd ghost-diary-gateway  
$ bundle   
$ rails db:{drop,create,migrate,seed}   
$ bundle exec figaro install   
## Environment Variable Setup:
##### You will need access to the following:
* Sign up for a Tone Analyzer key:
> [Watson Tone Analyzer](https://www.ibm.com/watson/services/tone-analyzer/)
* Sign up for a Google API key:
> [Google Calendar](https://support.google.com/googleapi/answer/6158862?hl=en)     
* Follow the directions for step 1 in the following resource to retrieve github id and secret:
> [Github Client](https://paw.cloud/docs/examples/github-api)

Add the following to your `config/application.yml` file. Insert the relevant values in place of 'insert_here'.  

GITHUB_CLIENT_ID: 'insert_here'   
GITHUB_CLIENT_SECRET: 'insert_here'   
ANALYZER_API_KEY: 'insert_here'   
GOOGLE_API_KEY: 'insert_here'   
TONE_SERVICE_DOMAIN: https://turing-ghost-tone.herokuapp.com  
## Tests
To run the test suite, run the following command: `bundle exec rspec`.
## Deployment
To view Ghost Diary in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.
To view the application in production, go to [Heroku Ghost Diary](https://turing-ghost-diary.herokuapp.com/)  

## Tools
* OmniAuth
* Travis CI
* SimpleCov
* PostgreSQL
* Capybara
* Github
* Faraday
* Postman
* Figaro   
## Authors
* [David Atkins](https://github.com/d-atkins)
* [Elom Amouzou](https://github.com/eamouzou)
* [Jenny Klich](https://github.com/jklich151)
* [Maria Ronauli](https://github.com/mronauli)
## Acknowledgments
* [Brian Zanti](https://github.com/BrianZanti)
* [Dione Wilson](https://github.com/dionew1)
### [Project Specifications Link](https://backend.turing.io/module3/projects/terrificus/)     


Things to add???

(Ruby version, System dependencies, Configuration, Database creation, Database initialization, How to run the test suite, Services (job queues, cache servers, search engines, etc.), Deployment instructions)
