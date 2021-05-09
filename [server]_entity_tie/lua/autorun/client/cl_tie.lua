--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_entity_tie/lua/autorun/client/cl_tie.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


hook.Add( "PlayerBindPress", "pressOnTheUse", function( ply, bind )
	if ( bind != "+use" ) then return end
	
	if ( tie_config.alt_use and !input.IsKeyDown( KEY_LALT ) ) then return end
	
	local ent = ply:GetEyeTrace().Entity
	
	if ( !IsValid( ent ) or !tie_config.can_edit( ply, ent ) ) then
		return
	end
	
	gui.EnableScreenClicker( true )
	
	local menu = DermaMenu()
		
	menu:AddOption( "Use", function()
		net.Start( "tieManage" )
			net.WriteString( "use" )
			net.WriteEntity( ent )
		net.SendToServer()
	end ):SetIcon( "icon16/wrench.png" )
		
	menu:AddSpacer()
		
	menu:AddOption( "Tie down", function()
		net.Start( "tieManage" )
			net.WriteString( "tie" )
			net.WriteEntity( ent )
		net.SendToServer()
	end ):SetIcon( "icon16/lock.png" )
	
	menu:AddOption( "Untie", function()
		net.Start( "tieManage" )
			net.WriteString( "untie" )
			net.WriteEntity( ent )
		net.SendToServer()
	end ):SetIcon( "icon16/lock_open.png" )

	function menu:OnRemove()
		gui.EnableScreenClicker( false )
	end
	
	function menu:Think()
		if ( !IsValid( ent ) ) then
			menu:Remove()
		end	
	end
	
	menu:Open()
	
	return true
end )