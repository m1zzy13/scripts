JunkieCore = nil
JD = nil
JunkieProtected = nil
local url = "https://api.junkie-development.de/api/v1/luascripts/public/3987248819611851230c409b3b8839ff24f455ef7f4337d2e5a1287ad38b29f0/download"

local code = game:HttpGet(url, true)
if code then
    loadstring(code)()
else
    local code2 = game:HttpGetAsync(url, true)
    if code2 then
        loadstring(code2)()
    else
        print("Failed to load script, maybe executor problem.")
    end
end
