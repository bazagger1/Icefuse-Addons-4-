--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/entities/sent_fire/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fire"
ENT.Author = "Icefuse"
ENT.Spawnable = false

// Utility

function QuickTrace(sPos,ePos,filter)

	local data = {}
	data.start = sPos
	data.endpos = ePos
	data.mask = MASK_SHOT
	data.filter = filter 
	
	return util.TraceLine(data)
end

function ENT:SetupDataTables()

	self:NetworkVar("Float",1,"Strength")
	self:NetworkVar("Float",2,"Offset")
end
