#dctvbot
A simple IRC bot for chatrealm, built using [Cinch](https://github.com/cinchrb/cinch)

## diamondclub.tv commands
`!whatson` or `!now` - Display what is currently live on diamondclub.tv  
`!whatsnext` or `!next` - Display the next scheduled show for Channel 1 http://diamondclub.tv/#1  
`!schedule` - Display the scheduled shows for the next 48 hours for Channel 1 http://diamondclub.tv/#1

## Help commands
`!help` or `/msg dctvbot help` - Post a short introduction and list available plugins.  
`/msg dctvbot help <plugin>` - List all commands available in a plugin.  
`/msg dctvbot help search <query>` - Search all plugin’s commands and list all commands containing <query>.  

## Random fun commands
**Restricted to users with voice or higher.**  
`!flip [word]` - Prints tableflip emoji, when [word] is supplied, the table is replaced with flipped [word]  
`!tumbleweed` -  Prints tumbleweed characters  
`#boiled` - You got boiled. May be used mid-sentance.  

## Cleverbot commands
**Restricted to users with voice or higher.**  
`!disablechatter` - Disables the bot's CleverBot interface.  
`!enablechatter` - Re-enables the bot's CleverBot interface.  
`!globaldisable` - Globally disables the CleverBot interface. This command can only be used by specified users (currently set to channel ops).  
`!globalenable` - Globally re-enables the interface. This command contains the same permissions as globaldisable. NOTE: This will not reset any restriction that a channel operator has imposed on the bot with the previous commands.
