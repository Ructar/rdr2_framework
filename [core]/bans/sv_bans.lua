-- RegisterServerEvent("core:kick")
-- AddEventHandler("core:kick", function(target, reason, kicker)
-- 	local source = source
-- 	local name = GetPlayerName(source) or kicker
-- 	if source == target and kicker ~= nil then name = kicker end

-- 	local anticheat = false

-- 	if source ~= nil then
-- 		if UGroup[source] then
-- 			local group = UGroup[source]
-- 			if group ~= "admin" and group ~= "staff" and group ~= "owner" then
-- 				anticheat = true
-- 				return
-- 			end
-- 		end
-- 	end

-- 	if not anticheat then
-- 		if GetPlayerName(tonumber(target)) == nil then
-- 			if source ~= nil then
-- 				TriggerClientEvent("pNotify:SendNotification", source, {text = "The player you tried to kick has already left the server", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
-- 			else
-- 				RconPrint("The player you tried to kick has already left the server")
-- 			end
-- 			--The player you tried to kick has already left the server
-- 		else
-- 			local target_steam = getID("steam", target)
-- 			local target_license = getID("license", target)
-- 			local target_name = GetPlayerName(target)
-- 			DropPlayer(target, name.." kicked you from the server, Reason: "..reason.." - rivalryrp.com")
-- 			kickMessage(target_name, target_steam, target_license, reason, name)
-- 		end
-- 	else
-- 		TriggerEvent("core:anticheat-ban", source)
-- 	end
-- end)