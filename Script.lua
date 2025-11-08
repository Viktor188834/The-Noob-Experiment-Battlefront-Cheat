-- Боевой фронт Noob Experiment
print("The Script Was Started")
print("Subscribe To telegram chanel!")
print("https://t.me/WhatThePlace7")
print("")
local BestCharacter = "Noob"
local Difficulty = {
	["Hard"] = "hard",
	["Easy"] = "easy",
	["Medium"] = "medium",
	["Nightmare"] = "necro",
	["BossRush"] = "boss rush"
}

local To_Select_Difficulty = {}

for i,v in Difficulty do
	To_Select_Difficulty[i] = {i, function()
		ToCompletingDifficulty = v
	end}
end

local ZombieMinus = {
	"Cloned Giant Acidic Experiment",
	"Cloned Large Acidic Experiment",
	"Cloned Acidic Experiment",
	"Enraged Cloned Giant Acidic Experiment",
	""
}

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

function Get_Humanoid()
	if char then
		if char:FindFirstChildOfClass("Humanoid") then
			return char:FindFirstChildOfClass("Humanoid")
		end
	end
	return nil
end

local Maps = {
	["Crossroad"] = "crossroad",
	["Roblox_Hq"] = "roblox hq",
	["City"] = "city",
	["Desert"] = "desert",
	["Tundra"] = "tundra",
	["BattleField"] = "battlefield"
}

local To_Maps_Select = {}

for i,v in Maps do
	To_Maps_Select[i] = {i, function()
		ToCompletingMap = v
	end}
end

local Votes = {
	Difficulty = game:GetService("ReplicatedStorage").Votes.Voted,
	Maps = game:GetService("ReplicatedStorage").Votes.MapVoted
}

local ToCompletingMap = Maps.Crossroad
local ToCompletingDifficulty = Difficulty.Nightmare
local EnemiesFolder = workspace.Enemies

local Status = {
	Difficulty = game:GetService("ReplicatedStorage").Status.Difficulty.Value,
	Wave = game:GetService("ReplicatedStorage").Status.Wave.Value
}

game:GetService("RunService").Heartbeat:Connect(function()
	Status.Difficulty = game:GetService("ReplicatedStorage"):WaitForChild("Status"):WaitForChild("Difficulty").Value
	Status.Wave = game:GetService("ReplicatedStorage"):WaitForChild("Status"):WaitForChild("Wave").Value
end)

local O1 = false
local O2 = false
local O3 = false
local O4 = false
local O5 = false
local O6 = false
local O7 = false
local O8 = false
local O9 = false
local O10 = false
local O11 = false
local O12 = false
local O13 = false
local TitanMorph = ""
local SpecialTitanMorph = ""
local Speed = 24

plr.CharacterAdded:Connect(function(NewCha)
	char = NewCha
	if char.Name ~= BestCharacter and O5 == true and char.Name ~= TitanMorph and char.Name ~= SpecialTitanMorph then
		game:GetService("ReplicatedStorage").MorphEvent:FireServer(BestCharacter, false, false)--[[
			[2] -- In The Intermission shop / true
			[3] -- nil / false
		]]
	end
	if O1 == true then
		repeat
			game:GetService("RunService").Heartbeat:Wait()
			if not char then
				repeat
					wait()
				until char
			end
			local Humanoid = Get_Humanoid()
			if O2 == true and Status.Wave == 0 then
				Vote()
			end
			local Enemy = Get_MaxHealth_Top()
			if Enemy then
				if O4 == true then
					Teleport(Enemy:WaitForChild("HumanoidRootPart").CFrame*CFrame.new(0, 0, Enemy:WaitForChild("HumanoidRootPart").Size.Y))
				else
					Move(Enemy:WaitForChild("HumanoidRootPart").Position)
				end
				if O7 == true and O4 == true and Humanoid.Health <= (Humanoid.MaxHealth/4) then
					Teleport(Enemy:WaitForChild("HumanoidRootPart").CFrame*CFrame.new(0, -100, 0))
				elseif O7 == true and O4 == false and Humanoid.Health <= (Humanoid.MaxHealth/4) then
					UseOnlyName("Teleport")
				end
				if math.random(1, 31) == 22 or O6 == true then
					UseEverything()
				else
					UseOnly("LMB")
				end
			end
		until O1 == false
	end
end)

