local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/PiterNaGitHub/PiterNaGitHub/main/text.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "cframe fly success executed report any bugs to my discord server: https://discord.gg/zcWzFTrP6R";
Title = "made by piter";
Duration = 15;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Camera = game:GetService("Workspace").CurrentCamera
 
local Fly = false
local FlyPart = nil
local FlySpeed = 75
 
local Keys = {W = false, A = false, S = false, D = false}
 
if game.Lighting:FindFirstChild("TheEvilDeveloper:Fl1") then
    return nil
end
UserInputService.InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode.Z then --------------- u can change keybind here `rejoin requaired`
        Fly = not fly
    elseif Key.KeyCode == Enum.KeyCode.W then
        Keys.W = true
    elseif Key.KeyCode == Enum.KeyCode.A then
        Keys.A = true
    elseif Key.KeyCode == Enum.KeyCode.S then
        Keys.S = true
    elseif Key.KeyCode == Enum.KeyCode.D then
        Keys.D = true
    end
end)
 
UserInputService.InputEnded:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.W then
        Keys.W = false
    elseif Input.KeyCode == Enum.KeyCode.A then
        Keys.A = false
    elseif Input.KeyCode == Enum.KeyCode.S then
        Keys.S = false
    elseif Input.KeyCode == Enum.KeyCode.D then
        Keys.D = false
    end
end)
 
RunService.Heartbeat:Connect(function()
    local RootPart = Player.Character.HumanoidRootPart
    if FlyPart == nil then 
        FlyPart = Instance.new("Part", Lighting)
        FlyPart.Name = "TheEvilDeveloper:Fl1"
        FlyPart.Size = RootPart.Size
    end
    if Fly ~= false then
        RootPart.CFrame = FlyPart.CFrame
    else
        FlyPart.CFrame = RootPart.CFrame
    end
end)
 
while true do
    local Delta = RunService.RenderStepped:Wait()
    local RootPart = Player.Character.HumanoidRootPart
    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
    if Humanoid == nil then
        return
    end
    Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
        if Fly then
            RootPart.CFrame = CFrame.new(RootPart.CFrame.Position, RootPart.CFrame.Position + Camera.CFrame.LookVector)
        end
    end)
    if Fly then
        if Keys.W then
            FlyPart.CFrame = RootPart.CFrame + (Camera.CFrame.LookVector * (Delta * FlySpeed))
        elseif Keys.A then
            FlyPart.CFrame = RootPart.CFrame + (-Camera.CFrame.RightVector * (Delta * FlySpeed))
        elseif Keys.S then
            FlyPart.CFrame = RootPart.CFrame + (-Camera.CFrame.LookVector * (Delta * FlySpeed))
        elseif Keys.D then
            FlyPart.CFrame = RootPart.CFrame + (Camera.CFrame.RightVector * (Delta * FlySpeed))
        end
    end
end