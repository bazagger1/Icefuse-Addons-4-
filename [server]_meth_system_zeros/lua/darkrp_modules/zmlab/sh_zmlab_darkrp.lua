--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_meth_system_zeros/lua/darkrp_modules/zmlab/sh_zmlab_darkrp.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- TEAM_ZMLAB_COOK = DarkRP.createJob("Master Meth Cook [T6]", {
	-- color = Color(133, 193, 233, 255),
	-- model = {"models/icefuse_networks/players/criminals/factory01smm.mdl"},
	-- description = [[You are a Master manufacture of Methamphetamin]],
	-- weapons = {"zmlab_extractor"},
	-- command = "zmlab_meth_cook",
	-- max = 4,
	-- salary = 0,
	-- admin = 0,
	-- vote = false,
	-- category = "Pro Criminals",
	-- hasLicense = false,
    -- tier = '6'
-- })
--=========================================================================================================
TEAM_ZMLAB_COOK = DarkRP.createJob("Master Meth Cook [T6]", {
	color = Color(133, 193, 233, 255),
	model = {"models/icefuse_networks/players/criminals/factory01smm.mdl"},
	description = [[Methamphetamine (contracted from N-methylamphetamine) is a potent central nervous system (CNS) stimulant that is mainly used as a recreational drug and less commonly as a second-line treatment for attention deficit hyperactivity disorder and/or obesity. Methamphetamine was discovered in 1893 and exists as two enantiomers: levo-methamphetamine and dextro-methamphetamine. Methamphetamine properly refers to a specific chemical, the racemic free base, which is an equal mixture of levomethamphetamine and dextromethamphetamine in their pure amine forms. It is rarely prescribed due to the building concerns involving human neurotoxicity and potential for recreational abuse as an aphrodisiac and euphoriant, among other concerns, as well as the availability of safer alternative drugs.
	
All of these things taken into account - you are a very handy man. Over time you have garnered a great understanding of the finer scientific aspects involved in the less-than-legal process of creating strong drugs. And you have mastered the art of making dank crystal. Everything you cook turns to straight fire, and the money couldn't be be sweeter..
  
Note: Mind your roleplay with this job very carefully. Do not FailRP. To be successful it requires a serious player or you will get yourself in trouble. Do not mug or kidnap as this job. Random killing (RDM) in spawn (or anywhere else) for any reason is restricted and punishable. Always have sound reasons to initiate hostiles first. Any abuse of the position or its features will be punished with a jail stay or a ban. No exceptions. Know that your combat is monitored and logged for admins to review. This job is not exempt from the rules. If you break them, expect that you will receive harsh punishment.
  
-Use /cmd, /commands, /help, /player, /server, or /readme to view available commands and information.
-If you need to reference the rules you can use /rules at any time. :)
  
------------------
	You are allowed to do the following..
  
	1. Base.
	2. Access money printers (F4 > Purchasables).
	3. Cook master quality crystal. (F4 > Purchasables).
	4. Let it be known that you are the one who knocks.
	5. Tell other people to say your name.
	6. You may also go by the alias of "Heisenberg".
------------------
]],	
	weapons = {"zmlab_extractor"},
	command = "zmlab_meth_cook",
	max = 4,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	mayorCanSetSalary = false,
	PlayerSpawn = function(ply) ply:SetHealth("100") ply:SetMaxHealth("100") ply:SetArmor("0") return CLIENT end,
	category = "Pro Criminals",
    sortOrder = 102,
    tier = '6'
})
--=========================================================================================================
--
--
--
--
DarkRP.createEntity("Combiner", {
	ent = "zmlab_combiner",
	model = "models/zerochain/zmlab/zmlab_combiner.mdl",
	price = 6000,
	max = 1,
	cmd = "buycombiner_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})

DarkRP.createEntity("Gas Filter", {
	ent = "zmlab_filter",
	model = "models/zerochain/zmlab/zmlab_filter.mdl",
	price = 1000,
	max = 1,
	cmd = "buyfilter_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})

DarkRP.createEntity("Frezzer", {
	ent = "zmlab_frezzer",
	model = "models/zerochain/zmlab/zmlab_frezzer.mdl",
	price = 2000,
	max = 2,
	cmd = "buyfrezzer_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})

DarkRP.createEntity("Transport Crate", {
	ent = "zmlab_collectcrate",
	model = "models/zerochain/zmlab/zmlab_transportcrate.mdl",
	price = 250,
	max = 5,
	cmd = "buycollectcrate_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})

DarkRP.createEntity("Methylamin", {
	ent = "zmlab_methylamin",
	model = "models/zerochain/zmlab/zmlab_methylamin.mdl",
	price = 1000,
	max = 6,
	cmd = "buymethylamin_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})

DarkRP.createEntity("Aluminium", {
	ent = "zmlab_aluminium",
	model = "models/zerochain/zmlab/zmlab_aluminiumbox.mdl",
	price = 100,
	max = 6,
	cmd = "buyaluminium_zmlab",
	allowed = TEAM_ZMLAB_COOK,
	category = "Contraband"
})
