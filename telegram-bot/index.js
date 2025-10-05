const { Telegraf } = require('telegraf');
const fetch = require('node-fetch');
const bot = new Telegraf(process.env.TELEGRAM_BOT_TOKEN);
bot.start((ctx) => ctx.reply('Welcome to LasavoPay! Use /pay <address> <amount> to send USDC'));
bot.command('pay', async (ctx) => {
  const args = ctx.message.text.split(' ');
  if (args.length < 3) return ctx.reply('Usage: /pay <address> <amount>');
  const [_, address, amount] = args;
  const resp = await fetch(`${process.env.BACKEND_URL || 'http://localhost:8000'}/payments/create`, {
    method: 'POST', headers: {'content-type': 'application/json'}, body: JSON.stringify({ sender_address: ctx.from.id.toString(), receiver_address: address, amount: parseInt(amount), currency: 'USDC' })
  });
  const data = await resp.json();
  ctx.reply(`Payment created: ${data.payment_id}. Open demo UI to sign and complete.`);
});
bot.launch();
console.log('Telegram bot started');
