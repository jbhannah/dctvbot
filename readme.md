# dctvbot
A simple IRC bot for chatrealm, built using [Cinch](https://github.com/cinchrb/cinch)  
[![Code Climate](https://codeclimate.com/github/tinnvec/dctvbot/badges/gpa.svg)](https://codeclimate.com/github/tinnvec/dctvbot)  

# Commands
**diamondclub.tv commands**  
`!whatson` or `!now` - Display channels that are currently live.  
`!whatsnext` or `!next` - Display next scheduled show.  
`!schedule` - Display scheduled shows for the next 48 hours.  

**Help commands**  
`!help` or `/msg dctvbot help` - Post a short introduction and list available plugins.  
`/msg dctvbot help <plugin>` - List all commands available in a plugin.  
`/msg dctvbot help search <query>` - Search all plugin’s commands and list all commands containing <query>.  

**Random fun commands**  
_Restricted to users with voice or higher._  
`!flip [word]` - Prints tableflip emoji, when [word] is supplied, the table is replaced with flipped [word]  
`!tumbleweed` -  Prints tumbleweed characters  
`#boiled` - You got boiled. May be used mid-sentance.  

**Cleverbot commands**  
_Restricted to users with voice or higher._  
`!disablechatter` - Disables the bot's CleverBot interface.  
`!enablechatter` - Re-enables the bot's CleverBot interface.  
`!globaldisable` - Globally disables the CleverBot interface. This command can only be used by specified users (currently set to channel ops).  
`!globalenable` - Globally re-enables the interface. This command contains the same permissions as globaldisable. NOTE: This will not reset any restriction that a channel operator has imposed on the bot with the previous commands.

# Installation
```bash
git clone https://github.com/tinnvec/dctvbot.git
cd dctvbot/
bundle install
```

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
