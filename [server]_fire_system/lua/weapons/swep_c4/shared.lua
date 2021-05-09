--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/weapons/swep_c4/shared.lua
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
		name = "c4",
		dmgtype = DMG_GENERIC,
		plydmg = 0,
		npcdmg = 0,
		force = 2000,
		minsplash = 10,
		maxsplash = 5
	} )
end

if (CLIENT) then

	SWEP.PrintName = "C4"
	SWEP.Slot = 2
	SWEP.SlotPos = 2

	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = "Icefuse"
SWEP.Contact = "Contact me on steam"
SWEP.Purpose = "Blows shit up n shit"
SWEP.Instructions = "Left click plant a bomb"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/fire_c4/v_sb.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModel = "models/weapons/fire_c4/w_sb.mdl"
SWEP.HoldType = "slam"

SWEP.UseHands = false

SWEP.Category = "Icefuse Utilities"

SWEP.Weight = 0
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "c4"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()

	self:SetHoldType(self.HoldType)
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

	local tr = self.Owner:GetEyeTrace()
	if (tr.HitPos:Distance(self.Owner:GetPos()) > 200) then return end

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Weapon:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	timer.Simple(self:SequenceDuration(),function()

		if (self.Owner == nil) then return end
		if (!self.Owner:IsValid()) then return end

		self:SendWeaponAnim(ACT_VM_IDLE)

		tr = self.Owner:GetEyeTrace() // update the trace
		if (tr.HitPos:Distance(self.Owner:GetPos()) > 200) then return end
		if (SERVER) then

			self.Owner:EmitSound(table.Random(shFireConfig.bombPlant),75,100,1,CHAN_AUTO)

			// Create a c4

			local ang = tr.HitNormal:Angle()
			ang.r = -90
			ang:RotateAroundAxis(ang:Right(),-90)

			local c4 = ents.Create("sent_c4")
			c4:SetPos(tr.HitPos + ang:Up())
			c4:SetAngles(ang)

			if (tr.Entity:IsValid()) then

					if (tr.Entity:IsPlayer()) then

						local boneIndex = tr.Entity:LookupBone("ValveBiped.Bip01_Spine")
						c4:FollowBone(tr.Entity, boneIndex)
						c4:SetLocalPos(Vector(8, 10, 0))
						c4:SetLocalAngles(Angle(90, 90, 0))

						c4:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

            			tr.Entity:SetNWBool("FireSystemC4.hasBomb", true)

					else
						c4:SetParent(tr.Entity);
					end

					c4:SetSolid(SOLID_NONE);
					c4:SetMoveType(MOVETYPE_NOCLIP);
			end

			c4:Spawn()
			c4:Activate()
			c4:SetPlacer(self.Owner)

			if shFireConfig.c4_autoWanted then
				local reason = "Placing C4 or whatever"
				for _, ply in pairs(player.GetAll()) do

					if ply == self.Owner then
						continue
					end

					local canRequest, message = hook.Call("canRequestWarrant", DarkRP.hooks, self.Owner, ply, reason)
					if canRequest and ply:GetPos():Distance(self.Owner:GetPos()) < shFireConfig.c4_wantedRadius then
						self.Owner:wanted(ply, shFireConfig.c4_wantedText, shFireConfig.c4_wantedDuration)
						break
					end

				end
			end

		end

		self.Owner:RemoveAmmo(1, self:GetPrimaryAmmoType())
	end)

	return true
end

function SWEP:SecondaryAttack()

	return false
end
