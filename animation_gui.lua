-- Interfaz de Usuario local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui) ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui) Frame.Size = UDim2.new(0, 200, 0, 300) Frame.Position = UDim2.new(0, 10, 0, 10) Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) Frame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", Frame) UIListLayout.Padding = UDim.new(0, 5)

-- Función para crear botones local function createButton(name) local button = Instance.new("TextButton", Frame) button.Size = UDim2.new(1, -10, 0, 30) button.Position = UDim2.new(0, 5, 0, 0) button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) button.TextColor3 = Color3.new(1, 1, 1) button.Font = Enum.Font.SourceSans button.TextSize = 16 button.Text = name return button end

-- Animaciones local animationPacks = { Default = { walk = 2510235063, run = 2510238622, idle1 = 2510235063, idle2 = 2510238622, jump = 2510238622, fall = 2510238622 }, Stylish = { walk = 616168032, run = 616163682, idle1 = 616158929, idle2 = 616160636, jump = 616161997, fall = 616157476 }, CatwalkGlam = { walk = 15726499514, run = 15726501037, idle1 = 15726502039, idle2 = 15726502039, jump = 15726503347, fall = 15726503347 } }

-- Sistema de guardado usando writefile/readfile local filename = "selected_animation.txt"

local function saveSelection(pack) if writefile then writefile(filename, pack) end end

local function loadSelection() if readfile and isfile and isfile(filename) then return readfile(filename) end return "Default" end

local selectedPack = loadSelection()

-- Aplicar animaciones local function applyAnimationPack(packName) local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid") for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do anim:Stop() end

local anims = animationPacks[packName]
if anims then
	local animateScript = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
	if animateScript then
		for action, id in pairs(anims) do
			local anim = animateScript:FindFirstChild(action)
			if anim and anim:FindFirstChild("Animation") then
				anim.Animation.AnimationId = "rbxassetid://" .. id
			end
		end
	end
end

end

-- Botones local Default = createButton("Default") Default.MouseButton1Click:Connect(function() selectedPack = "Default" saveSelection(selectedPack) applyAnimationPack(selectedPack) end)

local Stylish = createButton("Stylish") Stylish.MouseButton1Click:Connect(function() selectedPack = "Stylish" saveSelection(selectedPack) applyAnimationPack(selectedPack) end)

local CatwalkGlam = createButton("Catwalk Glam") CatwalkGlam.MouseButton1Click:Connect(function() selectedPack = "CatwalkGlam" saveSelection(selectedPack) applyAnimationPack(selectedPack) end)

-- Reaplicar al reaparecer game.Players.LocalPlayer.CharacterAdded:Connect(function(char) char:WaitForChild("Humanoid") char:WaitForChild("Animate") applyAnimationPack(selectedPack) end)

-- Aplicar al cargar applyAnimationPack(selectedPack)

