--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_drugs/lua/entities/drug_ciggies.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "drug_ent"

ENT.PrintName = "Cigarettes" -- dont change anything here except for this name
ENT.Author = "LegendofRobbo"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Category = "Icefuse Drugs"

ENT.Spawnable = true


---------------- EDIT THIS STUFF FOR CUSTOM DRUGS ----------------
ENT.DrugModel = "models/boxopencigshib.mdl"
ENT.DrugModelColor = Color(255,255,255)
ENT.DrugSound = "vo/npc/male01/yeah02.wav" -- the sound the drug makes when you use it
ENT.DrugEffect = "Nicotine" -- what effect it gives you
ENT.DrugTime = 60 -- how much effect duration it gives you, effect duration can stack with multiple doses
-- clientside only
ENT.DrugColor = Color(25,25,25) -- the colour of the title text
ENT.DrugDescription = "A pack of cigarettes\nHelps you unwind after a stressful day" -- its description, remember to use newline (/n) to make multiple lines
ENT.DrugLegal = true -- is this a counterfeit drug or an over-the-counter pharmacy drug
------------------------------------------------------------------




---------------- DONT MESS WITH THIS UNLESS YOU KNOW HOW TO CODE ----------------
if SERVER then

function ENT:Initialize()
	self:SetModel( self.DrugModel )
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
 	self:SetColor( self.DrugModelColor )
	self:SetUseType( SIMPLE_USE )
	
	local PhysAwake = self:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:Use( activator, caller )
if activator:HasBuff( "Overdose" ) then return end
activator:AddBuff( self.DrugEffect, self.DrugTime )
activator:SetHealth(math.Clamp(activator:Health() + 10, 0, activator:GetMaxHealth() ) )
for i = 1, 3 do timer.Simple( (i * 0.8) - 0.8, function() if activator:IsValid() then activator:EmitSound("ambient/misc/clank4.wav", 100, 235) end end) end
timer.Simple( 1.8, function() if activator:IsValid() then activator:EmitSound("player/suit_sprint.wav", 100, 40) end end)
self:Remove()
end


end