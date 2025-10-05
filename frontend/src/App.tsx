import React from 'react';
import Send from './pages/Send';
import Merchant from './pages/Merchant';
export default function App() {
  return (
    <div className="p-6 max-w-3xl mx-auto">
      <h1 className="text-2xl font-bold">LasavoPay — Demo</h1>
      <Send />
      <hr className="my-6" />
      <Merchant />
    </div>
  );
}
