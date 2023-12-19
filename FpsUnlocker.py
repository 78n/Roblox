# Make sure to have Python installed and the requests module installed
# if you dont have the request module installed run this in command prompt:
# python -m install requests

def finish():
    from time import sleep
    sleep(5)
    exit()

try:
    from requests import get as HttpGet
except:
    print("Failed to import requests module\nPlease install the \"requests\" module:\n\n---\n\npython -m install requests")
    finish()

print("Fetching Roblox WindowPlayer version: https://clientsettings.roblox.com/v2/client-version/WindowsPlayer")
VersionRequest = HttpGet("https://clientsettings.roblox.com/v2/client-version/WindowsPlayer")

if VersionRequest:
    import os
    from os.path import exists as isfile
    from json import loads
    from getpass import getuser

    RobloxVersion = loads(VersionRequest.text)["clientVersionUpload"]
    FileLocation = f"C:/Users/{getuser()}/AppData/Local/Roblox/Versions/{RobloxVersion}"
    
    if isfile(FileLocation):
        print("Roblox WindowPlayer version:", RobloxVersion)
        FileLocation += "/ClientSettings"

        if not isfile(FileLocation):
            os.makedirs(FileLocation)
            print("Created ClientSettings folder", FileLocation)

        FileLocation += "/ClientAppSettings.json"
        Fps = input("Please input your desired fps: ")
        open(FileLocation, "w").write("{\"DFIntTaskSchedulerTargetFps\": " + Fps + "}")
        print("Created ClientAppSettings:", FileLocation)
    else:
        print(f"You do not have the current Roblox WindowPlayer version installed {RobloxVersion}")
else:
    print("Failed to fetch the current WindowPlayer Roblox version")

finish()
