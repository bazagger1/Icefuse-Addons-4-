--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/autorun/sv_icefusefirespawn.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (CLIENT) then return end

AddCSLuaFile("sh_Icefusefireconfig.lua")
include("sh_Icefusefireconfig.lua")

local dir = "Icefusefire"
local filePath = dir .. "/" .. game.GetMap() .. ".txt"
local allFirePos = {}

// Load n Create first file
if (!file.IsDir(dir,"DATA")) then

	file.CreateDir(dir)
end

if (!file.Exists(filePath,"DATA")) then

	file.Write(filePath,util.TableToJSON(allFirePos))
else

	allFirePos = util.JSONToTable(file.Read(filePath,"DATA"))
end

// Add n Remove spawn positions

local function AddSpawnPos(ply,cmd,args)

	if (!ply:IsSuperAdmin()) then return end

	local index = string.Implode("",args)
	if (index == "") then

		ply:SendLua("chat.AddText('Correct syntax is Icefuse_add name')")
		return
	end

	if (allFirePos[index]) then

		print("That position already exists!")
		return
	end

	ply:SendLua("chat.AddText('Created spawn pos')")
	allFirePos[index] = ply:GetEyeTrace().HitPos
	file.Write(filePath,util.TableToJSON(allFirePos))
end

local function RemoveSpawnPos(ply,cmd,args)

	if (!ply:IsSuperAdmin()) then return end

	local index = string.Implode("",args)

	if (allFirePos[index]) then

		allFirePos[index] = nil
		file.Write(filePath,util.TableToJSON(allFirePos))

		ply:SendLua("chat.AddText('Removed spawn pos')")
	end
end

concommand.Add("Icefuse_add",AddSpawnPos)
concommand.Add("Icefuse_remove",RemoveSpawnPos)

// Spawn some fire

local function SpawnSomeFire()

	for k,v in pairs(allFirePos) do

		local prob = math.random(1,100)

		if (prob < shFireConfig.fireSpawnProbability) then

			local fire = ents.Create("sent_fire")
			fire:SetPos(v)
			fire:Spawn()
			fire:Activate()
		end
	end
end

timer.Create("Icefuse_spawnsomefire",shFireConfig.fireSpawnTimer,0,SpawnSomeFire)
print("Loaded Icefuse fire system.")
