--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_food/lua/entities/icefuse_food_5_hotdog/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

ENT.Spawnable		= true
ENT.AdminSpawnable	= false
ENT.Category 		= "Icefuse Food"

ENT.Base		= "icefuse_food_base"
ENT.PrintName 	= "Hotdog"
ENT.WorldModel  = "models/food/hotdog.mdl"
ENT.Charges	 	= 1
ENT.IsFood 		= true
ENT.HealMax 	= 60
ENT.HealAmount 	= 6
ENT.HungerFill 	= 6
ENT.Information = "Health: "..ENT.Charges*ENT.HealAmount.."% (Upto "..ENT.HealMax.."% Over Max)  --  Hunger: "..ENT.Charges*ENT.HungerFill.."%"
ENT.CustomInit	= true

function ENT:UniqueFoodEffect(activator)
	--Custom Code run everytime a user uses a charge.
end

--ENT.Base			= File based off of this file.
--ENT.PrintName 	= Purchase Title
--ENT.WorldModel  	= World Model
--ENT.Charges	 	= Number of Uses Per Food Item
--ENT.IsFood 		= Sound played; false = gulping noise; true = eating noise
--ENT.HealMax 		= Amount of maximum hp healed above MaxHealth() or 100 [Default is 100 in GMOD]
--ENT.HealAmount 	= Amount of health healed per bite or sip.
--ENT.HungerFill 	= Amount of energy restored (DarkRP Var)
--ENT.Information 	= Information on the Entity purchase screen, adjusts automatically to inputted variables.
--ENT.CustomInit	= Custom code which is executed when the item is created or bought.
--ENT.FoodEffect	= Custom code which is executed everytime the item is used.
--ENT.SelfDeleteTime= If variable is present, it will delete after the time.
--ENT.NoFloat		= Does it float 15 units above the ground when spawned?