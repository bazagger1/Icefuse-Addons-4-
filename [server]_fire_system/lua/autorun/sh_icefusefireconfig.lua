--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/autorun/sh_icefusefireconfig.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (SERVER) then
--
--
end

shFireConfig = {}

////// Firesystem Config  //////
// Feel free to edit below.. //

-- Fires
shFireConfig.maxFires 				= 100		// How many fires can there be at one time?
shFireConfig.fireLifeSpan 			= 600 		// How long can a fire last for? (seconds)
shFireConfig.fireSpawnProbability 	= 0		// 0-100% How probable is fire to spawn? 100% means every time and vice versa
shFireConfig.fireSpawnTimer 		= 120		// X seconds until more fire can be spawned
shFireConfig.fireStartStrength 		= 0.1 		// 0 -> 1 | How strong should fire start out? 0.1 = weak, 1 = full strength
shFireConfig.fireCanSpread 			= true 		// Can fire spread?
shFireConfig.fireSpreadMax			= 2 		// How many times can one fire spread?
shFireConfig.fireWidth 				= 50 		// How spread out is the fire? (in gmod units)
shFireConfig.viewDistance			= 2000		// How far away will fire render? (this heavily affects performance)

-- Extinguishers
shFireConfig.extinguisherCanBlind 	= false		// Can fire extinguishers blind people if sprayed in their eyes?

shFireConfig.extinguisherStrength	= 0.08		// How strong is the fire extinguisher? Weaker = harder to put out fires; Stronger = easier to put out fires
shFireConfig.extinguisherBlindCD 	= 300		// How long before people can be blinded by an extinguisher again?
shFireConfig.extinguisherBlindTime	= 5 		// How long should people be blinded by extinguishers?
shFireConfig.reward 				= {50,150}	// How much should firefighters be rewarded for putting out fires? (min,max)

shFireConfig.civExtStrength			= 0.08  	// How strong is the civilian fire extinguisher?
shFireConfig.civExtBlindCD			= 600 		// How long before ppl can be blinded by a civilian extinguisher again?
shFireConfig.civExtBlindTime		= 5 		// How long should people be blinded by civilian extinguishers?

-- C4s
shFireConfig.c4CanDestroy 			= false		// Can c4 unweld and unfreeze props?
shFireConfig.c4Reward				= {1000,2000} // How much should players be rewarded for putting out c4? (min,max)
shFireConfig.c4Delay				= 15		// How long should a c4 wait before going KABOOM? (seconds)
shFireConfig.c4DamageRadius			= 500		// How far away should things take damage from the c4 explosion? (gmod units)
shFireConfig.c4_autoWanted			= true
shFireConfig.c4_wantedDuration		= 120
shFireConfig.c4_wantedRadius		= 300
shFireConfig.c4_wantedText			= "Planting C4"
shFireConfig.c4_propIgniteDuration	= 10
shFireConfig.c4_propGhostDuration	= 30        // 

-- Props
shFireConfig.propsTakeDamage 		= false		// Do props take damage from fires?
shFireConfig.propLife 				= 45 		// When props catch fire, how long should they last before being removed? (seconds)


-- Sounds
shFireConfig.painSounds 			= {			// What sounds should the player make when they get burned?

	"player/pl_burnpain1.wav",
	"player/pl_burnpain2.wav",
	"player/pl_burnpain3.wav",
	"ambient/voices/m_scream1.wav",
}

shFireConfig.coughSounds 			= {			// What sounds should the player make when they cough?

	"ambient/voices/cough1.wav",
	"ambient/voices/cough2.wav",
	"ambient/voices/cough3.wav",
	"ambient/voices/cough4.wav",
}

shFireConfig.blindSounds  			= {			// What sound should the player make when they get blinded?

		"vo/npc/male01/gethellout.wav",
		"ambient/voices/m_scream1.wav",
		"vo/npc/male01/no02.wav",
		"vo/npc/male01/no01.wav",
		"vo/npc/male01/ohno.wav",
}

shFireConfig.bombBadWireCut			= { 		// What sound shoud players make when someone cuts a bad wire?

	"vo/npc/male01/notthemanithought01.wav",
	"vo/npc/male01/notthemanithought02.wav",
	"vo/npc/male01/ohno.wav",
	"vo/npc/male01/whoops01.wav",
}

