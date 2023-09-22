# WhatsappBot
A whatsapp bot for Linux built with on GNU and X11 tools

This very simple bot can send upwards of 200 messages per hour on Whatsapp.

To use it you should download a whatsapp client for Linux such as Franz, and simply run the bot with ./whatsapp.sh

Then adjust the coordinates of where the mouse moves to according to your screen size - the basic flow is:

1. Click on New Chat
2. Paste a number from a database that you have (in this case we use sqlite3 command line utility)
3. Take a screenshot and analyse the color of the mouse location to see if the number has a Whatsapp account
4. If so, create new chat
5. Type and send a message
6. Go back
7. Restart

BEWARE: This is a tool used purely for experimentation and you can do with it as you'd like. I do not take responsibility if your account is banned.
