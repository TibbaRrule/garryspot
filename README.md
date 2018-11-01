# garryspot
A fully functional weed addon, the weed itself is a currency you collect from entities. [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/legalcode) [Full Code](https://creativecommons.org/licenses/by-nc/4.0/legalcode)

**Workshop Release:** https://steamcommunity.com/sharedfiles/filedetails/?id=1553133866

>**Features**
- A currency system that saves a count to the local server
- A NPC that will purchase currency from you with cooldowns
- DarkRP integration for jobs (double count)
- If you wear a tag you get a supporter bonus
- If you are marked as VIP you get extra percentage as bonus money on sale.

>**Is this compatible with every gamemode?**

A: Yes as long as you find a way to spawn the entity and show your pot count. Remove the class references as they won't be in your gamemode unless you wrote a macro link between your own job implementation in the gamemode. Just declare jobs as integers and give them variable names (DarkRP returns a number with DarkRP.createJob, while logging a table of job information). This explicitly implies that jobs are a part of your gamemode, you can also make the condition something else.

>**Is there any workshop addons I need?**

A: Yea I made a cannabis model [1] for it, you may have seen it on other servers, the NPC uses a Snoop Dogg Model [2].
1: https://steamcommunity.com/sharedfiles/filedetails/?id=416236698
2: https://steamcommunity.com/sharedfiles/filedetails/?id=348376962

## Config
```
GlobalWeedConfig = {}

GlobalWeedConfig.WPPMin = 25// Minimum weed you get per plant
GlobalWeedConfig.WPPMax = 45// Maximum you can get outta a plant!

GlobalWeedConfig.WLPPMin = 5// Minimum weed you get per plant that is late
GlobalWeedConfig.WLPPMax = 15// Maximum you can get outta a plant that is late!
GlobalWeedConfig.SnoopPosition = Vector(0,0,0) // Where will snoop dogg spawn?
GlobalWeedConfig.SnoopAngle = Angle(0,0,0) // Where will snoop dogg look at?
GlobalWeedConfig.WeedHealth = 100 // How much damage can a plant endure until dying?
GlobalWeedConfig.DoubleClasses = {TEAM_CANCERPATIENT}  // If your class is in the table you get double weed every time


// {TEAM_STONER, TEAM_POTPLACE} multiple
// {TEAM_STONER} single
GlobalWeedConfig.PercInc = {TEAM_CANCER}  // If your class is in the table you get the percentage increased on pickup every time by a random percentage determined by  GlobalWeedConfig.PercPlusMin &  GlobalWeedConfig.PercPlusMax
GlobalWeedConfig.PercPlusMin = 0.10 // Percentage increased minimum 
GlobalWeedConfig.PercPlusMax = 0.25 // Percentage increased maximum

GlobalWeedConfig.PoliceReward = 200 // If you are a cop you get 200 for confiscating a single weed plant!

GlobalWeedConfig.SellPrice    = 50; // How much is 1 weed worth?
GlobalWeedConfig.SellDistance = 30; // How far away from snoop can you be when selling?
GlobalWeedConfig.CooldownNonVIP	= 300;
GlobalWeedConfig.CooldownVIP	= 120;
GlobalWeedConfig.VIPIdentifier	= "[560RP]";
GlobalWeedConfig.VIPUserGroups = {
	donator		= true;
	admin		= true;
	superadmin	= true;
	owner		= true;
};
```

>Credits:
Acecool helped me learn currencies with this addon, it's only fair I release it.
