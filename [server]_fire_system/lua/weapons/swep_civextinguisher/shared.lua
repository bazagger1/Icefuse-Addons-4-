--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/weapons/swep_civextinguisher/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local isBlind = false
local alpha = 0

if (SERVER) then

	AddCSLuaFile()

	// Network

	game.AddAmmoType( {
		name = "civextinguisher",
		dmgtype = DMG_GENERIC,
		plydmg = 0,
		npcdmg = 0,
		force = 0,
		minsplash = 0,
		maxsplash = 0,
	} )
end

if (CLIENT) then

	SWEP.PrintName = "Civilian Fire Extinguisher"
	SWEP.Slot = 2
	SWEP.SlotPos = 3

	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = "Icefuse"
SWEP.Contact = "Contact me on steam"
SWEP.Purpose = "Puts out fires n shit"
SWEP.Instructions = "Left click to put out fires"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/fire_extinguisher/c_fire_extinguisher.mdl"
SWEP.ViewModelFOV = 55

SWEP.WorldModel = "models/weapons/fire_extinguisher/w_fire_extinguisher.mdl"
SWEP.HoldType = "slam"

SWEP.UseHands = true

SWEP.Category = "Icefuse Utilities"

SWEP.Weight = 0
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 400
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "civextinguisher"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()

	self:SetHoldType( self.HoldType )

	self:CallOnRemove("swep_extinguisher_stopsound" .. tostring(self:EntIndex()),function(ent)

		if (ent.wepSound != nil) then

			ent.wepSound:Stop()
		end
	end)
end

function SWEP:Think()

	if (CLIENT) then

		if (self.Owner:KeyDown(IN_ATTACK) && self:Clip1() > 0) then

			local data = EffectData()
			data:SetEntity(self.Owner)
			data:SetFlags(0)

			util.Effect("effect_extinguisher",data)
		end
		return
	end

	if (self.Owner:KeyDown(IN_ATTACK) && self:Clip1() + self:Ammo1() > 0) then

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		if (self:Clip1() <= 0 ) then
			self:SetClip1(self.Primary.ClipSize)
			self.Owner:RemoveAmmo(self.Primary.ClipSize,"civextinguisher")
		else

			self:SetClip1(self:Clip1() - 1)
		end



		if (self.wepSound == nil) then

			self.wepSound = CreateSound(self.Owner,Sound( "weapons/extinguisher/fire1.wav" ))
			self.wepSound:Play()

			net.Start("swep_extinguisher_doeffects")

				net.WriteBool(true)
				net.WriteEntity(self.Owner)
			net.Broadcast()
		end

		// Extinguish some fires

		for k,v in pairs(ents.FindInSphere(self.Owner:GetPos(),250)) do

			local aimDiff = nil

			if (v:IsPlayer() && shFireConfig.extinguisherCanBlind && !v:HasGodMode()) then

				if (QuickTrace(self.Owner:GetShootPos(),v:LocalToWorld(v:OBBCenter()),{self.Owner,v}).Hit) then continue end

				aimDiff = (((v:EyePos() + Vector(0,0,7)) - self.Owner:GetAngles():Right() * 10) - self.Owner:GetShootPos()):GetNormalized()

				// blind

				if (v.hasBeenBlinded == nil) then

					v.hasBeenBlinded = false
				end

				if (v.hasBeenBlinded) then continue end
				if (v == self.Owner) then continue end

				if (aimDiff:Dot(self.Owner:GetAimVector()) > 0.995) then

					net.Start("swep_extinguisher_blind")

						net.WriteFloat(shFireConfig.civExtBlindTime)
					net.Send(v)


					v:EmitSound(table.Random(shFireConfig.blindSounds),75,100,1,CHAN_AUTO)
					v.hasBeenBlinded = true

					timer.Simple(shFireConfig.civExtBlindCD,function()

						if (!v:IsValid()) then return end
						v.hasBeenBlinded = false
					end)
				end
			elseif (v:GetClass() == "sent_fire") then

				aimDiff = (v:GetPos() - self.Owner:GetShootPos()):GetNormalized()

				if (aimDiff:Dot(self.Owner:GetAimVector()) > 0.9) then // extinguish some shit

					v:SetStrength(v:GetStrength() - (shFireConfig.civExtStrength / (66.66 / (1/FrameTime()))))
				end

			elseif (v:GetClass() == "prop_physics") then

				if (v:IsOnFire()) then

					aimDiff = (v:GetPos() - self.Owner:GetShootPos()):GetNormalized()

					if (aimDiff:Dot(self.Owner:GetAimVector()) > 0.9) then // extinguish some shit

						v:Extinguish()
						v:SetColor(Color(255,255,255,255))
						v.life = shFireConfig.propLife
					end
				end
			end
		end

	else

		self:SendWeaponAnim( ACT_VM_IDLE )

		if (self.wepSound != nil) then
			
			self.wepSound:Stop()
			self.wepSound = nil
		end

		net.Start("swep_extinguisher_doeffects")

			net.WriteBool(false)
			net.WriteEntity(self.Owner)
		net.Broadcast()

		if (self:Clip1() <= 0 && self:Ammo1() <= 0) then

			local prop = ents.Create("prop_physics")
			prop:SetModel("models/weapons/fire_extinguisher/w_fire_extinguisher.mdl")
			prop:SetPos(self.Owner:GetPos() + Vector(0,0,40) + self.Owner:EyeAngles():Forward() * 25)
			prop:Spawn()

			local propPhys = prop:GetPhysicsObject()

			if (propPhys:IsValid()) then

				propPhys:ApplyForceCenter(self.Owner:GetAimVector() * 1500)
			end

			timer.Simple(3,function()

				if (!prop:IsValid()) then return end

				prop:Remove()
			end)

			self.Owner:StripWeapon("swep_civextinguisher")
		end
	end
end

function SWEP:Holster()

	if (CLIENT) then return end

	if (self.wepSound != nil) then

		self:SendWeaponAnim( ACT_VM_IDLE )
		self.wepSound:Stop()
		self.wepSound = nil
		net.Start("swep_extinguisher_doeffects")

			net.WriteBool(false)
			net.WriteEntity(self.Owner)
		net.Broadcast()
	end

	return true
end

function SWEP:Deploy()

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:PrimaryAttack()

	return false
end

function SWEP:SecondaryAttack()

	return false
end
