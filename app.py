from flask import Flask
import pyodbc
import os

app = Flask(__name__)

# Update with your actual SQL DB info
conn = pyodbc.connect(
    'Driver={ODBC Driver 18 for SQL Server};Server=tcp:server-mysql.database.windows.net,1433;Database=pocdb;Uid=sheetal;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'

    'Server=server-mysql.database.windows.net'
    'Database=pocdb;UID=sheetal;PWD=Admin123'
)

@app.route('/')
def dashboard():
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM ProcessedData")
    rows = cursor.fetchall()
    result = "<h2>Processed Data:</h2><ul>"
    for row in rows:
        result += f"<li>{row}</li>"
    result += "</ul>"
    return result




