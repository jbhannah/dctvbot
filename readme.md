# dctvbot
[![Code Climate](https://codeclimate.com/github/tinnvec/dctvbot/badges/gpa.svg)](https://codeclimate.com/github/tinnvec/dctvbot)  
A simple IRC bot for chatrealm, built using [Cinch](https://github.com/cinchrb/cinch)  

# Commands
`!help` - Replies with a private message listing available commands.  
`!google <term>` - Returns the top hit on google for <term>.  
`!wolfram <query>` - Attempts to answer your <query> using Wolfram Alpha.  

**diamondclub.tv commands**  
`!now` - Display channels that are currently live.  
`!next` - Display next scheduled show.  
`!schedule` - Display scheduled shows for the next 48 hours.  
  
**Cleverbot commands**  
_Restricted to users with voice or higher._  
`!disablechatter` - Disables the bot's CleverBot interface.  
`!enablechatter` - Re-enables the bot's CleverBot interface.  

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
Then edit `config.yml` and fill in with desired details. If you want bot to identify itself, you must register the nick manually first.  

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
