# dctvbot
[![Code Climate](https://codeclimate.com/github/tinnvec/dctvbot/badges/gpa.svg)](https://codeclimate.com/github/tinnvec/dctvbot)  
A simple IRC bot for chatrealm, built using [Cinch](https://github.com/cinchrb/cinch)  

# Commands
`!help` - Prints available commands and their descriptions. Responds though private message.  

**diamondclub.tv commands**  
`!next` - Display next scheduled show and estimated time until it starts.  
`!now [v]` - Display channels that are currently live via user notice. Voiced and higher users can specify the `v` option to have it show in main chat.  
`!schedule [v]` - Display scheduled shows for the next 48 hours via user notice. Voiced and higher users can specify the `v` option to have it show in main chat.  

_Restricted to users with voice or higher._  
`!secs [on|off|clear|<url>]` - Executes Second Screen command or sets to `<url>`. Automatically generates a pastebin of links sent to the second screen between `on` and `off` commands.  
`!setjoin [on|off|<message>]` - Turns on/off or sets a user notice for channel join  

**Search commands**  
`!google [mode] <term>` - Returns top hit on google when searching for `<term>`. Optional `[mode]` can be one of blog, book, image, local, news, patent, or video.  
`!wiki <term>` - Searches Wikipedia for `<term>`.  
`!wolfram <query>` - Attempts to answer your `<query>` using Wolfram Alpha.  
`!urban <term>` - Returns result of Urban Dictionary search for `<term>`.  

**Control commands**  
_Restricted to users with voice or higher._  
`!turn [toys|chatter|search|dctv|all] [on|off]` - Turns the specified set of commands on or off  

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
