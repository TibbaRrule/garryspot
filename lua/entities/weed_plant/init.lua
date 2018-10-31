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

function ENT:Initialize()
	self.Entity:SetModel("models/alakran/marijuana/pot.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	self.Entity:SetAngles(Angle(0, math.random(1, 360), 0))
	self.Demage = 100
	self.GrowthTime = 10
	self.drugWeedAmount = math.random(GlobalWeedConfig.WPPMin, GlobalWeedConfig.WPPMax)
	self.Growth = 1
	self.RespawnTime = CurTime()
	self.dt.SpawnTime = CurTime()
	self.Entity:GetPhysicsObject():Wake()
	self:SetNWInt("curweed", 0)
end

function ENT:OnTakeDamage(dmg)
    self.Demage = self.Demage - dmg:GetDamage()
    if self.Demage <= 0 then
         self:Remove()
    end
end

function ENT:Use(activator, ent)
	if(activator:IsPlayer()) then
		if (activator:isCP()) then
			activator:addMoney(GlobalWeedConfig.PoliceReward)
			DarkRP.notify(activator, 0, 4, "You have been rewarded $200 for destroying weed plant.")
			DarkRP.notify(self:Getowning_ent(), 1, 4, "Your weed plant has been confiscated by "..activator:Nick())
			self:Remove()
		elseif self.dt.SpawnTime + self.GrowthTime < CurTime() then	
				DarkRP.notify(activator, 0, 4, "You have cleaned the bud and gathered #" .. self.drugWeedAmount .. " weed nuggets.")
			if GlobalWeedConfig.DoubleClasses[activator:Team()] then
				self.drugWeedAmount = self.drugWeedAmount *2;
				DarkRP.notify(activator, 0, 4, "You have received double the amount of cannabis for being a cancer patient")
			elseif GlobalWeedConfig.PercInc[activator:Team()] then
				self.drugWeedAmount = self.drugWeedAmount + math.random( self.drugWeedAmount* GlobalWeedConfig.PercPlusMin , self.drugWeedAmount* GlobalWeedConfig.PerPlusMax);
				DarkRP.notify(activator, 0, 4, "You have received 10-25% more cannabis for being a stoner patient")
			end
			activator:AddDrugWeed( self.drugWeedAmount )	

			if (!self.Getowning_ent == activator) then
				DarkRP.notify(self.Getowning_ent(), 0, 4, activator:Nick().." has stolen your cannabis plant!")
				self:Remove()
			else
				self:Remove()
			end
		elseif self.dt.SpawnTime + 300 < CurTime() then	
			activator:AddDrugWeed( math.random(3,15) )
			DarkRP.notify(activator, 0, 4, "This plant was picked too early. You still managed to salvage some.")
			DarkRP.notify(activator, 0, 4, "You now have "..activator:GetDrugWeed() .."g of weed total.")
			//DarkRP.notify(activator, 0, 4, "Remember, your grams are only saved for your current session.")
			if (!self.Getowning_ent == activator) then
				DarkRP.notify(self.Getowning_ent(), 0, 4, activator:Nick().." has stolen your cannabis plant!")
				self:Remove()
			else
				self:Remove()
			end
		end
	end
end

function ENT:Think()
	if CurTime() - self.RespawnTime > 150 then
        if self.Growth < 5 then
            self.Growth = self.Growth + 1
            self.Entity:SetModel("models/alakran/marijuana/marijuana_stage"..self.Growth..".mdl")
            self.RespawnTime = CurTime()
            local Pos, Ang = LocalToWorld(Vector(0,0,10), Angle(0,0,90), self:GetPos(), self:GetAngles())
			local WeedGrowthEffect = WeedGrowthEffect or EffectData()
			WeedGrowthEffect:SetOrigin(Pos)
			WeedGrowthEffect:SetMagnitude(1)
			WeedGrowthEffect:SetScale(1.2)
			WeedGrowthEffect:SetRadius(1)
			util.Effect("weed_growth_effect",WeedGrowthEffect)
        end
    end
end
