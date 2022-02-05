function love.load() -- called on start
	local w, h = love.graphics.getDimensions()
	local f = love.filesystem.load("/initlua.lua")
	f()
	CurTime = 0
	addNotification("Loaded notifications (by lokachop)!", 2)




	love.keyboard.setKeyRepeat(true)

	lsglil2.NewObject("TextEntry1", "textentry")
	lsglil2.SetObjectPosition("TextEntry1", w / 2, 0)
	lsglil2.SetObjectColour("TextEntry1", 0.6, 0.6, 0.8)
	lsglil2.SetObjectData("TextEntry1", "releasecall", function(edata)
		print("text was released, is " .. edata["text"])
	end)


	lsglil2.NewObject("Panel1", "panel")
	lsglil2.SetObjectPosition("Panel1", 0, 0)
	lsglil2.SetObjectData("Panel1", "texture", "loka.png")
	lsglil2.ChangeObjectPriority("Panel1", 0)

	lsglil2.NewObject("Button1", "button")
	lsglil2.SetObjectPosition("Button1", w / 2, h / 2)
	lsglil2.SetObjectData("Button1", "texture", "loka.png")
	lsglil2.SetObjectData("Button1", "onPress", function(GUITime)
		print("hi! time is " .. GUITime)
	end)

	lsglil2.NewObject("Label1", "label")
	lsglil2.SetObjectPosition("Label1", w / 2.4, h / 2.25)
	lsglil2.SetObjectData("Label1", "text", "this button prints shit to console")
	lsglil2.SetObjectScale("Label1", 200, 64)


	for i = 1, 32 do
		lsglil2.NewObject("ButtonNew" .. i, "button")
		lsglil2.SetObjectPosition("ButtonNew" .. i , i * 2, i * 1)
		lsglil2.ChangeObjectPriority("ButtonNew" .. i, i)
		lsglil2.SetObjectScale("ButtonNew" .. i, 64, 32)
		local r, g, b = hsvToRGB(i / 32, 1, 1)
		lsglil2.SetObjectData("ButtonNew" .. i, "col", {r / 2, g / 2, b / 2, 1})
		lsglil2.SetObjectData("ButtonNew" .. i, "colHover", {r / 1.5, g / 1.5, b / 1.5, 1})
		lsglil2.SetObjectData("ButtonNew" .. i, "colClick", {r / 1.25, g / 1.25, b / 1.25, 1})


		lsglil2.SetObjectData("ButtonNew" .. i, "onPress", function(GUITime)
			print("you pressed me, button number " .. i)
			print("ima delete myself now")
			lsglil2.DeleteObject("ButtonNew" .. i)
		end)

		lsglil2.SetObjectData("ButtonNew" .. i, "text", "Button #" .. i)
	end

	lsglil2.NewObject("PanelLoka", "panel")
	lsglil2.SetObjectPosition("PanelLoka", w / 1.25, 64)
	lsglil2.SetObjectScale("PanelLoka", 64, 64)
	lsglil2.SetObjectData("PanelLoka", "texture", "loka.png")
	lsglil2.ChangeObjectPriority("PanelLoka", 100)


	lsglil2.NewObject("ButtonRenderLoka", "button")
	lsglil2.SetObjectPosition("ButtonRenderLoka", w / 1.25, 0)
	lsglil2.SetObjectData("ButtonRenderLoka", "onPress", function(GUITime)
		renderLokaAtCursor = true
	end)
	lsglil2.SetObjectData("ButtonRenderLoka", "text", "Press me!")

	lsglil2.NewObject("Label3", "label")
	lsglil2.SetObjectPosition("Label3", w / 1.325, 128)
	lsglil2.SetObjectData("Label3", "text", "this is loka, if you press the button above him he will follow your mouse he also renders over everything but the text on top left since hes priority 100")
	lsglil2.SetObjectScale("Label3", 128, 64)
	lsglil2.ChangeObjectPriority("Label3", 64)
	lsglil2.SetObjectData("Label3", "col",  {0, 1, 0, 1})


	lsglil2.NewObject("Label2", "label")
	lsglil2.SetObjectPosition("Label2", 0, 0)
	lsglil2.SetObjectData("Label2", "text", "lsglil2 is EPIC btw this text has word wrap so i am going to make it really long also this text is priority 1000 so its gonna basically render over everything else")
	lsglil2.SetObjectScale("Label2", 200, 64)
	lsglil2.ChangeObjectPriority("Label2", 1000)
	lsglil2.SetObjectData("Label2", "col",  {1, 0, 0, 1})

	lsglil2.NewObject("Label4", "label")
	lsglil2.SetObjectPosition("Label4", 0, 80)
	lsglil2.SetObjectData("Label4", "text", "btw make sure buttons dont overlap otherwise when you press them both will be called which is caused by my shit and dumb code")
	lsglil2.SetObjectScale("Label4", 200, 64)
	lsglil2.ChangeObjectPriority("Label4", 64)
	lsglil2.SetObjectData("Label4", "col",  {0, 0, 1, 1})

	for i = 1, 3 do
		lsglil2.NewObject("PanelTransparency" .. i, "panel")
		lsglil2.SetObjectPosition("PanelTransparency" .. i, 64, h / 2)
		local r, g, b = hsvToRGB(i / 3, 1, 1)
		lsglil2.SetObjectData("PanelTransparency" .. i, "col",  {r, g, b, 0.2})
	end
end

function love.update(dt) -- dt is deltatime
	local w, h = love.graphics.getDimensions()
	CurTime = CurTime + dt

	notificationThink()
	lsglil2.Update(dt)
	lsglil2.SetObjectScale("Panel1", 180 + (math.sin(CurTime * 1) * 128), 128 + (math.sin(CurTime * 1) * 64))
	lsglil2.SetObjectPosition("Panel1", math.abs(math.sin(CurTime * 1.63246) * (w * 0.65)), math.abs(math.cos(CurTime * 0.437) * (h * 0.5)))

	lsglil2.SetObjectData("Panel1", "rot", math.sin(CurTime * 0.63) * 104)

	for i = 1, 32 do
		if lsglil2.ObjectExists("ButtonNew" .. i) then
			lsglil2.SetObjectPosition("ButtonNew" .. i, (math.sin(CurTime * 16 * (i / 256)) * w / 4) + w / 2, (math.cos(CurTime * 16 * (i / 256)) * h / 4) + h / 2)
		end
	end

	for i = 1, 3 do
		lsglil2.SetObjectData("PanelTransparency" .. i, "rot", math.sin(CurTime * 0.63 + (i / 2)) * 104)
	end

	if renderLokaAtCursor or false then
		local mx, my = love.mouse.getPosition()
		lsglil2.SetObjectPosition("PanelLoka",  mx, my)
	end
end

function love.textinput(t)
	local cancel = lsglil2.UpdateTextEntry(t)
	if not cancel then
		return
		--code to run if user isnt on a text entry
	end
end

function love.keypressed(key)
	local cancel lsglil2.UpdateTextEntryKeyPress(key)
	if not cancel then
		return
		-- code to run if user isnt on a text entry
	end
end

function love.draw() -- draw
	lsglil2.DrawElements()
	renderNotifications(0, 0)
end
