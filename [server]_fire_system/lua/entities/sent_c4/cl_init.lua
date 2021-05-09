--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_fire_system/lua/entities/sent_c4/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

killicon.Add( "sent_c4", "vgui/hud/m9k_suicide_bomb", Color(255, 255, 255, 255)  )

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 180)
	cam.Start3D2D(pos + ang:Up() * 2.1, ang, 0.1)
	surface.SetDrawColor(Color(0, 0, 0, 255))
	surface.DrawRect(-12, -32, 30, 18)
	draw.SimpleText(self:GetTimeLeft(), "BudgetLabel", 2, -23, Color(200, 50, 50, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

-- Hud
local function DrawHud()

	local isDefuseTeam = table.HasValue(shFireConfig.c4DefuseTeams, team.GetName(LocalPlayer():Team()))

	for k, v in pairs(ents.FindByClass("sent_c4")) do

		if (v:GetPos():Distance(LocalPlayer():GetPos()) > shFireConfig.viewDistance) then
			continue
		end
		local scrn = (v:GetPos() + v:GetAngles():Up() * 5):ToScreen()
				if v:GetPlacer() == LocalPlayer() then
			local placerText = "C4"
			if isDefuseTeam then
				placerText = (IsValid(v:GetPlacer()) and v:GetPlacer():Nick() or "Disconnected") .. "'s C4"
			end

			draw.SimpleTextOutlined(placerText, "Trebuchet24", scrn.x, scrn.y, Color(150, 150, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
			draw.SimpleTextOutlined(tostring(v:GetTimeLeft()) .. " s", "Trebuchet24", scrn.x, scrn.y + 20, Color(150, 150, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
		end
	end
end


hook.Add("HUDPaint", "sent_c4_hud", DrawHud)

------------------------------------------------------------------------------------------------------------------------
--[[ -----------------------------------------------------------
BombView
------------------------------------------------------------- ]]
local BombView = {
	__meta__ = {}
}

do
	local __class, __meta = BombView, BombView.__meta__
	__meta.__index = __meta
	local DisarmPanel, DisarmWirePanel
	--[[ @var panel ]]
	__meta.panel = nil
	--[[ @var bool ]]
	__meta.disarmed = false
	--[[ @var number ]]
	__meta.explodeTime = 0

	--[[
	-
	]]
	function __class:new(wires)
		local instance = setmetatable({}, self.__meta__)
		instance:init(wires)

		return instance
	end

	local function secondsToText(seconds, format)
		seconds = seconds or 0
		local ms = math.Clamp((seconds - math.floor(seconds)) * 100, 0, 99)
		seconds = math.floor(seconds)
		local s = seconds % 60
		seconds = (seconds - s) / 60
		local m = seconds % 60

		return string.format(format, m, s, ms)
	end

	--[[
	-
	]]
	function __meta:init(wires)
		local panel = vgui.Create("EditablePanel")
		self.panel = panel
		panel:SetSize(320, 330)
		panel:Center()
		panel:MakePopup()

		panel.Paint = function(panel, w, h)
			surface.SetDrawColor(40, 40, 40)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		panel.Think = function(panel)
			self:onTick()
		end

		local cancelButton = vgui.Create("DButton", panel)
		cancelButton:SetSize(panel:GetWide() - 2, 28)
		cancelButton:SetPos(1, panel:GetTall() - 29)
		cancelButton:SetText("close")

		cancelButton.Paint = function(panel, w, h)
			if panel:IsHovered() then
				surface.SetDrawColor(40, 40, 40)
				surface.DrawRect(0, 0, w, h)
			else
				surface.SetDrawColor(30, 30, 30)
				surface.DrawRect(0, 0, w, h)
			end

			surface.SetDrawColor(10, 10, 10)
			surface.DrawLine(0, h - 28, w, h - 28)
			surface.SetDrawColor(50, 50, 50)
			surface.DrawLine(0, h - 27, w, h - 27)
		end

		cancelButton.DoClick = function()
			self:close()
		end

		local infoPanel = vgui.Create("DPanel", panel)
		infoPanel:SetSize(panel:GetWide() - 2, panel:GetTall() - 29 - 256 - 1)
		infoPanel:SetPos(1, 1)

		infoPanel.Paint = function(panel, w, h)
			surface.SetDrawColor(30, 30, 30)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(10, 10, 10)
			surface.DrawLine(0, h - 2, w, h - 2)
			surface.SetDrawColor(50, 50, 50)
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		local timerPanel = vgui.Create("DLabel", infoPanel)
		timerPanel:SetText("99:99:99")
		timerPanel:SetFont("C4Timer")
		timerPanel:SetTextColor(Color(200, 0, 0))
		timerPanel:SetExpensiveShadow(1, Color(0, 0, 0))
		timerPanel:SetSize(infoPanel:GetSize())
		timerPanel:SetContentAlignment(5)

		timerPanel.Think = function(panel)
			if self.disarmed then
				panel:SetTextColor(Color(0, 200, 0))

				return
			end

			local seconds = math.Clamp(self.explodeTime, 0, 2147483647)
			panel:SetText(secondsToText(seconds, "%02i:%02i:%02i"))
		end

		local disarmPanel = vgui.Create("DPanel", panel)
		disarmPanel:SetSize(panel:GetWide() - 2, 256)
		disarmPanel:SetPos(1, panel:GetTall() - 29 - 256)
		disarmPanel.Paint = function() end
		local disarmView = DisarmPanel:new(disarmPanel, wires)

		disarmView.onCutWire = function(_, index)
			self:onCutWire(index)
		end
	end

	--[[
	-
	]]
	function __meta:disarm()
		self.disarmed = true
	end

	--[[
	-
	]]
	function __meta:onCutWire(index)
	end

	-- Override me
	--[[
	-
	]]
	function __meta:close()
		if IsValid(self.panel) then
			self.panel:Remove()
		end

		self:onClose()
	end

	--[[
	-
	]]
	function __meta:onClose()
	end

	-- Override me
	--[[
	-
	]]
	function __meta:onTick()
	end

	-- Override me
	--[[ -----------------------------------------------------------
	DisarmWirePanel
	------------------------------------------------------------- ]]
	DisarmWirePanel = {
		__meta__ = {}
	}

	do
		local __class, __meta = DisarmWirePanel, DisarmWirePanel.__meta__
		__meta.__index = __meta
		local MATERIAL_CUT = Material("vgui/fire_system/c4/cut")
		local MATERIAL_WIRE = Material("vgui/fire_system/c4/wire")
		local MATERIAL_WIRE_CUT = Material("vgui/fire_system/c4/wire_cut")
		-- Wire colors
		local WIRE_COLORS = {Color(200, 000, 000, 255), Color(255, 255, 000, 255), Color(090, 090, 250, 255), Color(255, 255, 255, 255), Color(020, 200, 020, 255), Color(255, 160, 050, 255)}
		-- red
		-- yellow
		-- blue
		-- white/grey
		-- green
		-- brown
		--[ @var panel ]
		__meta.panel = nil

		--[[ @var number ]]
		__meta.wireIndex = nil

		--[[ @var bool ]]
		__meta.isCut = false

		--[[
		-
		]]
		function __class:new(parent, index, colorIndex)
			local instance = setmetatable({}, self.__meta__)
			instance.wireIndex = index
			instance.wireColorIndex = colorIndex
			instance:init(parent)

			return instance
		end

		--[[
		-
		]]
		function __meta:onClick()
			self.isCut = true
			self:onCut()
		end

		--[[
		-
		]]
		function __meta:onCut()
		end

		-- Override me
		--[[
		-
		]]
		function __meta:init(parent)
			local panel = vgui.Create("DImageButton", parent)
			self.panel = panel
			panel:NoClipping(true)
			panel:SetMouseInputEnabled(true)
			panel:MoveToFront()
			panel:SetImage(MATERIAL_WIRE:GetName())

			if self.wireIndex == false then
				panel.PaintOver = panel.BaseClass.PaintOver
				panel.m_Image:SetMaterial(MATERIAL_WIRE_CUT:GetName())
				panel.isCut = true
			end

			panel.m_Image:SetImageColor(WIRE_COLORS[(self.wireColorIndex - 1) % #WIRE_COLORS + 1])

			panel.OnMousePressed = DButton.OnMousePressed
			panel.OnMouseReleased = DButton.OnMouseReleased

			panel.OnCursorEntered = function(panel)
				if not self.isCut then
					panel.PaintOver = panel.PaintOverHovered
				end
			end

			panel.OnCursorExited = function(panel)
				panel.PaintOver = panel.BaseClass.PaintOver
			end

			panel.DoClick = function(panel)
				if parent:GetDisabled() or self.isCut then return end
				panel.PaintOver = panel.BaseClass.PaintOver
				panel.m_Image:SetMaterial(MATERIAL_WIRE_CUT:GetName())
				-- surface.PlaySound(wire_cut)
				self:onClick()
			end

			panel.PaintOverHovered = function(panel)
				surface.SetMaterial(MATERIAL_CUT)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(220, -20, 32, 32)
			end
		end
	end

	-- draw.SimpleText("Cut wire", "DermaDefault", 120, -10, COLOR_WHITE, 0, 0)
	--[[ -----------------------------------------------------------
	DisarmPanel
	------------------------------------------------------------- ]]
	DisarmPanel = {
		__meta__ = {}
	}

	do
		local __class, __meta = DisarmPanel, DisarmPanel.__meta__
		__meta.__index = __meta
		local MATERIAL_BOMB = Material("vgui/fire_system/c4/bomb")
		--[ @var panel ]
		__meta.panel = nil
		--[[ @var table ]]
		__meta.wires = nil
		--[[ @var panel[] ]]
		__meta.wireViews = nil

		--[[
		-
		]]
		function __class:new(parent, wires)
			local instance = setmetatable({}, self.__meta__)
			instance.wires = wires
			instance.wireViews = {}
			instance:init(parent)
			return instance
		end

		--[[
		-
		]]
		function __meta:onCutWire(index)
		end

		-- Override me
		--[[
		-
		]]
		function __meta:init(parent)
			local panel = vgui.Create("DPanel", parent)
			self.panel = panel
			panel:SetSize(parent:GetSize())

			panel.Paint = function(panel, w, h)
				surface.SetDrawColor(30, 30, 30)
				surface.DrawRect(0, 0, w, h)
			end

			local bombPanel = vgui.Create("DImage", panel)
			bombPanel:SetSize(256, 256)
			bombPanel:SetPos(parent:GetWide() - 256, 0)
			bombPanel:SetMaterial(MATERIAL_BOMB)
			local wy = 70

			for k, i in pairs(self.wires) do
				local wireView = DisarmWirePanel:new(parent, i, k)
				wireView.panel:SetPos(-113, wy)
				wireView.panel:SetWide(353)

				wireView.onCut = function()
					self:onCutWire(i)
				end

				table.insert(self.wireViews, wireView)
				wy = wy + 27
			end
		end
	end
end

FireSystemC4 = FireSystemC4 or {}

--[[ -----------------------------------------------------------
BombViewHandler
------------------------------------------------------------- ]]
FireSystemC4.BombViewHandler = FireSystemC4.BombViewHandler or {}
local BombViewHandler = FireSystemC4.BombViewHandler
BombViewHandler.__meta__ = BombViewHandler.__meta__ or {}

do
	local __class, __meta = BombViewHandler, BombViewHandler.__meta__
	__meta.__index = __meta

	--[[ @var BombViewHandler ]]
	__class.instance = __class.instance or nil

	--[[ @var BombView ]]
	__meta.view = nil

	--[[
	- @return BombViewHandler
	]]
	local function new()
		local instance = setmetatable({}, BombViewHandler.__meta__)
		return instance
	end

	--[[
	-
	]]
	function __meta:open(ent, wires)
		if self.view then
			self:close()
		end

		self.view = BombView:new(wires)
		self.view.disarmed = false
		self.view.explodeTime = ent:GetTimeLeft()
		local frame = self.view.panel

		self.view.onCutWire = function(_, index)
			net.Start("sent_c4_disarmattempt")
				net.WriteEntity(ent)
				net.WriteFloat(index)
			net.SendToServer()
		end

		local t
		self.view.onTick = function()
			if not IsValid(ent) then
				if not self.view.disarmed then
					self.view:disarm()
				end

				return
			end

			if t ~= ent:GetTimeLeft() then
				t = ent:GetTimeLeft()
				self.view.explodeTime = t
			end

			self.view.explodeTime = self.view.explodeTime - FrameTime()

			-- Close the frame if the player dies or if is further than 200 away
			if not LocalPlayer():Alive() or LocalPlayer():GetPos():Distance(ent:GetPos()) > 200 then
				frame:Remove()
			end
		end

	end

	--[[
	-
	]]
	function __meta:close()
		if self.view then
			self.view:close()
			self.view = nil
		end
	end

	--[[
	- @return BombViewHandler
	]]
	function __class:getInstance()
		if self.instance == nil then
			self.instance = new()
		end

		return self.instance
	end
end

surface.CreateFont("C4Timer", {
	font = "Arial",
	size = 32,
	weight = 750
})

local lastKeyPress = 0
hook.Add("KeyPress", "FireSystemC4.openMenu", function(ply, key)

	if key ~= IN_USE or lastKeyPress > CurTime() - 0.2 then
		return
	end

    lastKeyPress = CurTime()

	for _, v in pairs(player.GetAll()) do
		if v:GetNWBool("FireSystemC4.hasBomb", false) and ply:GetPos():DistToSqr(v:GetPos()) < 3000 then
			net.Start("FireSystemC4.openMenu")
				net.WriteEntity(v)
			net.SendToServer()
		end
	end

end)

-- Networking
net.Receive("sent_c4_blowup", function()

	local pos = net.ReadVector()

	-- Do effect
	local eff = EffectData()
	eff:SetOrigin(pos)

	util.Effect("HelicopterMegaBomb", eff)
	util.Effect("effect_c4explosion", eff)

	BombViewHandler:getInstance():close()

end)

net.Receive("sent_c4_disarm_menu", function()
	local ent = net.ReadEntity()
	local wires = net.ReadTable()
	BombViewHandler:getInstance():open(ent, wires)
end)
