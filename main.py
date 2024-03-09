from flask import Flask, render_template

app = Flask(__name__)

@app.route('/weather')
def map_page():
    return render_template('weather.html')

if __name__ == '__main__':
    app.run(debug=True)