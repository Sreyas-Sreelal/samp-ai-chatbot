
import os
import aiml
from flask import Flask,redirect

k = aiml.Kernel()

if os.path.exists("brain.dump"):
    print("Loading from brain file: " + "brain.dump")
    k.loadBrain("brain.dump")
else:
    print("Parsing aiml files")
    k.bootstrap(learnFiles="sampai.aiml", commands="load aiml b")
    print("Saving brain file: " + "brain.dump")
    k.saveBrain("brain.dump")

k.setBotPredicate('master','master Sreyas')

k.setBotPredicate('botmaster','master Sreyas')
k.setBotPredicate('religion','atheism')
k.setBotPredicate('name','Cosmic')

k.setBotPredicate('BOTNAME','Cosmic')


app = Flask(__name__)

@app.route('/respond/<int:session>/<text>')
def response(session,text):
    text = text.replace("+"," ")
    print(text)
    response = k.respond(text,session)
    return response

@app.route('/delete/<int:session>')
def session_clear(session):
    k._deleteSession(session)
    print("Cleared session("+str(session)+") data")

app.run()