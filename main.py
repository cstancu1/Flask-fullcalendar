from flask import Flask, Blueprint
import api

app = Flask(__name__)
app.secret_key = 'kldsjghkjashdg89076y234978t234h9t2h29308ty*T^&**^%*YGhg'

import views

app.register_blueprint(api.api, url_prefix='/api')