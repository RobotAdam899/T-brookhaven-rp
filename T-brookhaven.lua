local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- GUI Başlangıcı
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "T_SOCIETY_GUI"
gui.ResetOnSpawn = false

-- Buton Oluşturucu
local function createButton(text, posY, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 220, 0, 40)
	button.Position = UDim2.new(0, 10, 0, posY)
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 16
	button.TextColor3 = Color3.new(1,1,1)
	button.BackgroundColor3 = Color3.fromRGB(30,30,30)
	button.Parent = gui
	button.MouseButton1Click:Connect(callback)
end

-- 💥 BRING ALL PARTS
local function bringParts()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored and not obj:IsDescendantOf(LocalPlayer.Character) then
			obj.Anchored = false
			obj.CanCollide = false

			local bodyPos = Instance.new("BodyPosition")
			bodyPos.Position = obj.Position + Vector3.new(math.random(-20,20), math.random(5,10), math.random(-20,20))
			bodyPos.MaxForce = Vector3.new(1e6,1e6,1e6)
			bodyPos.P = 10000
			bodyPos.D = 500
			bodyPos.Parent = obj

			if math.random() < 0.4 then
				local others = Players:GetPlayers()
				local rnd = others[math.random(1, #others)]
				if rnd ~= LocalPlayer and rnd.Character and rnd.Character:FindFirstChild("HumanoidRootPart") then
					bodyPos.Position = rnd.Character.HumanoidRootPart.Position + Vector3.new(0,3,0)
				end
			end

			game.Debris:AddItem(bodyPos, 5)
		end
	end
end

-- 🌪 HORTUM
local function hortum()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored and not obj:IsDescendantOf(LocalPlayer.Character) then
			obj.Velocity = Vector3.new(math.random(-50,50), math.random(100,150), math.random(-50,50))
			if math.random() < 0.1 then obj:Destroy() end
		end
	end
end

-- ⚠️ GLITCH BRING PARTS
local function glitchParts()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored and not obj:IsDescendantOf(LocalPlayer.Character) then
			obj.Anchored = false
			obj.CanCollide = false

			local bodyPos = Instance.new("BodyPosition")
			bodyPos.Position = obj.Position + Vector3.new(math.random(-10,10), math.random(3,6), math.random(-10,10))
			bodyPos.MaxForce = Vector3.new(1e6,1e6,1e6)
			bodyPos.P = 20000
			bodyPos.D = 800
			bodyPos.Parent = obj

			local others = Players:GetPlayers()
			local rnd = others[math.random(1, #others)]
			if rnd ~= LocalPlayer and rnd.Character and rnd.Character:FindFirstChild("HumanoidRootPart") then
				local pos = rnd.Character.HumanoidRootPart.Position + Vector3.new(math.random(-3,3), 3, math.random(-3,3))
				bodyPos.Position = pos

				-- FLING ETKİSİ
				rnd.Character.HumanoidRootPart.Velocity = Vector3.new(
					math.random(-80,80),
					math.random(100,140),
					math.random(-80,80)
				)
			end

			game.Debris:AddItem(bodyPos, 5)
		end
	end
end

-- 🧹 CHAT SİL (SAHTE)
local function fakeChatWipe()
	local remote = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")
	if not remote then return end
	local msg = "T-SOCIETY:\n\n\n\n\nChat silinmiştir bay"
	remote:FireServer(msg, "All")
end

-- Butonlar
createButton("💥 Bring All Parts", 50, bringParts)
createButton("🌪 Hortum", 100, hortum)
createButton("⚠️ Glitch Bring Parts", 150, glitchParts)
createButton("🧹 Chat Sil (Fake)", 200, fakeChatWipe)
