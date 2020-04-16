from main import app, api
import models
from models import User, Medic, Booking
from flask import redirect, url_for, render_template, session, request, Blueprint
from functools import wraps

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not session:
            return redirect(url_for('login'))
        else:
            global current_user
            current_user = User(session['id'], session['type'], session['medics'])
            global medics
            global medics_menu
            medics_menu = []
            medics = Medic.get_list()
            for medic in medics:
                if str(medic.id) in current_user.user_meds:
                    medics_menu.append(medic)
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
@login_required
def index():
    message = None
    if request.args.get('message'):
        message = request.args.get('message')
    return render_template('index.html',current_user = current_user, medics_menu = medics_menu, medics = medics, message = message)

@app.route('/raport/<int:id>')
@login_required
def raport(id):
    current_medic = None
    id = id
    for medic in medics_menu:
        if medic.id == id:
            current_medic = medic

    return render_template('raport.html', medics_menu = medics_menu, medics = medics, current_medic = current_medic, current_user = current_user)

@app.route('/search/', methods=['POST'])
@login_required
def search():
    if request.method=='POST':
        term = request.form['term']
        results = Booking.searchbyterm(term)
        return render_template('search.html', results = results, medics_menu = medics_menu, medics = medics, current_user = current_user)

@app.route('/calendar/<int:id>')
@login_required
def calendar(id):
    current_medic = None
    id = id
    for medic in medics_menu:
        if medic.id == id:
            current_medic = medic

    return render_template('calendar.html', medics_menu = medics_menu, medics = medics, current_medic = current_medic, current_user = current_user)

@app.route('/login/', methods=['GET', 'POST'])
def login():
    if request.method=='POST':
        username = request.form['username']
        password = request.form['password']
        check = User.login_user(username, password)
        if check != False:
            return redirect(url_for('index'))
        else:
            return render_template('login.html', message = 'Date de autentificare incorecte!')
    return render_template('login.html')

@app.route('/logout/')
def logout():
    session.pop('logged_in', None)
    session.pop('id', None)
    session.pop('type', None)
    session.pop('medics', None)
    return redirect(url_for('index'))