function Vote()
	Votes.Difficulty:FireServer(ToCompletingDifficulty)
	Votes.Maps:FireServer(ToCompletingMap)
end

function Move(EndPoint: Vector3)
	if char:FindFirstChildOfClass("Humanoid") then
		local h = char:FindFirstChildOfClass("Humanoid")
		h:MoveTo(EndPoint)
		return true
	end
	return false
end

function Fire(remote: RemoteEvent)
	if remote then
		remote:FireServer()
	end
end

function UseEverything()
	local Abilities = char:FindFirstChild("Abilities")
	if Abilities then
		for i,v in Abilities:GetChildren() do
			if v.Name ~= "Jetpack" and v.Name ~= "Teleport" then
				Fire(v:FindFirstChildOfClass("RemoteEvent"))
			end
		end
	end
end

function UseOnly(KeybindName: string)
	local Abilities = char:FindFirstChild("Abilities")
	if Abilities then
		for i,v in Abilities:GetChildren() do
			if v:FindFirstChild(KeybindName) then
				Fire(v:FindFirstChildOfClass("RemoteEvent"))
			end
		end
	end
end

function UseOnlyName(name: string)
	local Abilities = char:FindFirstChild("Abilities")
	if Abilities then
		for i,v in Abilities:GetChildren() do
			if v.Name == name then
				Fire(v:FindFirstChildOfClass("RemoteEvent"))
			end
		end
	end
end

function GetNearestEnemy()
	local nearestEnemy = nil
	local nearestDistance = 10000
	for i, v in EnemiesFolder:GetChildren() do
		local EnemyCharacter = v
		local EnemyHRP = EnemyCharacter:FindFirstChild("HumanoidRootPart")
		local Distance = nil
		if EnemyHRP then
			Distance = (EnemyHRP.Position - char:WaitForChild("HumanoidRootPart").Position).Magnitude
		end
		if Distance and Distance < nearestDistance then
			nearestDistance = Distance
			nearestEnemy = EnemyCharacter
		end
	end
	return nearestEnemy
end

function Get_MaxHealth_Top()
	local Top = nil
	local Max = 1
	for i, v in EnemiesFolder:GetChildren() do
		local Cant = false
		for i,CantName in ZombieMinus do
			if v.Name == CantName then
				Cant = true
			end
		end
		local hum = v:WaitForChild("Humanoid")
		if hum.MaxHealth > Max and Cant == false then
			Max = hum.MaxHealth
			Top = v
		end
	end
	return Top
end

function Teleport(cframe)
	char:WaitForChild("HumanoidRootPart").CFrame = cframe
end

local Guis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Viktor188834/GuiCanMakeYou/refs/heads/main/Script.lua"))()
--Guis:AddSlideButton(Text, functionOn, functionOff, TextOnMouseEnter)
--Guis:AddButtonToSelectPlayer(Text, funcWithPlayerInstance, TextOnMouseEnter)
--Guis:AddClickButton(Text, fun, TextOnMouseEnter)
--Guis:AddTextBox(Text, funWithText, TextOnMouseEnter)
--Guis:AddKeybind(Text, fun, TextOnMouseEnter)
--Guis:AddSection(Text)
--Guis:TextAccuracy(Text, TextLabelOrTextButton) -- Acuracy Text
--Guis:AddSliderButton(MinValue, MaxValue, Text, FunctionWithNumber, TextOnMouseEnter)

local Farm = Guis:AddSection("Auto Farm")

local MoneyText = Farm:Text("Money: "..tostring(plr:WaitForChild("Money").Value))

game:GetService("RunService").Heartbeat:Connect(function()
	MoneyText.Text = "Money: "..tostring(plr:WaitForChild("Money").Value) 
end)

