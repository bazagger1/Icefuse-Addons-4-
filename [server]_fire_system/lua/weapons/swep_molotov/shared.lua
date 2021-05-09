--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/weapons/swep_molotov/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



if (SERVER) then

		AddCSLuaFile()
		
		game.AddAmmoType( {
				name = "molotov",
				dmgtype = DMG_GENERIC,
				plydmg = 0,
				npcdmg = 0,
				force = 2000,
				minsplash = 10,
				maxsplash = 5
		} )
end

if (CLIENT) then

		SWEP.PrintName = "Molotov Cocktail"
		SWEP.Slot = 2
		SWEP.SlotPos = 2

		SWEP.DrawAmmo = false
		SWEP.DrawCrosshair = true
end

SWEP.Author = "Icefuse"
SWEP.Contact = "Contact me on steam"
SWEP.Purpose = "Makes fires n shit"
SWEP.Instructions = "Left click to throw"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/fire_molotov/v_molotov.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModel = "models/props_junk/garbage_glassbottle003a.mdl"
SWEP.HoldType = "grenade"

SWEP.UseHands = false

SWEP.Category = "Icefuse Utilities"

SWEP.Weight = 0
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "molotov"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()

		self:SetHoldType(self.HoldType)

		if (CLIENT) then
				self:CallOnRemove("swep_molotov_cleanup" .. self:EntIndex(),function(ent)

				if (self.model) then

					self.model:Remove()
				end
			end)
		end
end

function SWEP:Think()

		if (CLIENT) then return end

		if (self:Ammo1() <= 0) then

			self.Owner:StripWeapon(self:GetClass())
			return
		end
end

function SWEP:Deploy()

		self:SendWeaponAnim(ACT_VM_DRAW)
		self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
		return true
end

function SWEP:PrimaryAttack()

		if (self:Ammo1() <= 0) then return end

		if (SERVER) then

			// Throw molotov

			local molotov = ents.Create("sent_molotov")
			molotov:SetPos(self.Owner:GetShootPos() + self.Owner:GetAngles():Forward() * 20)
			molotov:Spawn()
			molotov:Activate()

			local physOb = molotov:GetPhysicsObject()
			if (physOb:IsValid()) then

					physOb:ApplyForceCenter(self.Owner:GetAimVector() * 2500)
			end

			self.Owner:EmitSound("weapons/slam/throw.wav",100,100,1,CHAN_AUTO)
		end

		self.Owner:RemoveAmmo(1, self:GetPrimaryAmmoType())

		self.Weapon:SendWeaponAnim(ACT_VM_THROW)
		self.Weapon:SetNextPrimaryFire(CurTime() + 3)

		timer.Simple(0.25,function()

				if (self:IsValid()) then

					self:SendWeaponAnim(ACT_VM_DRAW)
				end
		end)

		return true
end

if (CLIENT) then

	function SWEP:Holster()

			if (self.model != nil) then

				self.model:Remove()
			end

		return true
	end

	function SWEP:DrawWorldModel()

			if (self.Owner == nil || !self.Owner:IsValid()) then

				self:DrawModel()
				return
			end

			if (self.model == nil || !self.model:IsValid()) then

				self.model = ClientsideModel( "models/props_junk/garbage_glassbottle003a.mdl", RENDERGROUP_OTHER )
				return
			end

			local bonePos,boneAng = self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))

			local ang = boneAng
			ang:RotateAroundAxis(ang:Forward(),180)

			self.model:SetPos(bonePos + boneAng:Forward() * 2.5 - boneAng:Right() * 1.5)
			self.model:SetAngles(ang)
		end
end

function SWEP:SecondaryAttack()

		return false
end
