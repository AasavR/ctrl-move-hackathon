Architecture Overview (text + ASCII diagram)

Frontend (React) <--> Backend (FastAPI) <--> Aptos (Move Contracts)
                            |                      |
                            |                      +-- PaymentEscrow.move
                            |                      +-- MerchantRegistry.move
                            |                      +-- StablecoinSwap.move
                            |
                            +-- Nodit Webhooks (on-chain events)
                            +-- Hyperion SDK (liquidity)

Security notes:
- Keep private keys in environment variables
- Use server-side signing only when necessary; prefer client-side wallet signing for UX
