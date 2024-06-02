FFlags = {
    'DFIntTaskSchedulerTargetFps' : 999999, # unlocks fps
    'FFlagDebugGraphicsPreferVulkan_enabled' : True, # FPS boost
    'DFFlagDebugEnableInterpolationVisualizer': True, # Enables F8 menu (esp sorta for networks)
    'FStringWhitelistVerifiedUserId' : "", # Fake verified badge (UserId)
    'FFlagDebugSimDefaultPrimalSolver' : True, # Enable the new simulation engine or whatever it is
    'DFIntDebugSimPrimalLineSearch' : 1, # A poor man's gravity/flight [Default 100] (above 0 is low gravity | below 1 to -1 is will make gameplay weird when it comes to physics | below -1 is a poor mans fly (not really useable)
    
    #'DFIntHipHeightClamp' : -20, # clamp hipheight
    #'DFIntMaxAltitudePDHipHeightPercent' : -99999, # Shortflag
    #"DFIntUnstickForceAttackInTenths": -50, # Wall Slide to the right
    #'DFIntMaxAltitudePDStickHipHeightPercent' : -1000, # JumpSploit
    #'FIntRenderShadowIntensity' : -99999,
    #'FFlagDebugDontRenderUI' : True, # No Guis
    #'FFlagDebugSkyGray' : True, #Gray sky

    #'DFIntRunningBaseOrientationP' : 1, # walking looking tween speed [Patched]
    #"DFIntAssemblyExtentsExpansionStudHundredth": -50 # Noclip [Patched]
    #'FIntPGSAngularDampingPermilPersecond' : 2, # Messes with tween speed I think [Patched]
    #'DFIntFreeFallOrientationP' : -20, # Jump spin [Patched]
    #'DFIntNewRunningBaseAltitudeP' : -9999, # Shortflag [Patched]
    #'DFIntGeometricStiffnessAlpha' : -9999, # High jump 2 (less constant) [Patched]
    #"FFlagDebugSimIntegrationStabilityTesting" : True # Speed Hax [Patched]
    #'DFIntDefaultBalanceD' : -9999, # High jump [Patched]
}

try:
    from requests import get as HttpGet
except:
    print("Failed to import requests module (python -m install requests)")
    while True:
        response = input("Would you like to install the request library? (Y/N): ").lower()
        if response == "y":
            from os import system
            print("Installing requests library")
            system("pip install requests")
            print("Rerunning", __file__)
            system("python " + __file__)
            exit()
        elif response == "n":
            print("Terminating process")
            exit()
        else:
            print("Invalid response")
        

print("Fetching Roblox WindowPlayer version: https://clientsettings.roblox.com/v2/client-version/WindowsPlayer")
with HttpGet("https://clientsettings.roblox.com/v2/client-version/WindowsPlayer") as VersionRequest:
    if VersionRequest.status_code == 200:
        import os
        import json
        from os.path import exists as isfile

        RobloxVersion = json.loads(VersionRequest.text)["clientVersionUpload"]
        FileLocation = f"{os.getenv("LocalAppData")}/Roblox/Versions/{RobloxVersion}"
        
        if isfile(FileLocation):
            print("Roblox WindowPlayer version:", RobloxVersion)
            FileLocation += "/ClientSettings"

            if not isfile(FileLocation):
                os.makedirs(FileLocation)
                print("Created ClientSettings folder", FileLocation)

            FileLocation += "/ClientAppSettings.json"
            open(FileLocation, "w").write(json.dumps(FFlags))
            print("Created ClientAppSettings:", FileLocation)
        else:
            print(f"You do not have the current Roblox WindowPlayer version installed {RobloxVersion}")
    else:
        print("Failed to fetch the current WindowPlayer Roblox version")
