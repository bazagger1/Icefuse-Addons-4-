--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_entity_tie/lua/autorun/sh_tie.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

tie_config = {}

tie_config.set_upright = true // do you want the entities angles when its froze to be normalized?
tie_config.alt_use = true // does the player have to be holding down LALT to active the menu?

tie_config.blacklist = {
	"prop_physics",
	"player",
	"gmod_tie",
}

tie_config.use_whitelist = true // use a whitelist instead?
tie_config.whitelist = {

-------------------------------------------------
--PRINTERS
        'icefuse_printer_copper',
        'icefuse_printer_bronze',
        'icefuse_printer_silver',
        'icefuse_printer_gold',
        'icefuse_printer_emerald',
        'icefuse_printer_ruby',
        'icefuse_printer_sapphire',
        'icefuse_printer_legendary',
-------------------------------------------------
--MOONSHINE
        'mn_distillery',
        'mn_bucket',
        'mn_pot',
        'mn_stand',
		
        'mn_bottle', --
        'mn_corn', --
        'mn_cseed', --
        'mn_dirt', --
        'mn_grain', --
        'mn_gseed', --
        'mn_ccorn', --
        'mn_ggrain', --
        'mn_toppiece', --
        'mn_water', --
--        'mn_barrel', --
-------------------------------------------------
--OPIUM
        'the_opium_heater',
        'the_opium_packer',
		
        'the_opium_barrel', --
        'the_opium_bottle', --
        'the_opium_codeine', --
        'the_opium_gas', --
--        'the_opium_packed', --
        'the_opium_papaverine', --
        'the_opium_sulfate', --
        'the_opium_water', --
-------------------------------------------------
--CRACK
        'the_crack_barrel', --
        'the_crack_bowl', --
--        'the_crack_bucket', --
        'the_crack_compcan', --
        'the_crack_ferment', --
        'the_crack_heater', --
        'the_crack_mircowave', --
        'the_crack_pipekit', --
-------------------------------------------------
--COCA
        'icefuse_coca_plant_lab_desk',
        'icefuse_coca_plant_level1',
        'icefuse_coca_plant_level2',
        'icefuse_coca_plant_level3',
-------------------------------------------------
--METH
        'icefuse_crystal_meth_lab',
		
        'icefuse_crystal_meth_level1', --
        'icefuse_crystal_meth_level2', --
        'icefuse_crystal_meth_level3', --
-------------------------------------------------
--METH ENHANCED
        'zmlab_aluminium', --
        'zmlab_filter', --
--        'zmlab_meth', --
--        'zmlab_meth_baggy', --
        'zmlab_methdropoff', --
        'zmlab_methylamin', --
        'zmlab_collectcrate', --
        'zmlab_palette', --
        'zmlab_combiner', --
        'zmlab_frezzer', --
-------------------------------------------------
--LSD
        'icefuse_lsd_stove',
        'icefuse_lsd_level1',
        'icefuse_lsd_level2',
        'icefuse_lsd_level3',
-------------------------------------------------
--WEED (BASIC)
        'plant_pot',
        'weed_seed',
--        'plant_grow',
-------------------------------------------------
--WEED (MEDICAL)
        'icefuse_weedtable',
        'icefuse_weed_level1',
        'icefuse_weed_level2',
        'icefuse_weed_level3',
-------------------------------------------------
--BITMINERS	
        'bit_miner_light',
        'bit_miner_medium',
        'bit_miner_heavy',
-------------------------------------------------
}

tie_config.can_edit = function( ply, ent )
	if ( ent:GetPos():Distance( ply:GetPos() ) > 200 ) then
		return false
	end
	
	if ( tie_config.use_whitelist and !table.HasValue( tie_config.whitelist, ent:GetClass():lower() ) ) then
		return false
	end
	
	if ( table.HasValue( tie_config.blacklist, ent:GetClass():lower() ) ) then
		return false
	end
	
	if ( ent.isDoor and ent:isDoor() ) then
		return false
	end
	
	if ( FPP and SERVER ) then
		return ent:CPPICanUse( ply )
	end
	
	return true
end