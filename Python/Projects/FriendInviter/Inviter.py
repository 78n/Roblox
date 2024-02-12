#Instructions:
    #1. Log onto the target account
    #2. Join a game on the UWP Client (Microsoft Roblox)
    #3. Run this
    #4. Profit

CookieStorageName = "Cookies.txt" # string (Make sure to specify the file type ex: .txt, .json, ect)
YieldTime = 30 # Seconds
FancyCountdown = True # Just for debugging

# Sorry for the messy code this is my first semi-big Python project
# Everything below this is a mess

from lib.main import CookieUtilities
from requests import post
from os import system
from os.path import dirname

def readfile(filename : str) -> str:
    return open(f"{dirname(__file__)}/{filename}", "r").read()

TargetAuth = CookieUtilities.Authentificate(readfile("TargetCookie.txt"))
TargetInfo = TargetAuth.CookieInfo

if TargetInfo.UserId:
    Cookies = readfile(CookieStorageName).split("\n")
    AmountOfCookies = len(Cookies)

    if AmountOfCookies > 0:
        TargetGameInfo = TargetInfo.GetPlayerData()

        if TargetGameInfo:
            JobId,PlaceId,userPresenceType = TargetGameInfo["gameId"], TargetGameInfo["placeId"], TargetGameInfo["userPresenceType"]

            if userPresenceType == 2:
                def Friend(UserId : int, Auth : CookieUtilities.Authentificate) -> bool:
                    FriendStatus = post(f"https://friends.roblox.com/v1/users/{UserId}/request-friendship", headers = {"content-type" : "application/json", "x-csrf-token" : Auth.getxcsrf_token()}, cookies = {".ROBLOSECURITY" : Auth.Cookie}).status_code

                    return FriendStatus == 200 or FriendStatus == 400 # Basically to account for if you're already friends

                def UnFriendTarget(CookieAuth : CookieUtilities.Authentificate) -> bool:
                    return post(f"https://friends.roblox.com/v1/users/{TargetInfo.UserId}/unfriend", headers = {"content-type" : "application/json", "x-csrf-token" : CookieAuth.getxcsrf_token()}, cookies = {".ROBLOSECURITY" : CookieAuth.Cookie}).status_code == 200
                        

                for v in Cookies:
                    if v != TargetAuth.Cookie:
                        CookieAuth = CookieUtilities.Authentificate(v)
                        CookieInfo = CookieAuth.CookieInfo

                        if CookieInfo.UserId:
                            print(CookieInfo.Name, "friending", TargetInfo.Name)
                            if Friend(TargetInfo.UserId, CookieAuth):
                                print(TargetInfo.Name, "accepting", CookieInfo.Name + "'s friend request")
                                if Friend(CookieInfo.UserId, TargetAuth):
                                    print("Joining game | PlaceId:", PlaceId, "| JobId:", JobId)
                                    if not CookieAuth.StartGame(PlaceId, JobId):
                                        print("Failed to start game, ending loop")
                                        break
                                    from time import sleep
                                    if FancyCountdown:
                                        for i in range(YieldTime, 0, -1):
                                            print("Yielding", i, i != 1 and "seconds" or "second")
                                            sleep(1)
                                            system("cls")
                                    else:
                                        print("Yielding for", YieldTime, "seconds")
                                        sleep(YieldTime)
                                    print(CookieInfo.Name, "unfriending", TargetInfo.Name)
                                    if not UnFriendTarget(CookieAuth):
                                        print(CookieInfo.Name, "failed to unfriend", TargetInfo.Name)
                                else:
                                    print(CookieInfo.Name, "failed to friend", TargetInfo.Name, v)
                            else:
                                print("Cookie", Cookies.index(v), "failed to friend", TargetInfo.Name)
                        else:
                            print("Cookie", Cookies.index(v), "is not valid:", v)
                system("cls")
                print("Finished going through:", AmountOfCookies, "cookies")
            elif userPresenceType == 1:
                print(TargetInfo.Name, "is not in a game")
            else:
                print(TargetInfo.Name, "is not online")
    else:
        print("Amount of cookies is below 0")
else:
    print("Target cookie is not valid")
