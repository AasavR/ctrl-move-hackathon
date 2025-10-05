from fastapi import APIRouter, Request, Header, HTTPException
from app.db import SessionLocal, Payment
import os, hmac, hashlib, json

router = APIRouter()

NODIT_SECRET = os.getenv('NODIT_SECRET', 'changeme')

def verify_nodit_signature(body_bytes: bytes, signature_header: str) -> bool:
    if not signature_header:
        return False
    computed = hmac.new(NODIT_SECRET.encode(), body_bytes, hashlib.sha256).hexdigest()
    return hmac.compare_digest(computed, signature_header)

@router.post('/nodit')
async def nodit_webhook(request: Request, x_signature: str = Header(None)):
    body = await request.body()
    if not verify_nodit_signature(body, x_signature):
        raise HTTPException(status_code=401, detail='invalid signature')
    payload = await request.json()
    # parse events, update payments status accordingly (demo maps event with escrow id -> payment)
    # For simplicity assume payload contains {"event": "escrow_claimed", "payment_id": <id>}
    event = payload.get('event')
    session = SessionLocal()
    if event == 'escrow_claimed':
        pid = payload.get('payment_id')
        p = session.query(Payment).filter(Payment.id == pid).first()
        if p:
            p.status = 'claimed'
            session.commit()
    return {"ok": True}
