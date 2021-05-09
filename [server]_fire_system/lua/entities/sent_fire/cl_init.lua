--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/entities/sent_fire/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

// Anticrash

Icefuse_PARTICLEEMITTER = Icefuse_PARTICLEEMITTER || ParticleEmitter(Vector(0,0,0),false)

// Localize 

local math = table.Copy(math)

// Mats 

local flameMat = Material("effects/fire/flamefinal.png","noclamp smooth")
local smokeMat = Material("effects/fire/smoke02.png","noclamp smooth")
//

local config = nil

function ENT:Initialize()

	if (config == nil) then 
	
		config = table.Copy(shFireConfig) // I make alot of calls to this table, so might as well localize it because my code is time critical here
	end

	self.soundPath = ""
	self.makeSmoke = 0
	self.smokeDir = Angle(0,math.random(-180,180),0):Forward()
	
	self:CallOnRemove("sent_fire_remove" .. tostring(self:EntIndex()),function(ent)
	
		if (ent.sound != nil) then 
			
			ent.sound:SetSoundLevel(0)
			ent.sound:ChangeVolume(0,0)
			ent.sound:Stop()
			ent.sound = nil
		end
	end)
end

function ENT:PlaySound(path)

	if (self.sound == nil) then 
		
		self.soundPath = path
		self.sound = CreateSound(self,Sound(path))
		self.sound:Play()
		
	elseif(path != self.soundPath) then 
	
		self.soundPath = path 
		self.sound:Stop()
		self.sound = nil
		self.sound = CreateSound(self,Sound(path))
		self.sound:Play()
	end
end

function ENT:MakeParticle(mat,offset,vel,col,startSize,endSize,rollDelta,dieTime,airResis)

	if (Icefuse_PARTICLEEMITTER == nil) then return end
	
	//local particle = Icefuse_PARTICLEEMITTER:Add("sprites/flamelet" .. tostring(math.random(1,5)),self:GetPos() + offset)
	local particle = Icefuse_PARTICLEEMITTER:Add(mat,self:GetPos() + offset)

	particle:SetColor(col.a,col.g,col.b)
	particle:SetStartAlpha(10)
	particle:SetEndAlpha(col.a)
	particle:SetVelocity(vel)
	particle:SetLifeTime(0)
	particle:SetDieTime(dieTime)
	particle:SetStartSize(startSize)
	particle:SetEndSize(endSize)
	particle:SetRollDelta(rollDelta)
	particle:SetCollide(true)
	
	if (airResis) then 
		particle:SetAirResistance(25)
	end	
end

function ENT:Draw()

	if (LocalPlayer():GetPos():Distance(self:GetPos()) > config.viewDistance) then return end
	if (LocalPlayer():GetPos():Distance(self:GetPos()) > config.viewDistance / 2) then 
	
		if (QuickTrace(LocalPlayer():GetShootPos(),self:GetPos(),LocalPlayer()).Hit) then return end
	end
	self:DrawModel()
	
	// Particles
	
	local offset = Vector(math.random(-self:GetOffset(),self:GetOffset()),math.random(-self:GetOffset(),self:GetOffset()),0) * self:GetStrength()
	local vel = Vector(math.random(-25,25),math.random(-25,25),math.random(30,80)) * self:GetStrength()
	local startSize = math.random(config.particleStartSize[1],config.particleStartSize[2]) * self:GetStrength()
	local endSize = math.random(config.particleEndSize[1],config.particleEndSize[2]) * self:GetStrength()
	local rollDelta = math.random(config.particleRollDelta[1],config.particleRollDelta[2]) * self:GetStrength()
	local dieTime = math.random(config.particleLifeSpan[1],config.particleLifeSpan[2]) * self:GetStrength()
	
	self:MakeParticle(flameMat,offset,vel,Color(255,255,255,255),startSize,endSize,rollDelta,dieTime,true) // fire 
	
	// Smoke
	self.makeSmoke = self.makeSmoke + 1
	if (self:GetStrength() > 0.9 && self.makeSmoke > 10) then 
		
		local smokeVel = Vector(self.smokeDir.x,self.smokeDir.y * math.random(40,50),85)
	
		self:MakeParticle(smokeMat,offset + Vector(0,0,30),smokeVel,Color(255,255,255,255),60,30,rollDelta / 2,dieTime * 1.5,false)
		self.makeSmoke = 0
	end
end

function ENT:Think()

	if (LocalPlayer():GetPos():Distance(self:GetPos()) > 1000) then 
	
		if (self.sound) then 
			
			self.sound:ChangeVolume(0,0)
			self.sound:Stop()
			self.sound = nil
		end 
	else 

		local path = "ambient/fire/fire_small1.wav"

		if (self:GetStrength() >= .5) then
			
			path = "ambient/fire/firebig.wav"
		end

		self:PlaySound(path)
	end
end

// HUD

local function FireHud()

	if (team.GetName(LocalPlayer():Team()) == shFireConfig.ffTeamName) then
		
		for k,v in pairs(ents.FindByClass("sent_fire")) do
			
			if (!v:IsValid()) then continue end
			if (LocalPlayer():GetPos():Distance(v:GetPos()) > config.viewDistance) then continue end
	
			local scrn = (v:GetPos() + Vector(0,0,50)):ToScreen()
			draw.SimpleTextOutlined("Fire","Trebuchet24",scrn.x,scrn.y,Color(255,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
			
			local w = 100
			
			surface.SetDrawColor(Color(255,0,0,255))
			surface.DrawRect(scrn.x - w/2,scrn.y + 10,w * v:GetStrength(),10)
			surface.SetDrawColor(Color(0,0,0,255))
			surface.DrawOutlinedRect(scrn.x - w/2,scrn.y + 10,w,10)
		end 
	end
end 


hook.Add("HUDPaint","sent_fire_firehud",FireHud)
