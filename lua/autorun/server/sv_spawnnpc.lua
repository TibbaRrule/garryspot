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

function SpawnSnoopDogg()
	local npc = ents.Create("snoop_dogg")


	npc:SetModel("models/snoopdogg.mdl")

	npc:SetPos(GlobalWeedConfig.SnoopPosition)

	npc:SetAngles(GlobalWeedConfig.SnoopAngle)

	npc:Spawn()  

	npc:InitializeAnimation(2)
	print("#1 Drug Dealer has been Spawned! Thank you for using this addon!")
end

hook.Add("InitPostEntity", "SpawnDrugDealer", function()

	print( "#0 Fried Rice's Drug Dealer Initialized!")
	for k , v in pairs( ents.FindByClass( "snoop_dogg" ) ) do

		v:Remove()

	end

	SpawnSnoopDogg();

end)

concommand.Add( "respawn_dogg", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return	DarkRP.notify(ply,1, 5, "You may not use this console command.") end

	for k , v in pairs( ents.FindByClass( "snoop_dogg" ) ) do

		v:Remove()

	end

	SpawnSnoopDogg();

end )