shFireConfig.bombFailDefuse 		= {			// What sound should players make when someone fails at defusing?

	"vo/npc/male01/runforyourlife01.wav",
	"vo/npc/male01/runforyourlife02.wav",
	"vo/npc/male01/runforyourlife03.wav",
	"vo/npc/male01/strider_run.wav",
}

shFireConfig.bombSuccessDefuse		= {			// What sound should players make when someone succeeds at defusing?

	"vo/npc/male01/yougotit02.wav",
	"vo/npc/male01/nice.wav",
	"vo/npc/male01/fantastic01.wav",
	"vo/npc/male01/finally.wav",
	"vo/coast/odessa/male01/nlo_cheer01.wav",
	"vo/coast/odessa/male01/nlo_cheer02.wav",
	"vo/coast/odessa/male01/nlo_cheer03.wav",
	"vo/coast/odessa/male01/nlo_cheer04.wav",
}

shFireConfig.bombPlant 				= {			// What sound should players make when someone plants a bomb?

	"vo/ravenholm/madlaugh01.wav",
	"vo/ravenholm/madlaugh02.wav",
	"vo/ravenholm/madlaugh03.wav",
	"vo/ravenholm/madlaugh04.wav",
}

shFireConfig.firePutout				= {			// What sound should players make when someone puts out a fire?

	"vo/npc/male01/yougotit02.wav",
	"vo/npc/male01/nice.wav",
	"vo/npc/male01/fantastic01.wav",
	"vo/npc/male01/finally.wav",
	"vo/coast/odessa/male01/nlo_cheer01.wav",
	"vo/coast/odessa/male01/nlo_cheer02.wav",
	"vo/coast/odessa/male01/nlo_cheer03.wav",
	"vo/coast/odessa/male01/nlo_cheer04.wav",
}

shFireConfig.c4DefuseTeams 			= {			// Teams that can defuse c4s eg: "Hobo"
	"Secret Service",
	"SWAT Chief [T3]",
	"SWAT Heavy [T4]",
	"SWAT Sniper [T3]",
	"SWAT [T1]"
}

// Advanced settings, be careful

shFireConfig.particleStartSize 		= {10,20}	// How large should a particle be when its first created? (min,max)
shFireConfig.particleEndSize 		= {5,10}	// How large should a particle be at the end of its life? (min,max)
shFireConfig.particleRollDelta 		= {-3,3}	// How much should a particle rotate? (min,max)
shFireConfig.particleLifeSpan		= {1,3}		// How long should a particle exist? (min,max)

// DarkRP Firefighter job

shFireConfig.createFirefighterJob 	= false 				// Should we make a firefighter job?
shFireConfig.ffTeamName 			= "Fire Fighter"	// What should the fire fighter team be called?
shFireConfig.ffCmd					= "firefighter"		// What should the fire fighter command be?
shFireConfig.ffTeamColor 			= Color(200, 200, 50, 255)	// What should the fire fighter team color be?
shFireConfig.maxFirefighters 		= 4					// Max firefighters
shFireConfig.salary 				= 100				// Firefighter salary
shFireConfig.ffCustomCheck 			= function(ply)		// Firefighter custom check function for vip / donator stuff..

	return true
end

// DarkRP Entities
-- Molotov
shFireConfig.addMolotov 			= false 		// Add molotov to darkrp f4 menu?
shFireConfig.molotovPrice			= 10000		// Price of molotov
shFireConfig.molotovCount 			= 10 		// How many go into a shipment?
shFireConfig.molotovAllowedTeams 	= {			// Teams that can buy the molotov eg: "Hobo"

	"Hobo",
}

-- C4
shFireConfig.addC4 					= false 		// Add c4 to darkrp f4 menu?
shFireConfig.c4Price				= 10000		// Price of c4
shFireConfig.c4Count 				= 10 		// How many go into a shipment?
shFireConfig.c4AllowedTeams 		= {			// Teams that can buy the c4 eg: "Hobo"

	"Hobo",
}

