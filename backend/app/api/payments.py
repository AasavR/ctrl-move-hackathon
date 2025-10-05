from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from app.db import SessionLocal, Payment
import os, hmac, hashlib, json

router = APIRouter()

class CreatePaymentReq(BaseModel):
    sender_address: str
    receiver_address: str
    amount: int
    currency: str

@router.post('/create')
async def create_payment(req: CreatePaymentReq):
    session = SessionLocal()
    p = Payment(sender=req.sender_address, receiver=req.receiver_address, amount=req.amount, currency=req.currency, status='created')
    session.add(p)
    session.commit()
    session.refresh(p)
    # For demo: return a checkout object and suggested on-chain call (client must sign against Aptos wallet)
    return {"ok": True, "payment_id": p.id, "checkout": {"suggested_action": "call_move_create_escrow", "escrow_params": {"receiver": req.receiver_address, "amount": req.amount, "currency": req.currency}}}
