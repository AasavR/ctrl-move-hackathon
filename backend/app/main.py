from fastapi import FastAPI
from app.api import payments, webhooks
from app.db import init_db
import os

app = FastAPI(title="LasavoPay Backend")

init_db(os.getenv('DATABASE_URL', 'sqlite:///./lasavopay.db'))

app.include_router(payments.router, prefix="/payments")
app.include_router(webhooks.router, prefix="/webhooks")

@app.get('/')
async def root():
    return {"status": "LasavoPay backend running"}
