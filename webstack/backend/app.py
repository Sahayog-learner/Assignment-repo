from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return {
        "message": "Hello from Flask backend!",
        "status": "running"
    }

@app.route("/health")
def health():
    return {
        "status": "healthy"
    }

@app.route("/db-test")
def db_test():
    return {
        "database": "PostgreSQL service available",
        "host": os.getenv("DB_HOST", "not-configured")
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
