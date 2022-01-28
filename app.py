from flask import Flask;

app = Flask(__name__)

@app.route("/")
def hello():
    return """  <!DOCTYPE html>
                <html>
                    <head>
                        <meta charset="utf-8">
                        <title>Warsztat komputerowy</title>
                        <link type="text/css" href="proj.css" rel="stylesheet">
                    </head>
                    <h1>Projekt - Bazy Danych</h1>
                    <p>ahessesddhehe</p>
                </html>"""