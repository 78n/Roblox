def GetRobloxVersion(PlayerType : str = "WindowsPlayer") -> str:
    from requests import get
    VersionRequest = get("https://clientsettings.roblox.com/v2/client-version/" + PlayerType)

    if VersionRequest.status_code == 200:
        from json import loads as Decode
        return Decode(VersionRequest.text)["clientVersionUpload"]
    print(VersionRequest.url, "|", VersionRequest.status_code, "| Failed to retrieve current Roblox version |", VersionRequest.text)

RobloxPlayerBetaLocation = None
RobloxVersionCache = None

def _StartGame(AuthTicket : str, PlaceId : int, JobId : str = False) -> bool:
    RobloxVersion = GetRobloxVersion()

    if RobloxVersion:
        from os import getenv
        from os.path import exists
        global RobloxPlayerBetaLocation
        global RobloxVersionCache
        RobloxPlayerBeta = RobloxVersion == RobloxVersionCache and RobloxPlayerBetaLocation
        RobloxVersionCache = RobloxVersion

        if not RobloxPlayerBeta:
            from os import getenv
            RobloxPlayerBeta = f"{getenv("localappdata")}/Roblox/Versions/{RobloxVersion}/RobloxPlayerBeta.exe"
            RobloxPlayerBetaLocation = RobloxPlayerBeta

        if exists(RobloxPlayerBeta):
            from time import time
            from os import startfile

            startfile(RobloxPlayerBeta, arguments=f"--app -t {AuthTicket} --launchtime {int(time() * 1000)} -j https://assetgame.roblox.com/game/PlaceLauncher.ashx?{JobId and "&gameId=" + JobId or ""}{PlaceId and f"&placeId=" + str(PlaceId) or ""}")
            return True
        else:
            print(RobloxPlayerBeta, "does not exist, Please install Roblox")
    print("Failed to start RobloxPlayerBeta.exe")
    return False

class CookieUtilities:
    def StartGame(self, Cookie : str, PlaceId : int, JobId : str) -> bool:
        Auth = self.Authentificate(Cookie)
        return Auth.StartGame(Auth.getAuthTicket(), PlaceId, JobId)

    class Authentificate:
        from requests import Response

        def StartGame(self, PlaceId : int, JobId : str) -> bool:
            return _StartGame(self.getAuthTicket(), PlaceId, JobId)

        def __init__(self, Cookie : str):
            self.Cookie = Cookie
        
        def __getfromheaders(self, Request : Response, status_code : int, header : str) -> tuple[bool, any]:
            if Request.status_code == status_code:
                return True, Request.headers.get(header)
            return False, Request

        def getxcsrf_token(self) -> str:
            from requests import post
            Success, Token = self.__getfromheaders(post("https://auth.roblox.com/v1/authentication-ticket", headers = {"Cookie" : ".ROBLOSECURITY=" + self.Cookie}), 403, "x-csrf-token")
            
            if Success:
                return Token
            print(Token.url, "|", Token.status_code, "| Failed to retrieve xcsrf token |", Token.text)

        def getAuthTicket(self) -> str:
            xcsrf_token = self.getxcsrf_token()
            if xcsrf_token:
                from requests import post

                Success, Auth = self.__getfromheaders(post("https://auth.roblox.com/v1/authentication-ticket", headers = {"Cookie" : ".ROBLOSECURITY=" + self.Cookie, "Referer" : "https://www.roblox.com/", "X-CSRF-TOKEN" : xcsrf_token}), 200, "rbx-authentication-ticket")
                if Success:
                    return Auth
                print(Auth.url, "|" ,Auth.status_code, "| Failed to retrieve Authentification ticket |", Auth.text)
            else:
                print("getAuthTicket | Failed to retrieve Authentification ticket due to missing xcsrf_token")

        def __getattr__(self, name):
            if name == "CookieInfo":
                CookieInfo = self.Info(self.Cookie)
                self.CookieInfo = CookieInfo
                return CookieInfo
            print("CookieUtilities.Authentificate | Invalid method |", name)
    
        class Info:
            from requests import Response

            type PlayerData = dict["userPresenceType" : int, "lastLocation" : str, "placeId" : int | None, "rootPlaceId" : int | None, "gameId": str | None, "universeId" : int | None, "userId" : int, "lastOnline":  str, "userPresenceType" : int, "lastLocation" : str, "placeId" : int | None, "rootPlaceId" : int | None, "gameId": int | None, "universeId" : str | None, "userId" : int, "lastOnline":  str]
            UserId : int
            Name : str
            DisplayName : str
            Cookie : str

            def __decodeResponse(self, Request : Response, status_code : int) -> tuple[bool, any]:
                if Request.status_code == status_code:
                    from json import loads as Decode

                    return True, Decode(Request.text)
                return False, Request
            
            def __init__(self, Cookie : str):
                from requests import get

                self.Cookie = Cookie
                Success,CookieInfo = self.__decodeResponse(get("https://users.roblox.com/v1/users/authenticated", cookies = {".ROBLOSECURITY" : Cookie}), 200)

                if Success:
                    self.UserId,self.Name,self.DisplayName = CookieInfo["id"],CookieInfo["name"],CookieInfo["displayName"]
                else:
                    print(CookieInfo.url, "|", CookieInfo.status_code, "| Failed to fetch Cookie infomation:", CookieInfo.text)

            def __getattr__(self, name):
                print("CookieUtilities.Authentificate.CookieInfo |", name, "is: None")
            
            def GetPlayerData(self) -> PlayerData | None:
                from requests import post
                Success,Data = self.__decodeResponse(post("https://presence.roblox.com/v1/presence/users", f"{{'userIds': [{self.UserId}]}}", headers = {"content-type" : "application/json"}, cookies = {".ROBLOSECURITY" : self.Cookie}), 200)

                if Success:
                    return Data["userPresences"][0] 
                print(Data.url, "|", Data.status_code, f"| Failed to fetch infomation from {self.UserId} |", Data.text)
        
        CookieInfo : Info
        Cookie : str
