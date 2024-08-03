local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/PiterNaGitHub/PiterNaGitHub/main/text.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "anti lock success executed report any bugs to my discord server: https://discord.gg/zcWzFTrP6R";
Title = "made by piter";
Duration = 15;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
local Toggled = true
local KeyCode = Enum.KeyCode.Z
local hip = 2.80
local val = -35

local function adjustVelocity()
    local player = game.Players.LocalPlayer
    local rootPart = player.Character.HumanoidRootPart
    local oldVelocity = rootPart.Velocity
    rootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
    player.Character.Humanoid.HipHeight = hip
end

local function onInputBegan(input)
    if input.KeyCode == KeyCode and not game:GetService('UserInputService'):GetFocusedTextBox() then
        Toggled = not Toggled
        if Toggled then
            while Toggled do
                adjustVelocity()
                task.wait()
            end
        else
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
        end
    end
end

game:GetService('UserInputService').InputBegan:Connect(onInputBegan)
