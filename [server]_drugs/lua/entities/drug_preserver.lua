--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_drugs/lua/entities/drug_preserver.lua
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

ENT.PrintName = "Life Preserver" -- dont change anything here except for this name
ENT.Author = "LegendofRobbo"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Category = "Icefuse Drugs"

ENT.Spawnable = true


---------------- EDIT THIS STUFF FOR CUSTOM DRUGS ----------------
ENT.DrugModel = "models/props_lab/jar01b.mdl"
ENT.DrugModelColor = Color(150, 255, 195)
ENT.DrugSound = "npc/barnacle/barnacle_gulp1.wav" -- the sound the drug makes when you use it
ENT.DrugEffect = "Preserver" -- what effect it gives you
ENT.DrugTime = 120 -- how much effect duration it gives you, effect duration can stack with multiple doses
-- clientside only
ENT.DrugColor = Color(150, 255, 195) -- the colour of the title text
ENT.DrugDescription = "Preserver creates a reservoir of adrenaline that is realeased when your body senses death nearing\nIt effectively saves you from what would otherwise be a lethal blow"
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
activator:EmitSound(self.DrugSound, 75, 100)
self:Remove()
end


end