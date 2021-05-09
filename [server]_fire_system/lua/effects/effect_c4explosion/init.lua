--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/effects/effect_c4explosion/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local smokeMat = Material("effects/fire/smoke02.png","noclamp smooth")

function EFFECT:Init(data)

	local pos = data:GetOrigin()

	for i = 1,750 do

		local xRange = math.random(-150,150)
		local yRange = math.random(-150,150)
		local zRange = math.random(-50,100)
		local vel = Vector(math.random(-xRange,xRange),math.random(-yRange,yRange),math.random(0,zRange)) * 10

		local particle = Icefuse_PARTICLEEMITTER:Add(smokeMat,pos)

		particle:SetColor(255,255,255)
		particle:SetStartAlpha(100)
		particle:SetEndAlpha(0)
		particle:SetVelocity(vel)
		particle:SetLifeTime(0)
		particle:SetDieTime(10)
		particle:SetStartSize(40)
		particle:SetEndSize(50)
		particle:SetAirResistance(200)
		particle:SetCollide(true)
	end
end
