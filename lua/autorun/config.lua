/*=====================================================================
== Made by Mario 'Tibba'Sinn 										 ==
== CONTACT: mariosgameroominquiries@gmail.com" 						 ==
== YOUTUBE: https://www.youtube.com/channel/UCVYG2ZDHynAXgYLP6J9hxUg ==
== STEAM: https://steamcommunity.com/profiles/76561198191730261/     ==
=======================================================================
== Please consider subscribing to my youtube channel if you end up   ==
== using this addon.												 ==
=======================================================================
== LICENSE: CC BY-NC 4.0											 ==
== https://creativecommons.org/licenses/by-nc/4.0/ 					 ==
=======================================================================*/ 

GlobalWeedConfig = {}

GlobalWeedConfig.WPPMin = 25// Minimum weed you get per plant
GlobalWeedConfig.WPPMax = 45// Maximum you can get outta a plant!

GlobalWeedConfig.WLPPMin = 5// Minimum weed you get per plant that is late
GlobalWeedConfig.WLPPMax = 15// Maximum you can get outta a plant that is late!
GlobalWeedConfig.SnoopPosition = Vector(0,0,0) // Where will snoop dogg spawn?
GlobalWeedConfig.SnoopAngle = Angle(0,0,0) // Where will snoop dogg look at?
GlobalWeedConfig.WeedHealth = 100 // How much damage can a plant endure until dying?
// {TEAM_CANCER, TEAM_GANGSTA, TEAM_POTMAKER} multiple
// {TEAM_CANCER} single
GlobalWeedConfig.DoubleClasses = {TEAM_CANCER}  // If your class is in the table you get double weed every time


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
