import React, { useState } from 'react';
import axios from 'axios';
export default function Send(){
  const [to, setTo] = useState('');
  const [amount, setAmount] = useState('');
  const [msg, setMsg] = useState('');
  const handleSend = async ()=>{
    const res = await axios.post('/api/payments/create', { sender_address: 'demo_sender', receiver_address: to, amount: parseInt(amount), currency: 'USDC' });
    setMsg('Payment created: '+res.data.payment_id);
  }
  return (<div>
    <h2 className="text-lg">Send USDC</h2>
    <input placeholder="Receiver" value={to} onChange={e=>setTo(e.target.value)} className="border p-2"/>
    <input placeholder="Amount" value={amount} onChange={e=>setAmount(e.target.value)} className="border p-2 ml-2"/>
    <button onClick={handleSend} className="ml-2 bg-blue-600 text-white p-2 rounded">Create Payment</button>
    <p>{msg}</p>
  </div>)
}
