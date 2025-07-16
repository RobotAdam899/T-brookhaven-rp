-- T-SOCIETY KIYAMETİ - DELTA UYUMLU GLITCH SÜRÜMÜ
-- Yapan: botkullanici099 & ChatGPT

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Center = Instance.new("Part", Workspace)
Center.Anchored = true
Center.CanCollide = false
Center.Transparency = 1
Center.Size = Vector3.new(1, 1, 1)
Center.Position = Vector3.new(0, 100, 0) -- Ortada dursun

local Attachment1 = Instance.new("Attachment", Center)

-- Fizik sistemini aktive et
getgenv().Glitchify = function()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored and not obj:IsDescendantOf(LocalPlayer.Character) then
			if not obj:FindFirstChild("GlitchAttach") then
				local at = Instance.new("Attachment", obj)
				at.Name = "GlitchAttach"

				local align = Instance.new("AlignPosition", obj)
				align.Attachment0 = at
				align.Attachment1 = Attachment1
				align.MaxForce = math.huge
				align.MaxVelocity = math.huge
				align.Responsiveness = 200

				local torque = Instance.new("Torque", obj)
				torque.Attachment0 = at
				torque.Torque = Vector3.new(50000, 50000, 50000)

				-- Glitch efekti: oyunculara çarparsa titreme yarat
				obj.Touched:Connect(function(hit)
					local human = hit.Parent:FindFirstChild("Humanoid")
					if human and hit.Parent ~= LocalPlayer.Character then
						local root = hit.Parent:FindFirstChild("HumanoidRootPart")
						if root then
							root.Velocity = Vector3.new(math.random(-50, 50), 80, math.random(-50, 50))
						end
					end
				end)
			end
		end
	end
end

-- Loop
RunService.Heartbeat:Connect(function()
	Attachment1.WorldPosition = LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
end)

Glitchify()
Workspace.DescendantAdded:Connect(function(obj)
	task.wait(0.2)
	pcall(function() Glitchify() end)
end)

print("✅ T-SOCIETY Kıyameti başlatıldı.")
