import pyodbc
import os

# Get connection details via environment variables for security
server = os.getenv('AZURE_SQL_SERVER')  # e.g., 'yourserver.database.windows.net'
database = os.getenv('AZURE_SQL_DB')    # e.g., 'pocdb'
username = os.getenv('AZURE_SQL_USER')  # e.g., 'sheetal'
password = os.getenv('AZURE_SQL_PASS')  # -- don't hardcode sensitive info

conn_str = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    f'SERVER={server};DATABASE={database};UID={username};PWD={password};'
    'Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'
)

conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

# Read log file
log_file_path = '/home/azureuser/logfile.log'  # change to your actual path
with open(log_file_path, 'r') as f:
    for line in f:
        # Example: store each log line into a table called VMLogs
        cursor.execute("""
            INSERT INTO VMLogs (LogText)
            VALUES (?)
        """, line.strip())

conn.commit()
conn.close()
print("Logs uploaded successfully")
