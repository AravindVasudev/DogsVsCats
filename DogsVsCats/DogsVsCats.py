from flask import request, redirect, url_for, render_template
from werkzeug.utils import secure_filename
import os
from . import app, allowed_file
from .classifier import classify

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file uploaded :(')
            return redirect(request.url)

        file = request.files['file']
        if file.filename == '':
            flash('No file uploaded :(')
            return redirect(request.url)

        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)

            breed = 'DOG' if classify(filepath)[0][0] else 'CAT'
            os.remove(filepath)

            return render_template('index.html', breed=breed)

    return render_template('index.html', breed='')
