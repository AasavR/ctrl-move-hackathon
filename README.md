# LasavoPay — CTRL+MOVE Hackathon

LasavoPay brings UPI-like UX to stablecoin payments on Aptos: P2P transfers, merchant QR payments, Telegram-first UX, and liquidity-backed swaps.

## Quickstart (dev)

### Prereqs
- Node 18+
- Python 3.10+
- Aptos CLI (optional for local testnet or devnet interactions)

### 1) Backend (FastAPI)
```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### 2) Frontend
```bash
cd frontend
npm install
npm run dev
```

### 3) Telegram bot (for demo)
```bash
cd telegram-bot
npm install
node index.js
```

### 4) Contracts (Move)
- Use Aptos CLI / Move tooling to compile and publish contracts to devnet. See `contracts/` for stubs.

## Submission
See `DORAHACKS_SUBMISSION.md` for the DoraHacks submission text and links.
