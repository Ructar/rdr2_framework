local WorldText = {
	-- FontSize = 14,
	-- MinScale = 0.2,
	Padding = 0.01,
	Colors = {
		[1] = { r = 10, g = 20, b = 60, a = 255 },
		[2] = { r = 10, g = 20, b = 60, a = 64 },
	}
}

exports("DrawContext", function(text, coords, id)
	if coords then
		exports.utils:Draw3DText(coords, ("[%s] - %s"):format(GetControlInstructionalButton(2, 51, 1):sub(3), text), 4, 0.4, id)
	else
		BeginTextCommandDisplayHelp("STRING")
		AddTextComponentString(("Press ~INPUT_CONTEXT~ to %s!"):format(text))
		EndTextCommandDisplayHelp(0, false, true, -1)
	end

	return IsControlJustPressed(1, 51)
end)

exports("Draw3DText", function(coords, textInput, fontId, scale, id, lines, offset)
	local color = WorldText.Colors[id or 1]

	-- Scaling, but looks bad
	-- local p = GetFinalRenderedCamCoord()
	-- local dist = #(p - coords)
	-- local fov = (1 / GetGameplayCamFov()) * 100
	-- scale = math.max(scale * (1 / dist) * WorldText.FontSize * fov, WorldText.MinScale)
	-- scale = scale-- * (1.0 / dist)

	if not offset then
		offset = vector2(0.0, 0.0)
	end

	SetTextColour(255, 255, 255, color.a)
	SetTextScale(scale, scale)
	SetTextFont(fontId)
	SetTextCentre(true)

	SetDrawOrigin(coords.x, coords.y, coords.z, 0)
	SetScriptGfxAlignParams(offset.x, offset.y, 1.0, 1.0)

	BeginTextCommandWidth("STRING")
	AddTextComponentString(textInput)
	
	if not lines then lines = 1 end

	local height = GetTextScaleHeight(scale, fontId) * lines
	local width = EndTextCommandGetWidth(4)
	local padding = WorldText.Padding * scale
	
	SetTextEntry("STRING")
	AddTextComponentString(textInput)
	EndTextCommandDisplayText(0.0, 0.0)
	DrawRect(0.0, height * 0.6, width + padding, height + padding, color.r, color.g, color.b, 64)

	ClearDrawOrigin()
	ResetScriptGfxAlign()
end)

exports("KeyboardInput", function(input, example, maxStringLength)
	AddTextEntry("FMMC_KEY_TIP1", input)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", example, "", "", "", maxStringLength)

	while UpdateOnscreenKeyboard() == 0 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(200)
		return result
	else
		Citizen.Wait(200)
		return nil
	end
end)

exports("GetSafeZoneBounds", function()
	local size = (1.0 - GetSafeZoneSize()) / 0.1
	local width, height = GetActiveScreenResolution()

	return { width * size * 0.05, height * size * 0.05 }
end)

exports("DrawPrompt", function(text, key)
    local string = CreateVarString(10, "LITERAL_STRING", text)
    prompt = CreatePrompt(key, string, 6, 1, 1, -1)
    PromptSetEnabled(prompt, false)
    PromptSetVisible(prompt, false)
end