-- Civilian fire extinguisher
shFireConfig.addCivilianExt 		= false 		// Add civilian extinguisher to f4 menu?
shFireConfig.civExtPrice 			= 10000 	// Price of extinguisher
shFireConfig.civExtCount			= 10 		// How many go into a shipment?
shFireConfig.civExtAllowedTeams 	= {			// Which teams should be allowed to buy the civilian fire extinguisher? empty table = all teams


}

// End of firesystem config //
// DO NOT TOUCH BELOW

Icefuse_FIRESTARTUP = Icefuse_FIRESTARTUP || false

local function DoDarkRPShit()

	if (Icefuse_FIRESTARTUP) then return end

	if (DarkRP == nil || ulx == nil) then

		timer.Simple(1,function()

			DoDarkRPShit()
		end)
		return
	end

	if (shFireConfig.createFirefighterJob) then

		DarkRP.createJob(shFireConfig.ffTeamName, {

			color = shFireConfig.ffTeamColor,
			model = "models/fearless/fireman2.mdl",
			description = [[You put out fires and protect the public.]],
			weapons = {"swep_extinguisher"},
			command = shFireConfig.ffCmd,
			max = shFireConfig.maxFirefighters,
			salary = shFireConfig.salary,
			admin = 0,
			vote = true,
			hasLicense = false,
			customCheck = shFireConfig.ffCustomCheck,
		})
	end

	if (shFireConfig.addMolotov) then

		DarkRP.createShipment("Molotov", {
			model = "models/props_junk/garbage_glassbottle003a.mdl",
			entity = "swep_molotov",
			price = shFireConfig.molotovPrice,
			amount = shFireConfig.molotovCount,
			separate = true,
			pricesep =	shFireConfig.molotovPrice / shFireConfig.molotovCount,
			noship = false,
			shipmodel = "models/items/item_item_crate.mdl",
			category = "Other",
			customCheck = function(ply)

				if (table.Count(shFireConfig.molotovAllowedTeams) == 0) then return true end

				if (table.HasValue(shFireConfig.molotovAllowedTeams,team.GetName(ply:Team()))) then

					return true
				end

				return false
			end,
		})
	end

	if (shFireConfig.addC4) then

		DarkRP.createShipment("C4", {
			model = "models/weapons/fire_c4/w_sb.mdl",
			entity = "swep_c4",
			price = shFireConfig.c4Price,
			amount = shFireConfig.c4Count,
			separate = true,
			pricesep =	shFireConfig.c4Price / shFireConfig.c4Count,
			noship = false,
			shipmodel = "models/items/item_item_crate.mdl",
			category = "Other",
			customCheck = function(ply)

				if (table.Count(shFireConfig.c4AllowedTeams) == 0) then return true end

				if (table.HasValue(shFireConfig.c4AllowedTeams,team.GetName(ply:Team()))) then

					return true
				end

				return false
			end,
		})
	end

	if (shFireConfig.addCivilianExt) then

		DarkRP.createShipment("Fire Extinguisher", {
			model = "models/weapons/fire_extinguisher/w_fire_extinguisher.mdl",
			entity = "swep_civextinguisher",
			price = shFireConfig.civExtPrice,
			amount = shFireConfig.civExtCount,
			separate = true,
			pricesep =	shFireConfig.civExtPrice / shFireConfig.civExtCount,
			noship = false,
			shipmodel = "models/items/item_item_crate.mdl",
			category = "Other",
			customCheck = function(ply)

				if (table.Count(shFireConfig.civExtAllowedTeams) == 0) then return true end

				if (table.HasValue(shFireConfig.civExtAllowedTeams,team.GetName(ply:Team()))) then

					return true
				end

				return false
			end,
		})

	end

	if (SERVER) then

		if (ulx != nil) then

			local comm = ulx.command( "Fire Utilities", "ulx removefire", function(calling_ply)

				for k,v in pairs(ents.FindByClass("sent_fire")) do

					v.helpers = {}
					v:Remove()
				end


				ulx.fancyLogAdmin( calling_ply, "#A removed all fires" )
			end, "!removefire" )
			comm:defaultAccess( ULib.ACCESS_ADMIN )
			comm:help( "Join the steam group!" )
		end
	end

	Icefuse_FIRESTARTUP = true
end

DoDarkRPShit()

print("Loaded Icefuse fire system config.")
