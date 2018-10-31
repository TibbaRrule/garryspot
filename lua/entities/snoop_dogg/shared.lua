/*=====================================================================
== Made by Mario 'Tibba'Sinn                                         ==
== CONTACT: mariosgameroominquiries@gmail.com"                       ==
== YOUTUBE: https://www.youtube.com/channel/UCVYG2ZDHynAXgYLP6J9hxUg ==
== STEAM: https://steamcommunity.com/profiles/76561198191730261/     ==
=======================================================================
== Please consider subscribing to my youtube channel if you end up   ==
== using this addon.                                                 ==
=======================================================================
== LICENSE: CC BY-NC 4.0                                             ==
== https://creativecommons.org/licenses/by-nc/4.0/                   ==
=======================================================================*/ 
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Snoop Dogg"
ENT.Author = "Mario Sinn"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:InitializeAnimation(animID)
    if SERVER then
        if animID then
        if animID != -1 then
            self:ResetSequence(animID)
        end
            else
            self:ResetSequence(8)
        end
    end
    self.AutomaticFrameAdvance = true
end
