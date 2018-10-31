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

local META_PLAYER			= FindMetaTable( "Player" );
local DRUG_DEALER_NPC		= "snoop_dogg";
local DRUGS_SELL_PRICE		= GlobalWeedConfig.SellPrice;

// Max distance in feet
local MAX_SELL_DISTANCE		= GlobalWeedConfig.SellDistance;

local DRUGS_COOLDOWN_NONVIP	= GlobalWeedConfig.CooldownNonVIP;
local DRUGS_COOLDOWN_VIP	= GlobalWeedConfig.CooldownVIP;

local VIP_NAME				= GlobalWeedConfig.VIPIdentifier
local VIP_GROUPS = GlobalWeedConfig.VIPUserGroups


local function InitDrugWeedFolder( )
	local _filename = "/drugs/weed/";

	// Create folder if it doesn't exist.
	local _folder = string.lower( ( GM or GAMEMODE ).Name ) .. _filename;
	if ( !file.Exists( _folder .. _filename, "DATA" ) ) then
		file.CreateDir( _folder );
	end

	return _folder;
end

function string.safe( text )
	text = string.gsub( text, "%W", "_" );
	return text;
end

function META_PLAYER:DrugWeed( )
	return self.__DrugWeed || 0;
end

function META_PLAYER:GetDrugWeed( )
	return self:DrugWeed( );
end

function META_PLAYER:SetDrugWeed( _amount )
	// Sets the DrugWeed to a specific amount
	self.__DrugWeed = math.max( 0, _amount ) || math.min( 0, _amount);

	if ( SERVER ) then
		NetworkPlayerDrugWeedUpdate( self, self.__DrugWeed );
	end
end

function META_PLAYER:AddDrugWeed( _amount )
	// Adds DrugWeed to current value. Won't error because of self:DrugWeed( ) returns 0 if not set...
	self:SetDrugWeed( self:DrugWeed( ) + _amount );
end

if ( CLIENT ) then

	net.Receive( "PlayerFullyConnected", function( _len )
		local _p = LocalPlayer( );
		hook.Run( "PlayerFullyConnected", _p );
	end );
	
	

	net.Receive( "PlayerDrugWeed", function( _len )
		if !LocalPlayer():IsValid() then return end
		local _p = LocalPlayer( );
		_p:SetDrugWeed( net.ReadDouble( ) );
	end );
else

	util.AddNetworkString( "PlayerFullyConnected" );
	util.AddNetworkString( "PlayerDrugWeed" );
	util.AddNetworkString( "sell_weed" );

	function NetworkPlayerDrugWeedUpdate( _p, _amount )
		// Update the client
		net.Start( "PlayerDrugWeed" );
			net.WriteDouble( _amount );
		net.Send( _p );
		
	end


	function META_PLAYER:NearDrugWeedDealer( )
		for k, _ent in pairs( ents.FindByClass( DRUG_DEALER_NPC ) ) do
			if ( !IsValid( _ent ) ) then continue; end
			if ( self:GetPos( ):Distance( _ent:GetPos( ) ) <= ( ( 4 / 3 ) * 12 * MAX_SELL_DISTANCE ) ) then
				return true;
			end
		end

		return false;
	end

	function SaveClientDrugWeed( _p )
		if ( !IsValid( _p ) || !_p.SteamID ) then return; end
		local _folder = InitDrugWeedFolder( );

		// Save DrugWeed here using MySQL, SQLite, Flat-File, or whatever...
		file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", tostring( _p:GetDrugWeed( ) ), "DATA" );
	end

	net.Receive( "sell_weed", function( _len, _p )
		// If they're exploiting, catch it...
		if ( !_p:NearDrugWeedDealer( ) ) then return DarkRP.notify( _p, 1, 4, "You're not close enough to any dealer to sell that!" ); end

		// Make sure THIS dealer is tired of the player ( need to recode the rest of the bad system to fix this issue and get rid of the distance loop above )...
		if ( _p.__CooldownDrugSale && ( CurTime( ) - _p.__CooldownDrugSale < 0 ) ) then return DarkRP.notify( _p, 0, 5, "The drug dealer is tired of you." ); end

		// If they don't have anything, stop it from happening...
		local _drugs = _p:DrugWeed( );
		if ( _drugs <= 0 ) then return DarkRP.notify( _p, 1, 4, "You no have weed to sell!" ); end

		// Calculate the value and notify...
		local _drugs_value = _drugs * DRUGS_SELL_PRICE;
		DarkRP.notify( _p, 0, 5, "You have sold " .. _drugs .. "g of weed for a total of $" .. _drugs_value );

		// Process transfer
		_p:addEXP( _drugs * 5 )
		_p:addMoney( _drugs_value );
		_p:SetDrugWeed( 0 );

		// Check vip status
		local _bIsVIP = ( VIP_GROUPS[ string.lower( _p:GetNWString( "UserGroup" ) || "user" ) ] || string.find( string.lower( _p:SteamName( ) ), string.lower( VIP_NAME ) ) ) && true || false;

		// Add cooldown based on vip / non-vip status
	
		_p.__CooldownDrugSale = CurTime( ) + ( ( _bIsVIP ) && DRUGS_COOLDOWN_VIP || DRUGS_COOLDOWN_NONVIP );
	end );


	local function DetectPlayerFullyConnected( _p, _hook, ... )
		if ( _p.__FullyConnected ) then return; end

		// They're here...
		_p.__FullyConnected = true;

		// Notify the client that they're here.
		net.Start( "PlayerFullyConnected" );
		net.Send( _p );

		// Broadcast the hook...
		hook.Run( "PlayerFullyConnected", _p );
	end
	hook.Add( "SetupMove", "PlayerFullyConnected:SetupMove", function( _p, _move, _cmd ) DetectPlayerFullyConnected( _p, "SetupMove" ); end );


	hook.Add( "PlayerFullyConnected", "FetchDrugWeed", function( _p )
		
		local _folder = InitDrugWeedFolder( );
		if ( IsValid( _p ) && _p:IsPlayer( ) ) then
			// Fetch DrugWeed here using MySQL, SQLite, Flat-File, or whatever...
			local _amount = tonumber( file.Read( _folder .. string.safe( _p:SteamID( ) ) .. ".txt" ) || "0" )
			_p:SetDrugWeed( _amount );
			print( "Initialized " .. _p:Nick() )
		end
	end );

	gameevent.Listen( "player_disconnect" );
	hook.Add( "player_disconnect", "SaveDrugWeedOnDC", function( _data )

		// All of the data values; shown in case saving is done using steamid, or whatever...
		local _id = _data.userid;			// Same as Player:UniqueID( );
		local _p = Player( _id ); 			// The Player Entity, if valid
		SaveClientDrugWeed( _p );

	end );

	timer.Create( "SaveCurrencyInterval", 60 * 5, 0, function( )
		for k, _p in pairs( player.GetAll( ) ) do
			if ( !IsValid( _p ) ) then continue; end
			SaveClientDrugWeed( _p );
			print("#3 Saved everyone's weed count")
		end
	end );


	hook.Add( "ShutDown", "SaveDrugWeedOnShutDown", function( )
		for k, _p in pairs( player.GetAll( ) ) do
			if ( !IsValid( _p ) ) then continue; end
			SaveClientDrugWeed( _p );
			print("#4 Shutting Down - Saving all player's weed counts")
		end
	end );
end