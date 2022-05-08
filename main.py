from flask import Flask
import api

app = Flask(__name__)
app.secret_key = ''

app.register_blueprint(api.api, url_prefix='/api')