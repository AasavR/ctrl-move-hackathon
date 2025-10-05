import { AptosClient, AptosAccount, TxnBuilderTypes, BCS } from 'aptos';

const RPC = process.env.VITE_APTOS_RPC || 'https://fullnode.devnet.aptoslabs.com';
export const client = new AptosClient(RPC);

export async function sendSimpleTransfer(senderAccount: AptosAccount, receiverAddr: string, amount: string) {
  // Example: use coin transfer payload (USDC on Aptos requires token module address)
}
