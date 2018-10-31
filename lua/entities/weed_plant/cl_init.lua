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
include('shared.lua')

surface.CreateFont("cannabis_Plant_Font",{font = "Arial",size = 30,weight = 1000,blursize = 0,scanlines = 0,antialias = true})
surface.CreateFont("cannabis_Plant_Font2", {font = "Arial",size = 25,weight = 1000,blursize = 0,scanlines = 0,antialias = true})

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"SpawnTime")
	self:NetworkVar("Entity",1,"owning_ent")
end

function ENT:Draw()
   	self:DrawModel() 

   	local ang = self:GetAngles()
	local Time = CurTime()
   	ang:RotateAroundAxis(ang:Forward(), 90);

   	local plant_spawn_time = self:GetSpawnTime()	
 	local plant_owner = self:Getowning_ent()
	plant_owner = (IsValid(plant_owner) and plant_owner:Nick()) or DarkRP.getPhrase("unknown")  	

   	cam.Start3D2D( self:GetPos()+(self:GetAngles():Right()*17)+(self:GetAngles():Up()*1), ang, 0.05 )

		--Plant Background
		surface.SetDrawColor( Color( 0,0,0, 200 ) )
		surface.DrawRect( -6*20, -11*20, 12*20, 12*13 )

		--Plant Title Text
		surface.SetDrawColor( Color( 255,255,255, 255 ) )
		surface.SetFont( "cannabis_Plant_Font" )
		surface.SetTextColor( 0, 255, 0, 255 )
		
		local TextWidth = surface.GetTextSize("cannabis Plant")
		surface.SetTextPos( -3.8*23,-10.5*20 ) 
		surface.DrawText("Cannabis Plant")	

		--Plant Owner Text
		surface.SetDrawColor( Color( 255,255,255, 255 ) )
		surface.SetFont( "cannabis_Plant_Font" )
		surface.SetTextColor( 255, 0, 0, 255 )
		
		local TextWidth = surface.GetTextSize(plant_owner)
		surface.SetTextPos( -4*23,-10.5*16 ) 
		surface.DrawText(string.sub(plant_owner, 1, 15).. "..")	

		--Plant Timer and Ready to pick Text
		surface.SetDrawColor( Color( 30,30,30, 255 ) )
		surface.DrawRect( -6*20, -2.5*48, 12*20, 2*20 )
		
		local timeleft = 1  		
		
		local timeleft = math.max(0, plant_spawn_time + 450 - Time )
		surface.SetDrawColor( Color( 128,128,128, 50 ) )
		surface.DrawRect( -6*20, -2.5*48, 12*20, 2*20 )
		surface.SetDrawColor( Color( 25,185,25, 255 ) )
		surface.DrawRect( -6*20, -2.5*48,math.Clamp(timeleft , 0 ,450) *0.544, 2*20 )

		local timeleft = math.max(0, plant_spawn_time + 450 - Time)
		plant_timer_text = "Timer: " .. string.FormattedTime(timeleft, "%02i:%02i")

		if timeleft ~= 0 then
			surface.SetDrawColor(Color(255,255,255,255))
			surface.SetFont("cannabis_Plant_Font2")

			local TextWidth = surface.GetTextSize(plant_timer_text)

			surface.SetTextColor(255,255,255,255)
			surface.SetTextPos(0-(TextWidth/1.85),-2.1*53) 
			surface.DrawText(plant_timer_text)
		else
			surface.SetDrawColor(Color(255,255,255,255))
			surface.SetFont("cannabis_Plant_Font")

			local TextWidth = surface.GetTextSize("Ready to pick!")

			surface.SetTextColor(255,255,255,255)
			surface.SetTextPos(0-(TextWidth/2),-2.1*55) 
			surface.DrawText("Ready to pick!")		
		end
	cam.End3D2D()
end