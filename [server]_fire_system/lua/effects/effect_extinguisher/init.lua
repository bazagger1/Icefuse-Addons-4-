--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/effects/effect_extinguisher/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function EFFECT:Init(data)

	local owner = data:GetEntity()
	local flag = data:GetFlags()
	
	if (!owner:IsValid()) then return end 
	if (owner.GetActiveWeapon == nil) then return end
	
	local origin = nil
	
	if (flag == 0) then 
		
		local viewModel = owner:GetViewModel()
		
		if (viewModel == nil) then return end 
		if (!viewModel:IsValid()) then return end
	
		origin = viewModel:GetAttachment(viewModel:LookupAttachment( "muzzle" ))
	else 
	
		local wep = owner:GetActiveWeapon()
		
		if (wep == nil) then return end 
		if (!wep:IsValid()) then return end 
		
		origin = wep:GetAttachment(wep:LookupAttachment("muzzle"))
	end
	
	if (origin == nil) then return end
	
	for i = 1,3 do
	
		local vel = owner:EyeAngles():Forward() * 400 + Vector(math.random(-30,30),math.random(-30,30),math.random(-30,30))
		
		local particle = Icefuse_PARTICLEEMITTER:Add("effects/splash4",origin.Pos)
			
		particle:SetColor(255,255,255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetVelocity(vel)
		particle:SetLifeTime(0)
		particle:SetDieTime(4)
		particle:SetStartSize(2)
		particle:SetEndSize(1)
		particle:SetAirResistance(25)
		particle:SetCollide(true)
	end 
end 