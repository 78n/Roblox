from os import getenv, makedirs
from os.path import exists

from re import search
from requests import Session, session, Response

type function = callable[... : any]

def _Getsession(self, CopySession : object = False) -> Session:
	if not hasattr(self, "_session"):
		CopySession = CopySession and getattr(CopySession, "_session", False)
		self._session = CopySession or session()

		if not CopySession:
			self._session.headers["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:124.0) Gecko/20100101 Firefox/124.0"
	
	return self._session

def _GetStorage(StorageName : str) -> str:
	StorageLocation = getenv("LocalAppData") + "/AmityDev"

	makedirs(StorageLocation, exist_ok=True)
	StorageLocation += "/" + StorageName
	makedirs(StorageLocation, exist_ok=True)

	return StorageLocation
	

class Email:
	type EmailList = "TenMinuteMail"

	class TenMinuteMail:
		# Warning If you overuse this email provider you might get ratelimited/ip banned for 24 hours

		type Mail = list[dict["read" : bool, "expanded" : bool, "repliedTo" : bool, "sendDate" : str, "sentDateFormatted" : str, "sender" : str, "from" : None, "subject" : str, "bodyPlainText" : str, "bodyHtmlContent" : str, "contentType" : str, "bodyPreview" : str, "id" : str, "recipient" : str, "attachments" : []]]

		_session : Session
		_Email : str
		
		def GetEmail(self) -> str | None:
			if not hasattr(self, "_Email"):
				Request : Response
				print("Retrieving Email from 10minutemail")

				with _Getsession(self).get("https://10minutemail.com/session/address") as Request:
					if Request.status_code == 200:
						self._Email = Request.json()["address"]
					else:
						print("Failed to retrieve email:", Request.text, Request.status_code)
			return self._Email
		
		def GetMail(self) -> Mail | None:
			if self.GetEmail():
				Request : Response
				print(f"Retrieving mail for {self._Email} from 10minutemail")
				with self._session.get("https://10minutemail.com/messages/messagesAfter/0") as Request:
					if Request.status_code == 200:
						try:
							return Request.json()
						except Exception as error:
							print("An error occured when retrieving the mail:", error, Request.text, Request.status_code)
					else:
						print("Failed to retrieve emails for", self._Email, Request.text, Request.status_code)

class Botting:
	class nolt:
		class Storage:
			_AccountData : str

			def __init__(self):	
				self._AccountData = _GetStorage("nolt") + "/AccountData.json"

			def CreateStorageFile(self) -> str:
				if not exists(self._AccountData):
					open(self._AccountData, "x")

				return self._AccountData
			
			def Append(self, Token : str) -> None:
				with open(self._AccountData, "a") as TokenStorage:
					TokenStorage.write(Token + "\n")
			
			def GetTokens(self) -> list[str]:
				with open(self._AccountData, "r") as TokenStorage:
					Accounts = TokenStorage.read().split("\n")
					Accounts.pop(-1)
					return Accounts
			
			def GetAmountOfTokens(self) -> int:
				return len(self.GetTokens())

		class Bot:
			#You will get ratelimited if you make too many requests
			type NameData = dict[
				"Success" : bool,
				"Token" : str
			]

			type ActionData = dict[
				"Success" : bool,
				"Token" : str,
				"PostId" : str | None,
				"Post" : str
			]

			_links : dict[[str] : str]
			_session : Session

			def __init__(self, Token):
				self._links = {}
				self._Token = Token
				_Getsession(self).cookies.set(name="_nolt-token", value=Token, domain = "nolt.io", path = "/")

			def _GetBaseLinkFromPost(self, post : str) -> str:
				return search(r"(https:\/\/.+?\.nolt\.io\/)\d+", post).groups()[0]

			def _GetIdFromPost(self, post : str) -> str | None: #Thank you mrcoolertyper
				if not post in self._links:
					with self._session.get(post) as Request:
						if Request.status_code == 200:
							try:
								from bs4 import BeautifulSoup, Tag
								from json import loads, dumps
								bs: BeautifulSoup = BeautifulSoup(Request.text, "html.parser")
								script: Tag = bs.body.find(id = "__NEXT_DATA__")
								content: dict[str, any] = loads(script.text)
								page_props: dict[str, any] = content["props"]["pageProps"]

								board_pid: str = page_props["boardPid"]
								post_pid: str = page_props["ssrModal"]["props"]["postPid"]

								appolo_state: dict[str, any] = page_props["apolloState"]["ROOT_QUERY"]
								query: str = f"postByPid({dumps({
									"boardPid": board_pid,
									"postPid": post_pid
								}, separators = (",", ":"))})"
								self._links[post] = appolo_state[query]["id"]
							except Exception as error:
								print("Failed to get postid for:", post, error)
					
				return self._links.get(post)

			def GetToken(self) -> str:
				return self._Token

			def ChangeName(self, Name : str) -> NameData:
				with _Getsession(self).post("https://nolt.io/graphql", json=[{"operationName":"updateLoggedInUser","variables":{"name":Name},"query":"mutation updateLoggedInUser($name: String!) {\n  updateLoggedInUser(name: $name) {\n    id\n    name\n    __typename\n  }\n}\n"}]) as Request:
					return {
						"Success" : Request.status_code == 200,
						"Request" : Request
					}
				
			def Comment(self, post : str, Comment : str) -> ActionData:
				baselink = self._GetBaseLinkFromPost(post)
				postid = baselink and self._GetIdFromPost(post)

				if postid:
					with self._session.post(baselink+"graphql", json=[{"operationName":"createComment","variables":{"boardPid":"roblox-bedwars","postId":postid,"text":Comment,"files":[],"notifyOP":True,"notifyCommenters":True,"notifyUpVoters":False,"notifyDownVoters":None,"notifySubscribers":True},"query":"mutation createComment($boardPid: String!, $postId: String!, $text: String!, $files: [String]!, $notifyOP: Boolean!, $notifyCommenters: Boolean!, $notifyUpVoters: Boolean!, $notifyDownVoters: Boolean, $notifySubscribers: Boolean!) {\n  createComment(postId: $postId, text: $text, files: $files, notifyOP: $notifyOP, notifyCommenters: $notifyCommenters, notifyUpVoters: $notifyUpVoters, notifyDownVoters: $notifyDownVoters, notifySubscribers: $notifySubscribers) {\n    node {\n      ...CommentFragment\n      post {\n        id\n        isSubscribed\n        __typename\n      }\n      __typename\n    }\n    ban {\n      id\n      __typename\n    }\n    token\n    __typename\n  }\n}\n\nfragment CommentFragment on Comment {\n  id\n  dateCreated\n  isLiked\n  likeCount\n  moderationStatus\n  notifyOP\n  notifyCommenters\n  notifyUpVoters\n  notifyDownVoters\n  notifySubscribers\n  text\n  type\n  files {\n    id\n    bytes\n    name\n    url\n    __typename\n  }\n  moderator {\n    id\n    name\n    color\n    image {\n      id\n      url\n      __typename\n    }\n    __typename\n  }\n  user {\n    id\n    name\n    color\n    image {\n      id\n      url\n      __typename\n    }\n    isAnonymous\n    boardInfo(boardPid: $boardPid) {\n      publicRole\n      __typename\n    }\n    __typename\n  }\n  __typename\n}\n"}]) as Request:
						return {
							"Success" : Request.status_code == 200,
							"PostId" : postid,
							"Request" : Request
						}
				return {
					"Success" : False,
					"Error" : "Failed to retrieve PostId"
				}

			def Upvote(self, post : str) -> ActionData:
				baselink = self._GetBaseLinkFromPost(post)
				postid = baselink and self._GetIdFromPost(post)
				if postid:
					with self._session.post(baselink + "graphql", json = [{"operationName":"votePost","variables":{"postId":postid,"type":"UP"},"query":"mutation votePost($postId: String!, $type: VoteType!) {\n  votePost(postId: $postId, type: $type) {\n    ban {\n      id\n      __typename\n    }\n    node {\n      id\n      upvoteCount\n      downvoteCount\n      isUpvoted\n      isDownvoted\n      isSubscribed\n      __typename\n    }\n    token\n    __typename\n  }\n}\n"}]) as Request:
						return {
							"Success" : Request.status_code == 200,
							"PostId" : postid,
							"Request" : Request
						}
				return {
					"Success" : False,
					"Error" : "Failed to retrieve PostId"
				}
		
		class Account:
			def VerifyToken(Token : str, session : Session = session()) -> bool | None:
				with session.get("https://nolt.io/auth/verify?token=" + Token):
					return session.cookies.get("_nolt-token")

			def GenerateAccount(self, EmailType : str = "TenMinuteMail") -> str | None:
				EmailMethod = getattr(Email, EmailType, Email.TenMinuteMail)()
				
				AccountEmail = EmailMethod.GetEmail()

				if AccountEmail:
					TempSession = EmailMethod._session

					with TempSession.post("https://nolt.io/graphql", json = [{"operationName" : "requestPasswordlessLogin", "variables" : {"email" : AccountEmail,"locale":"en-US"}, "query" : "mutation requestPasswordlessLogin($email: String!, $locale: String) {\n  requestPasswordlessLogin(email: $email, locale: $locale)\n}\n"}]) as Request:
						if Request.status_code == 200:
							from time import sleep
							sleep(5)
							Maillist = EmailMethod.GetMail()
							EmailToken : str
	
							if Maillist:
								for Mail in Maillist:
									if search("@mail.nolt.io", Mail["sender"]):
										EmailToken = search("\\w+-\\w+", Mail["bodyPlainText"]).group()
										break
									
								if EmailToken:
									Request : Response
									print("Verifying token", EmailToken)
									with TempSession.post("https://nolt.io/graphql", json = [{"operationName" : "verifyLoginCode", "variables" : {"code" : EmailToken, "returnUrl" : "https://nolt.io/account"}, "query" : "mutation verifyLoginCode($code: String!, $returnUrl: String) {\n  verifyLoginCode(code: $code, returnUrl: $returnUrl) {\n    url\n    __typename\n  }\n}\n"}]) as Request:
										if Request.status_code == 200:
											verify = Request.json()[0]["data"]["verifyLoginCode"]["url"]
											print("Initiating account", AccountEmail)
											VerifyToken = search("token=(.+)", verify).groups()[0]
											Token = Botting.nolt.Account.VerifyToken(VerifyToken, TempSession)
											if Token:
												if not hasattr(self, "_Storage"):
													self._Storage = Botting.nolt.Storage()
												self._Storage.Append(Token)
												print("Successfully initiated account:", Token)
												return Token
											
											print("No Token was returned")
											return None
										else:
											print(f"Failed to get Account (Token) for {AccountEmail}", Request.text, Request.status_code)
								else:
									print(f"Failed to retrieve email verification for {AccountEmail}", Maillist)
							else:
								print("No maillist was returned")
						else:
							print("Failed to sign-up:", Request.text, Request.status_code)

			def BulkGenerateAccounts(self, Amount : int = 1, EmailType : str = "TenMinuteMail") -> list[str]:
				AccountList = []

				for i in range(Amount):
					AccountToken = self.GenerateAccount(EmailType)
					if AccountToken:
						AccountList.append(AccountToken)
				
				return AccountList

if __name__ == "__main__":
	Post = ""
	AmountOfAccountsToGenerate = 4
	AccountName = ""
	CommentMessage = ""

	ChangeName = True
	LeaveComment = True
	GenerateAccounts = False
	Upvote = True

	Accounts = GenerateAccounts and Botting.nolt.Account().BulkGenerateAccounts(AmountOfAccountsToGenerate) or []
	Accounts.extend(Botting.nolt.Storage().GetTokens())
	for Token in Accounts:
		if Token:
			Account = Botting.nolt.Bot(Token)

			if ChangeName:
				ChangedName = Account.ChangeName(AccountName)
				print(Token, ChangedName["Success"] and "Successfully changed name to:" or "Failed to switch name to:", AccountName)

			if LeaveComment:
				Comment = Account.Comment(Post, CommentMessage)
				print(Token, Comment["Success"] and "Successfully commented on:" or "Failed to comment on:", Post)
			
			if Upvote:
				Upvote = Account.Upvote(Post)
				print(Token, Upvote["Success"] and "Successfully upvoted:" or "Failed to upvote:", Post)
