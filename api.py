import functools
from flask import Flask, redirect, request, session, url_for, Blueprint, render_template
from models import login_required, Booking, Medic
import json
import datetime
import time

api = Blueprint('api', __name__, template_folder='templates')

@api.route('/')
@login_required
def api_home():
    return 'TEST'

@api.route('/remove/<int:id>', methods=['POST'])
@login_required
def remove_booking(id):
    booking_id = id
    Booking.remove(booking_id)
    return 'ok'

@api.route('/unlock_days/<int:id>', methods=["POST"])
@login_required
def unlock_days(id):
    if request.method == 'POST':
        Booking.unlock_day(id)
        return url_for('index', message="Perioada deblocata cu succes!")

@api.route('/export/', methods=['POST'])
@login_required
def export():
    if request.method=='POST':
        date = request.form['date']
        start = date+'T00:01:00'
        end = date+'T00:00:00'
        med_id = request.form['med_id']
        med = Medic.by_id(med_id)
        fmt = request.form['format']
        data = Booking.get_by_med(med_id, start, end)
        bookings_list = []
    for obj in data:
        if obj.all_day == 1:
            allday = True
        else:
            allday = False
        booking = {'id' : obj.id, 'phone' : obj.phone, 'title' : obj.title, 'start' : obj.start_time,
                     'end' : obj.duration, 'allDay' : allday, 'description' : obj.investigation,
                     'cnp' : obj.cnp, 'details' : obj.obs}
        bookings_list.append(booking)
    sorted_date = sorted(bookings_list, key=lambda x: x['start'])
    return render_template('export.html', bookings = sorted_date, date = date, med = med)


@api.route('/block-days/', methods=['POST'])
@login_required
def block_days():
    if request.method=='POST':
        med_id = request.form['med_id']
        start = request.form['start']
        date = start
        end = request.form['end']
        start = start+'T00:01:00'
        end = end+'T00:00:00'        
        Booking.block(med_id, start, end, date)
    return url_for('index', message = 'Perioada blocata cu succes!')

@api.route('/get-by-med-id/<int:id>', methods=['GET'])
@login_required
def get_bookings_by_med(id):
    start = request.args.get('start')
    end = request.args.get('end')
    data = Booking.get_by_med(id, start, end)
    bookings_list = []
    for obj in data:
        if obj.all_day == 1:
            allday = True
        else:
            allday = False
        booking = {'id' : obj.id, 'phone' : obj.phone, 'title' : obj.title, 'start' : obj.start_time,
                     'end' : obj.duration, 'allDay' : allday, 'description' : obj.investigation,
                     'cnp' : obj.cnp, 'details' : obj.obs}
        bookings_list.append(booking)
    return json.dumps(bookings_list)

@api.route('/med-remove/<int:id>')
@login_required
def med_remove(id):
    Medic.remove(id)
    return redirect(url_for('index', message = 'Medic eliminat cu succes!'))

@api.route('/med-update/', methods=['POST'])
@login_required
def med_update():
    if request.method == 'POST':
        mid = request.form['update-medic-id']
        name = request.form['update-medic-name']
        start = request.form['update-medic-start']
        end = request.form['update-medic-end']
        Medic.update(name, start, end, mid)
        return redirect(url_for('index', message = 'Datele medicului cu id {} au fost modificate cu succes!'.format(mid)))

@api.route('/med-add/', methods=['POST'])
@login_required
def med_add():
    if request.method == 'POST':
        mid = request.form['update-medic-id']
        name = request.form['update-medic-name']
        start = request.form['update-medic-start']
        end = request.form['update-medic-end']
        Medic.add(name, start, end)
        return redirect(url_for('index', message = 'A fost adaugat medicul {}.'.format(name)))


@api.route('/post-add-event/', methods=['POST'])
@login_required
def post_add_event():
    details = request.json
    med_id = details['med-id']
    # PRELUCRARE DATA si ORA
    start = details['start']
    date = start.split('T')
    date = date[0]
    duration = details['duration']
    tempsplit = start.split('T')[1]
    hrs, mins, sec, timezone = tempsplit.split(':')
    start_time = datetime.time(int(hrs), int(mins))
    timedelta = datetime.timedelta(minutes=int(duration))
    y, m ,d = date.split('-')
    tmp_datetime = datetime.datetime.combine(datetime.date(int(y),int(m),int(d)), start_time)
    endtime = (tmp_datetime + timedelta).time()
    name = details['name']
    investigation = details['investigation']
    added_by = details['added_by']
    phone = details['phone']
    email = details['email']
    obs = details['obs']
    cnp = details['cnp']
    start_time = start
    end_time = date+'T'+endtime.strftime('%H:%M')+':00'
    all_day = details['all_day']
    if cnp == '':
        cnp = None
    Booking.addbooking(med_id, date, name, investigation,
    added_by, phone, email, obs, start_time, end_time, all_day, cnp)
    response = 'ok'
    return json.dumps(response)


{"med-id":"1",
"start":"2019-07-02T09:00:00",
"added_by":"1",
"email":"no_email",
"all_day":"0","name":"",
"investigation":"Recoltare",
"phone":"","obs":"",
"duration":""}