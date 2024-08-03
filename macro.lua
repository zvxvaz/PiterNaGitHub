local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/PiterNaGitHub/PiterNaGitHub/main/text.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "macro script has been executed success press x to macro join up our discord server: https://discord.gg/k93hppJwEm";
Title = "made by piter";
Duration = 20;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            local SpeedGlitch = false
            Mouse.KeyDown:Connect(function(Key)
                if Key == "x" then
                    SpeedGlitch = not SpeedGlitch
                    if SpeedGlitch == true then
                        repeat game:GetService("RunService").Heartbeat:wait()
                               game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", true, game)
                                    game:GetService("RunService").Heartbeat:wait()
                                    game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", false, game)
                                    game:GetService("RunService").Heartbeat:wait()
                        until SpeedGlitch == false
                    end
                end
            end)
