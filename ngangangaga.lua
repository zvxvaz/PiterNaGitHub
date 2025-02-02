 -- Configuration
local skyboxAssets = {
    SkyboxBk = "rbxassetid://1876545003", -- Replace with your SkyboxBk asset ID
    SkyboxDn = "rbxassetid://1876544331", -- Replace with your SkyboxDn asset ID
    SkyboxFt = "rbxassetid://1876542941", -- Replace with your SkyboxFt asset ID
    SkyboxLf = "rbxassetid://1876543392", -- Replace with your SkyboxLf asset ID
    SkyboxRt = "rbxassetid://1876543764", -- Replace with your SkyboxRt asset ID
    SkyboxUp = "rbxassetid://1876544642"  -- Replace with your SkyboxUp asset ID
}

-- Function to replace the skybox
local function changeSkybox()
    -- Get the Lighting service
    local lighting = game:GetService("Lighting")

    -- Remove existing skybox
    for _, child in pairs(lighting:GetChildren()) do
        if child:IsA("Sky") then
            child:Destroy()
        end
    end

    -- Create a new Sky instance
    local newSky = Instance.new("Sky")
    newSky.Name = "CustomSkybox"

    -- Apply custom skybox textures
    newSky.SkyboxBk = skyboxAssets.SkyboxBk
    newSky.SkyboxDn = skyboxAssets.SkyboxDn
    newSky.SkyboxFt = skyboxAssets.SkyboxFt
    newSky.SkyboxLf = skyboxAssets.SkyboxLf
    newSky.SkyboxRt = skyboxAssets.SkyboxRt
    newSky.SkyboxUp = skyboxAssets.SkyboxUp

    -- Parent the new skybox to Lighting
    newSky.Parent = lighting

    print("Skybox successfully changed!")
end

-- Execute the function
changeSkybox() 
