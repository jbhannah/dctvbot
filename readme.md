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
`!setjoin [on|off|status|<message>]` - Turns on/off, displays status of, or sets a user notice when they join the channel  

**Control commands**  
_Restricted to users with voice or higher._  
`!turn [toys|chatter|search|dctv|all] [on|off]` - Turns the specified set of commands on or off
