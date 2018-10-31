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
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Weed Plant"
ENT.Author = "Mario Sinn"
ENT.Category="Drugs"
ENT.Spawnable = true
ENT.AdminSpawnable=true
function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"SpawnTime")
	self:NetworkVar("Entity",1,"owning_ent")
end