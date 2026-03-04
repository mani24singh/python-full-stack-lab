# Script 1
from flask import Flask
'''
It creates an instance of the flask class,
which will be our WSGI (Web Server Gateway Interface) application.
'''

# WSGI application
app = Flask(__name__)

@app.route("/")
def welcome():
    return "Welcome to this best Flask Course. This should be an amazing course."

@app.route("/index")
def index():
    return "Welcome to the index page"

if __name__=='__main__':
    app.run(debug=True)