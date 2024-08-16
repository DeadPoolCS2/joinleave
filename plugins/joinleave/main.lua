AddEventHandler("OnClientDisconnect", function(event, playerid)
	local player = GetPlayer(playerid)
    if not player then return EventResult.Continue end
    if player:IsFakeClient() then return EventResult.Continue end
    if not player:CBasePlayerController():IsValid() then return end    
    local name = player:CBasePlayerController().PlayerName
    local ip = player:GetIPAddress()
        
    PerformHTTPRequest("http://ip-api.com/json/"..ip, function(status, body, headers, err)
       	local requestData = json.decode(body)
		if not requestData then return end
		if config:Fetch("joinleave.log") then logger:Write(LogType_t.Common, FetchTranslation("joinleave.leave.log"):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country)) end
		if config:Fetch("joinleave.console") then 
			local res, _ = FetchTranslation("joinleave.leave.console"):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country)
			print(res)
		end
		playermanager:SendMsg(MessageType.Chat, FetchTranslation("joinleave.leave.game"):gsub("{PREFIX}", config:Fetch("joinleave.prefix")):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country))
    end)
        
	return EventResult.Continue
end)

AddEventHandler("OnPlayerConnectFull", function(event)
    local playerid = event:GetInt("userid")
	local player = GetPlayer(playerid)
    if not player then return EventResult.Continue end
    if player:IsFakeClient() then return EventResult.Continue end
    if not player:CBasePlayerController():IsValid() then return end    
    local name = player:CBasePlayerController().PlayerName
    local ip = player:GetIPAddress()
        
    PerformHTTPRequest("http://ip-api.com/json/"..ip, function(status, body, headers, err)
       	local requestData = json.decode(body)
		if not requestData then return end
		if config:Fetch("joinleave.log") then logger:Write(LogType_t.Common, FetchTranslation("joinleave.join.log"):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country)) end
		if config:Fetch("joinleave.console") then 
			local res, _  = FetchTranslation("joinleave.join.console"):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country)
			print(res)
        end
		playermanager:SendMsg(MessageType.Chat, FetchTranslation("joinleave.join.game"):gsub("{PREFIX}", config:Fetch("joinleave.prefix")):gsub("{NAME}", name):gsub("{IP}", ip):gsub("{CITY}", requestData.city):gsub("{COUNTRY}", requestData.country))
    end)
        
	return EventResult.Continue
end)

function GetPluginAuthor()
    return "Swiftly Solutions"
end

function GetPluginVersion()
    return "1.0.0"
end

function GetPluginName()
    return "Join Leave Messages"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/joinleave"
end
