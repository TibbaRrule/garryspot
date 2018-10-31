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
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	include("shared.lua")

	util.AddNetworkString("opendrugdealermenu")

	function ENT:Initialize()
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetModel("models/snoopdogg.mdl")
		self:DrawShadow(true)
		self:SetUseType(SIMPLE_USE)	
		self:DropToFloor()
	end

	function ENT:Use(activator, ent)
		if !activator:isCP() then
			net.Start("opendrugdealermenu")
			net.Send( activator )
		end	
		
		
	end
/*
	local NPCPositionTable = {
		{name = "near the Downtown Industrial!",pos = Vector(-1087.999878, 2030.118530, -196), ang = Angle(0,30,0), animid = 7}, // Next To Ghetto Houses
		//{name = "behind the apartments!",pos = Vector(-643.999878, 7181.118530, -198.968750), ang = Angle(0,-140,0), animid = 7}, 
	}
	local _data = table.Random( NPCPositionTable );
	

function ENT:Think( )
	
	self:SetPos( _data.pos );
	self:SetAngles( _data.ang );
	self:InitializeAnimation( _data.animid )
				
	
	//self:NextThink( CurTime() + 300 )
	
end
*/