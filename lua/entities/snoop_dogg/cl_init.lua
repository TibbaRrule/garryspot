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
include("shared.lua")

function ENT:Initialize()   
    self:InitializeAnimation()
end

surface.CreateFont( "NPC_NameFont", {
	font = "gravity",
	size = 25,
	weight = 500
})

surface.CreateFont( "NPC_DesFont", {
	font = "gravity",
	size = 20,
	weight = 450
})

surface.CreateFont( "NPC_OptionFont", {
	font = "gravity",
	size = 15,
	weight = 350
})


net.Receive("opendrugdealermenu", function() 	
    local npcnameframe = vgui.Create("DFrame")
    npcnameframe:SetPos(ScrW() / 2 - 325,  ScrH() / 1 - 455 )
    npcnameframe:SetSize(250,50)
    npcnameframe:SetTitle("")
    npcnameframe:SetVisible(true)
    npcnameframe:SetDraggable(false) 
    npcnameframe:ShowCloseButton(false) 
    npcnameframe:MakePopup()
    npcnameframe.Paint = function()
		draw.RoundedBox(0, 0, 0, npcnameframe:GetWide() , npcnameframe:GetTall(), Color(25,25,25,180))	
        draw.DrawText("Snoop 'Diggidy' Dogg","NPC_NameFont",25,12.5,Color(255,255,255,255),TEXT_ALIGN_LEFT)	
        surface.SetDrawColor(0,0,0,255)
        surface.DrawOutlinedRect(0, 0,npcnameframe:GetWide(),npcnameframe:GetTall())		
    end
	
    local npcframe = vgui.Create("DFrame")
    npcframe:SetPos(ScrW() / 2 - 325,  ScrH() / 1 - 400 )
    npcframe:SetSize(750,250)
    npcframe:SetTitle("")
    npcframe:SetVisible(true)
    npcframe:SetDraggable(false) 
    npcframe:ShowCloseButton(false) 
    npcframe:MakePopup()
    npcframe.Paint = function()

        surface.SetDrawColor(255,255,255,50)
        //surface.SetMaterial(Material("ig-rp/darkerskin.png", "smooth"))
        surface.DrawRect(1,1,npcframe:GetWide()-2,npcframe:GetTall())	
        surface.SetDrawColor(255,255,255,50)
        //surface.SetMaterial(Material("ig-rp/darkerskin.png", "smooth"))
        surface.DrawRect(1,1,npcframe:GetWide()-2,50)								
        draw.RoundedBox(0,0,0,npcframe:GetWide(),npcframe:GetTall(),Color(25,25,25,175))		
        surface.SetDrawColor(0,0,0,255)
        surface.DrawOutlinedRect(0, 0,npcframe:GetWide(),npcframe:GetTall())			
    end
    
    local npctalkboxandtext = vgui.Create("DPanel",npcframe)
    npctalkboxandtext:SetPos(5,5)
    npctalkboxandtext:SetSize(npcframe:GetWide()-10,75)
    npctalkboxandtext.Paint = function(self)
        draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(0,0,0,200))	
        surface.SetDrawColor(0,0,0,255)
        surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())		
        draw.DrawText("You here to sell me some drugs?","NPC_DesFont",8,5,Color(255,255,255,255),TEXT_ALIGN_LEFT)
    end		

    local sellweedbutton = vgui.Create("DButton",npcframe)
    sellweedbutton:SetText("I'd like to sell my weed.")     
    sellweedbutton:SetPos(5,85) 
    sellweedbutton:SetSize(npcframe:GetWide()-10, 30)  		
    sellweedbutton:SetFont("NPC_OptionFont")
    sellweedbutton:SetTextColor(Color(255,255,255,255))
    sellweedbutton.ButtCol = Color(35,35,35,255)	
    sellweedbutton.DoClick = function()
		//surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")

        net.Start("sell_weed")
        net.SendToServer()
        npcframe:Close(true)
		npcnameframe:Close(true)
    end
    sellweedbutton.Paint = function(self)
        draw.RoundedBoxEx(0, 0, 0, self:GetWide(), self:GetTall(), sellweedbutton.ButtCol)
        surface.SetDrawColor(25,25,25,255)
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    end	
    sellweedbutton.OnCursorEntered = function()
		//surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
        sellweedbutton.ButtCol = Color(55,55,55,255)
    end
    sellweedbutton.OnCursorExited = function()
		//surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")

        sellweedbutton.ButtCol = Color(35,35,35,255)
    end		

    local cancelbutton = vgui.Create("DButton",npcframe)
    cancelbutton:SetText("I don't think I have any business here.. (Close the menu)")     
    cancelbutton:SetPos(5,120)    
    cancelbutton:SetSize(npcframe:GetWide()-10, 30) 		
    cancelbutton:SetFont("NPC_OptionFont")
    cancelbutton:SetTextColor(Color(255,255,255,255))
    cancelbutton.ButtCol = Color(35,35,35,255)			 
    cancelbutton.DoClick = function()
		//surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
		//drawMissionAccomplished()
	    npcframe:Close(true)
		npcnameframe:Close(true)
    end
    cancelbutton.Paint = function(self)
        draw.RoundedBoxEx(0, 0, 0, self:GetWide(), self:GetTall(), cancelbutton.ButtCol)
        surface.SetDrawColor(25,25,25,255 )
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    end	
    cancelbutton.OnCursorEntered = function()
		//surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
        cancelbutton.ButtCol = Color(55,55,55,255)
    end
    cancelbutton.OnCursorExited = function()
		//surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")

        cancelbutton.ButtCol = Color(35,35,35,255)
    end		

end)