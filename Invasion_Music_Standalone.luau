-- INVASION MUSIC - STANDALONE (no GUI)
-- Use only audio you have permission to download/play.

local MUSIC_URL = "https://soundcloud.com/user-307242970/kodak-black-transportin-chopped-screwed-phixion" -- SoundCloud track or direct HTTPS MP3
local VOLUME = 1 -- 0 to 10
local LOOP = false

local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local G = (getgenv and getgenv()) or _G

if type(G.INVASION_MUSIC_STANDALONE_UNLOAD) == "function" then
    pcall(G.INVASION_MUSIC_STANDALONE_UNLOAD)
end

local http = request or http_request or (syn and syn.request)
assert(type(http) == "function", "Executor needs request()")
assert(type(writefile) == "function", "Executor needs writefile()")
assert(type(getcustomasset) == "function", "Executor needs getcustomasset()")

local sound = Instance.new("Sound")
sound.Name = "InvasionMusicStandalone"
sound.Volume = math.clamp(VOLUME, 0, 10)
sound.Looped = LOOP
sound.Parent = SoundService

local active = true
G.INVASION_MUSIC_STANDALONE_UNLOAD = function()
    active = false
    sound:Stop()
    sound:Destroy()
end

local function fetch(options)
    local ok, response = pcall(http, options)
    if not ok then error("Request failed: " .. tostring(response)) end
    if type(response) ~= "table" then error("Empty HTTP response") end
    local status = tonumber(response.StatusCode or response.Status) or 0
    if status < 200 or status >= 300 then
        error("HTTP " .. status .. ": " .. tostring(response.Body or ""):sub(1, 200))
    end
    return response
end

local function isSoundCloud(url)
    local host = url:match("^https://([^/%?#]+)")
    return host == "soundcloud.com" or host == "www.soundcloud.com"
        or host == "m.soundcloud.com" or host == "on.soundcloud.com"
end

local function resolveAudioURL(url)
    if not isSoundCloud(url) then return url end
    print("[INVASION MUSIC] Resolving SoundCloud track...")
    local response = fetch({
        Url = "https://api.samplecut.app/v1/downloads",
        Method = "POST",
        Timeout = 120,
        Headers = {
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/json",
            ["X-Client-Name"] = "InvasionMusic-Luau",
        },
        Body = HttpService:JSONEncode({url = url, format = "mp3", response = "url"}),
    })
    local ok, data = pcall(function()
        return HttpService:JSONDecode(response.Body or "")
    end)
    if not ok or type(data) ~= "table" or type(data.download_url) ~= "string" then
        error("Samplecut did not return a valid download_url")
    end
    return data.download_url
end

local function validateMP3(bytes, headers)
    if type(bytes) ~= "string" or #bytes < 2048 then
        error("Downloaded audio is empty or too small")
    end
    if bytes:sub(1, 3) == "ID3" then return end
    local first, second = bytes:byte(1, 2)
    if first == 255 and second and second >= 224 then return end
    local contentType = tostring((headers or {})["Content-Type"] or (headers or {})["content-type"] or ""):lower()
    if not contentType:find("audio/", 1, true) then
        error("Response does not look like MP3 audio")
    end
end

task.spawn(function()
    local ok, err = pcall(function()
        local url = MUSIC_URL:match("^%s*(.-)%s*$")
        assert(url:match("^https://"), "Set MUSIC_URL to a valid HTTPS link")
        local downloadURL = resolveAudioURL(url)
        if not active then return end
        assert(downloadURL:match("^https://"), "Invalid download URL")

        print("[INVASION MUSIC] Downloading MP3...")
        local response = fetch({
            Url = downloadURL,
            Method = "GET",
            Timeout = 120,
            Headers = { ["Accept"] = "audio/mpeg,application/octet-stream;q=0.9,*/*;q=0.5" },
        })
        validateMP3(response.Body, response.Headers)
        if not active then return end

        local path = "invasion_standalone_" .. tostring(os.time()) .. ".mp3"
        writefile(path, response.Body)
        print("[INVASION MUSIC] Saved " .. math.floor(#response.Body / 1024) .. " KB: " .. path)

        local asset = getcustomasset(path)
        assert(type(asset) == "string" and asset ~= "", "getcustomasset failed")
        if not active then return end
        sound.SoundId = asset
        sound:Play()

        for _ = 1, 120 do
            if not active then return end
            if sound.IsLoaded and sound.TimeLength > 0 then
                if not sound.IsPlaying then sound:Play() end
                print("[INVASION MUSIC] Playing! Length: " .. math.floor(sound.TimeLength) .. "s")
                return
            end
            task.wait(0.25)
        end
        sound:Stop()
        error("MP3 saved, but Roblox could not load it")
    end)
    if not ok and active then
        warn("[INVASION MUSIC] " .. tostring(err))
    end
end)
