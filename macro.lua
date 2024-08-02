game.StarterGui:SetCore("SendNotification",  {
 Title = "made by removedxd";
 Text = "u can change keybind on script tab in ur executor";
 Icon = "http://www.roblox.com/asset/?id=951528747";
 Duration = 98083905839058095809389034;
 Button1 = "esex?";
 Button2 = "i love u daddy";
 Button3 = "fuck me";
 Callback = NotificationBindable;
}
)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
}
)
local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            local SpeedGlitch = false
            Mouse.KeyDown:Connect(function(Key)
                if Key == "x" then    ---- u can keybind here :) (rejoin required)
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
