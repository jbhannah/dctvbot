# dctvbot
[![Code Climate](https://codeclimate.com/github/tinnvec/dctvbot/badges/gpa.svg)](https://codeclimate.com/github/tinnvec/dctvbot)  
A simple IRC bot for chatrealm, built using [Cinch](https://github.com/cinchrb/cinch)  

# Commands
`!help` - Prints available commands and their descriptions. Responds though private message.

**diamondclub.tv commands**  
`!now` - Display channels that are currently live via user notice.  
`!next` - Display next scheduled show and estimated time until it starts.  
`!schedule [v]` - Display scheduled shows for the next 48 hours via user notice. Voiced and higher users can specify the v flag to have it show in main chat.  

_Restricted to users with voice or higher._  
`!secs [on|off|clear|<url>]` - Executes Second Screen command or sets to `<url>`.  

**Search commands**  
`!google <term>` - Returns the top hit on google for `<term>`.  
`!wikipedia <term>` - Searches wikipedia for `<term>`.  
`!wolfram <query>` - Attempts to answer your `<query>` using Wolfram Alpha.  

**Control commands**  
_Restricted to users with voice or higher._  
`!toysoff` / `!toyson` - Disable/enable the toys  
`!chatteroff` / `!chatteron` - Disable/enable the CleverBot interface.  
`!searchoff` / `!searchon` - Disable/enable search commands.  
`!dctvoff` / `!dctvon` - Disable/enable diamondclub.tv commands.  
`!lockdown` / `!lockdownoff` - Disable/enable all commands in case of emergency.  

# Installation
```bash
git clone https://github.com/tinnvec/dctvbot.git
cd dctvbot/
bundle install
```

# Configuration
```bash
cp config.sample.yml config.yml
```
Then edit `config.yml` and fill in with desired details. If you want bot to identify itself, you must first register the nick manually with the server.  

# Usage
```bash
ruby dctvbot.rb
```

# Heroku Setup
```bash
heroku create
git push heroku master
heroku scale web=0
heroku scale bot=1
```
`Procfile` will be read by Heroku and used to start the script.
