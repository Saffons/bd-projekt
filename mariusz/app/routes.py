from app import app
from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)

@app.route("/")
def index():
    return render_template("home.html", title="Home")