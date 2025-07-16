-- 🔥 Fire All Fonksiyonu
local Workspace = game:GetService("Workspace")
local fireActive = false

local function toggleFireAll()
    fireActive = not fireActive
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if fireActive then
                if not v:FindFirstChild("🔥FireEffect") then
                    local fire = Instance.new("Fire", v)
                    fire.Name = "🔥FireEffect"
                    fire.Size = 10
                    fire.Heat = 25
                end
            else
                local fire = v:FindFirstChild("🔥FireEffect")
                if fire then
                    fire:Destroy()
                end
            end
        end
    end
end

-- 🔘 GUI Butonu (örnek yerleştirme)
local fireButton = Instance.new("TextButton")
fireButton.Size = UDim2.new(0, 200, 0, 50)
fireButton.Position = UDim2.new(0.5, -100, 0.3, 0)
fireButton.Text = "🔥 Fire All"
fireButton.TextScaled = true
fireButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
fireButton.TextColor3 = Color3.new(1, 1, 1)
fireButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gui").Main -- GUI yolunu sistemine göre ayarla

fireButton.MouseButton1Click:Connect(function()
	toggleFireAll()
	fireButton.Text = fireActive and "🔥 Fire All (On)" or "🔥 Fire All (Off)"
end)