Farm:AddSlideButton("Main", function()
	O1 = true
	repeat
			game:GetService("RunService").Heartbeat:Wait()
			if not char then
				repeat
					wait()
				until char
			end
			local Humanoid = Get_Humanoid()
			if O2 == true and Status.Wave == 0 then
				Vote()
			end
			local Enemy = Get_MaxHealth_Top()
			if Enemy then
				if O4 == true then
					Teleport(Enemy:WaitForChild("HumanoidRootPart").CFrame*CFrame.new(0, 0, Enemy:WaitForChild("HumanoidRootPart").Size.Y))
				else
					Move(Enemy:WaitForChild("HumanoidRootPart").Position)
				end
				if O7 == true and O4 == true and Humanoid.Health <= (Humanoid.MaxHealth/4) then
					Teleport(Enemy:WaitForChild("HumanoidRootPart").CFrame*CFrame.new(0, -100, 0))
				elseif O7 == true and O4 == false and Humanoid.Health <= (Humanoid.MaxHealth/4) then
					UseOnlyName("Teleport")
				end
				if math.random(1, 31) == 22 or O6 == true then
					UseEverything()
				else
					UseOnly("LMB")
				end
			end
		until O1 == false
end, function()
	O1 = false
end)

Farm:Text("Auto Vote")

Farm:AddSlideButton("Auto Vote Difficulty", function()
	O2 = true
end, function()
	O2 = false
end, "Auto Vote Difficulty and Map")

Farm:SelectButtons("Choose Difficulty", 3, "", 5, To_Select_Difficulty)

Farm:SelectButtons("Choose Map", 3, "", 5, To_Maps_Select)

Farm:AddSlideButton("Auto Vote Skip", function()
	O3 = true
	repeat
		game:GetService("ReplicatedStorage").Votes.SkipVoted:FireServer("Yes")
		wait(math.random(1, 5))
	until O3 == false
end, function()
	O3 = false
end, "Auto Skip Helicopter")

Farm:AddSlideButton("Teleport To Enemy", function()
	O4 = true
end, function()
	O4 = false
end, "Teleporting To Enemy")

Farm:AddSlideButton("Morph Character", function()
	O5 = true
end, function()
	O5 = false
end, "Auto Morphing To "..BestCharacter)

Farm:AddTextBox("Change Morph", function(t)
	BestCharacter = t
end, "Change Morph Character")

Farm:AddSlideButton("Use Everythink", function()
	O6 = true
end, function()
	O6 = false
end, "Use Every Ability")

Farm:AddSlideButton("Safe", function()
	O7 = true
end, function()
	O7 = false
end, "Teleporting Up If Low Hp")

Farm:Text("Titan Morph / 2000 Money")

Farm:AddTextBox("Morphing Name", function(t)
	TitanMorph = t
end, "from Noob Experiment")

local G1 = Farm:AddSlideButton("Activate", function()
	O8 = true
	repeat
		repeat
			wait()
		until plr:WaitForChild("Money").Value >= 2000 or O8 == false
		if O8 == true and char.Name ~= TitanMorph and char.Name ~= SpecialTitanMorph then
			game:GetService("ReplicatedStorage").MorphEvent:FireServer(TitanMorph, true, false)--[[
				[2] -- Titan Calling / false
				[3] -- Special Titan Calling / false
			]]
		end
	until O8 == false
end, function()
	O8 = false
end)

Farm:Text("Special Titan Morph / 5000 Money")

Farm:AddTextBox("Morphing Name", function(t)
	SpecialTitanMorph = t
end)

local G2 = Farm:AddSlideButton("Activate", function()
	O9 = true
	repeat
		repeat
			wait()
		until plr:WaitForChild("Money").Value >= 5000 or O9 == false
		if O9 == true and char.Name ~= SpecialTitanMorph then
			game:GetService("ReplicatedStorage").MorphEvent:FireServer(SpecialTitanMorph, false, true)--[[
				[2] -- Titan Calling / false
				[3] -- Special Titan Calling / false
			]]
		end
	until O9 == false
end, function()
	O9 = false
end)

local Configurations = Guis:AddSection("Configuration")

Configurations:AddSliderButton(1, 125, "Set Speed", function(num)
	Speed = num
end)

Configurations:AddSlideButton("Set", function()
	O10 = true
	repeat
		wait()
		Get_Humanoid().WalkSpeed = Speed
	until O10 == false
end, function()
	O10 = false
end)
