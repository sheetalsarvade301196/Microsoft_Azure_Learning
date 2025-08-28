from flask import Flask,render_template
import pyodbc
import os

app = Flask(__name__)
try:
    conn = pyodbc.connect(
        'Driver={ODBC Driver 18 for SQL Server};'
        'Server=server-mysql.database.windows.net;'
        'Database=pocdb;'
        'UID=sheetal;PWD=Admin123;'
        'Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'
    )
except Exception as e:
    conn = None
    print("DB connection failed:", e)
    


@app.route('/')
def dashboard():
    if not conn:
        return "<h2>DB connection failed</h2>"
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM ProcessedData")
        rows = cursor.fetchall()
       return render_template('dashboard.html', rows=rows)
    except Exception as e:
        return f"<h2>Error:</h2><pre>{str(e)}</pre>"








