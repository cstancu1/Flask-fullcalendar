from hashlib import md5
import pymysql
from flask import redirect, url_for, session
from functools import wraps
import gspread
from oauth2client.service_account import ServiceAccountCredentials
import json

#def google_backup(med_id, date, name, investigation, added_by, phone, 
 #                   email, obs, start_time, end_time, all_day, cnp):
  #  scope = ['https://spreadsheets.google.com/feeds',
   #      'https://www.googleapis.com/auth/drive']
    #creds = ServiceAccountCredentials.from_json_keyfile_name('credentials.json', scope)
    #client = gspread.authorize(creds)
    #row = [med_id, date, name, investigation, added_by, phone, 
    #        email, obs, start_time, end_time, all_day, cnp]
    #sheet = client.open_by_key('').sheet1
    #sheet.insert_row(row)

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


class Database:
    def __init__(self):
        host = 'localhost'
        user = 'dispensarizare'
        password = ''
        db = ''

        self.con = pymysql.connect(host = host, user = user, password = password, db = db,
                    cursorclass = pymysql.cursors.DictCursor)

        self.cur = self.con.cursor()

class User:
    def __init__(self, user_id, user_type, user_meds):
        self.user_id = user_id
        self.user_type = user_type
        self.user_meds = user_meds
        self.med_list = []
        db = Database()
        db.cur.execute("SELECT * FROM medic")
        db.con.close()
        meds = db.cur.fetchall()
        for med in meds:
            if str(med['id']) in str(self.user_meds):
                medic = Medic(med['id'], med['name'], med['start'], med['end'])
                self.med_list.append(medic)
            else:
                continue

    def login_user(username, password):
        user = None
        password = password.encode('utf-8')
        password = md5(password).hexdigest()
        db = Database()
        db.cur.execute("SELECT * FROM users WHERE username = %s", username)
        user = db.cur.fetchone()
        if user == None or password == None:
            db.con.close()
            return False
        else:
            if user['username']==username:
                db.cur.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
                data = db.cur.fetchone()
                if data != None:
                    if data['username']==username:
                        session['logged_in'] = 'True'
                        session['id'] = data['id']
                        session['type'] = data['type']
                        session['medics'] = data['medics']
                        return True
                else:
                    db.con.close()
                    return False
            else:
                db.con.close()
                return False

class Medic:
    def __init__(self, id, name, start, end):
        self.id = id
        self.name = name
        self.start = start
        self.end = end

    def get_list():
        db = Database()
        db.cur.execute("SELECT * FROM medic")
        data = db.cur.fetchall()
        db.con.close()
        medic_list = []
        for row in data:
            medic_list.append(Medic(row['id'], row['name'], row['start'], row['end']))
        return medic_list

    def by_id(med_id):
        db=Database()
        db.cur.execute("SELECT * FROM medic WHERE id = %s", med_id)
        medic = db.cur.fetchone()
        return medic

    def remove(id):
        db = Database()
        db.cur.execute("DELETE FROM medic WHERE id = %s", id)
        db.con.close()

    def add(name, start, end):
        db = Database()
        db.cur.execute("INSERT INTO medic(name, start, end) VALUES(%s, %s, %s)", (name, start, end))
        db.con.close()

    def update(name, start, end, id):
        db = Database()
        db.cur.execute("UPDATE medic SET name=%s, start=%s, end=%s WHERE id = %s", (name, start, end, id))
        db.con.close()
        
class Booking:
    def __init__(self, id, med_id, date, name, investigation, added_by, phone, email, obs, canceled, start_time, duration, all_day, cnp):
        self.id = id
        self.med_id = med_id
        self.start = date
        self.title = name
        self.investigation = investigation
        self.added_by = added_by
        self.phone = phone
        self.email = email
        self.obs = obs
        self.canceled = canceled
        self.start_time = start_time
        self.duration = duration
        self.all_day = all_day
        self.cnp = cnp

    def searchbyterm(term):
        db = Database()
        db.cur.execute("SELECT * FROM bookings WHERE name LIKE %s or cnp LIKE %s or phone LIKE %s or investigation LIKE %s", (term, term, term, term))
        data = db.cur.fetchall()
        results_list = []
        for row in data:
            booking = Booking(row['id'], row['med_id'], row['date'], row['name'], row['investigation'], 
                            row['added_by'], row['phone'], row['email'], row['obs'], row['canceled'], row['start_time'], row['end'], row['all_day'], row['cnp'])
            results_list.append(booking)
        db.con.close()
        return results_list

    def unlock_day(id):
        db = Database()
        db.cur.execute("DELETE FROM bookings WHERE id = %s", id)
        db.con.close()

    def remove(id):
        db = Database()
        db.cur.execute("""DELETE FROM bookings WHERE id = %s""", id)
        db.con.close()

    def get_by_med(med_id, start, end):
        db = Database()
        start_day, start_month, start_year = start.split('T')[0].split('-')
        start_ed = start_day + '-' + start_month + '-' + start_year
        end_day, end_month, end_year = end.split('T')[0].split('-')
        end_ed = end_day + '-' + end_month + '-' + end_year
        db.cur.execute("SELECT * FROM bookings WHERE med_id = %s AND date BETWEEN CAST(%s AS DATE) AND CAST(%s AS DATE)", (med_id, start_ed, end_ed))

        data = db.cur.fetchall()
        bookings_list = []
        for row in data:
            booking = Booking(row['id'], row['med_id'], row['date'], row['name'], row['investigation'], 
                            row['added_by'], row['phone'], row['email'], row['obs'], row['canceled'], row['start_time'], row['end'], row['all_day'], row['cnp'])
            bookings_list.append(booking)
        db.con.close()
        return bookings_list

    def block(med_id, start, end, date):
        db = Database()
        db.cur.execute("""INSERT INTO bookings(med_id, date, name, investigation, added_by, phone, email, obs, canceled, start_time, end, all_day, cnp)
                        VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) """, (med_id, date, 'BLOCAT', 'XXXX', '1', '0000000000', '0', '-', '0', start, end, '1', '0000000000000'))
        db.con.close()

    def addbooking(med_id, date, name, investigation, added_by, phone, 
        email, obs, start_time, end_time, all_day, cnp):
        db = Database()
        db.cur.execute("""INSERT INTO BOOKINGS(med_id, date, name, investigation,
        added_by, phone, email, obs, start_time, end, all_day, cnp) VALUES(%s, %s, %s, %s, %s, %s, 
        %s, %s, %s, %s, %s, %s) """, (med_id, date, name, investigation, added_by, phone, 
        email, obs, start_time, end_time, all_day, cnp))
        db.con.close()
        try:
            pass
            #google_backup(med_id, date, name, investigation, added_by, phone, 
            #email, obs, start_time, end_time, all_day, cnp)
        except:
            pass

        # UPLOAD IN GOOGLE DRIVE/ SPREADSHEETS


