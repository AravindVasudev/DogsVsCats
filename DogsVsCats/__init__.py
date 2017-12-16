from flask import Flask

UPLOAD_FOLDER = './DogsVsCats/uploads'
ALLOWED_EXTENSIONS = set(['jpg', 'jpeg', 'png'])

# App Instance
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# allowed files
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

from . import DogsVsCats
