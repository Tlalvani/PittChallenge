import nltk
from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np

from keras.models import load_model

import json
import random
import database
import firebase_admin
import google.cloud
from firebase_admin import credentials, firestore
import requests

cred = credentials.Certificate("./key.json")
app = firebase_admin.initialize_app(cred)
fb = firestore.client()
def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
    return sentence_words

# return bag of words array: 0 or 1 for each word in the bag that exists in the sentence

def bow(sentence, words, show_details=True):
    # tokenize the pattern
    sentence_words = clean_up_sentence(sentence)
    # bag of words - matrix of N words, vocabulary matrix
    bag = [0]*len(words)
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                # assign 1 if current word is in the vocabulary position
                bag[i] = 1
                if show_details:
                    print ("found in bag: %s" % w)
    return(np.array(bag))

def predict_class(sentence, model):
    # filter out predictions below a threshold
    p = bow(sentence, words,show_details=False)
    res = model.predict(np.array([p]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i,r] for i,r in enumerate(res) if r>ERROR_THRESHOLD]
    # sort by strength of probability
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    for r in results:
        return_list.append({"intent": classes[r[0]], "probability": str(r[1])})
    return return_list

def getResponse(ints, intents_json):
    print(ints[0]['probability'])
    tag = ints[0]['intent']
    list_of_intents = intents_json['intents']
    context=None
    for i in list_of_intents:
        if(i['tag']== tag):
            if i['context'][0] != "":
                context = [{'intent': i['context'][0]}]
            result = random.choice(i['responses'])
            break
    return result, context

def chatbot_response(msg):
    ints = predict_class(msg, model)
    res, con = getResponse(ints, intents)
    return res, con



db = database.database()



model = load_model(requests.get("https://storage.googleapis.com/storingdooglemodel/chatbot_model.h5"))
classes = pickle.load(requests.get("https://storage.googleapis.com/storingdooglemodel/classes.pkl"))
intents = json.loads(requests.get("https://storage.googleapis.com/storingdooglemodel/intents.json"))
words = pickle.load(requests.get("https://storage.googleapis.com/storingdooglemodel/words.pkl"))

def hello_world(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    request_json = request.get_json()
    prof = u'QM7V3Ud0gbOK907UD2rMnMQiGCN2'
    comm = fb.collection(u'Professionals').document(prof).collection(u'Chatbot').document('Command')
    print(request_json, comm)
    res, con = chatbot_response("I want to search in a patients specific result history")
    print(res)
    if con: 
        db.action(con, res)