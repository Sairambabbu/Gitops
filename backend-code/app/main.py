from fastapi import FastAPI
import logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
logger.info("Starting FastAPI app...")
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "message": "FastAPI app is running!",
        "env": {
            "DB_HOST": os.getenv("DB_HOST"),
            "DB_PORT": os.getenv("DB_PORT"),
            "DB_USER": os.getenv("DB_USER"),
            "DB_NAME": os.getenv("DB_NAME")
        }
    }

@app.get("/secret")
def read_secret():
    db_password = os.getenv("DB_PASSWORD", "Not set")
    return {"DB_PASSWORD": db_password}

# ✅ Required by frontend
@app.get("/api/message")
def get_message():
    return {"message": "Hello from backend!"}
