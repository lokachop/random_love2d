function love.load() -- called on start
	local f = love.filesystem.load("/initlua.lua")
	f()

	HeightMap = {}

	PlyPos = {0, 0, 0}
	PlyDir = {0, 1, 0}
	PlyVert = 0
	ResMultZ = 1
	ResDivW = 1
	zMult = 92
	FOV = 16
	CurTime = 0
	ZResDiv = 0.01

	addNotification("hi", 2)
end

function handleMove(dt)
	if love.keyboard.isDown("space") then
		PlyPos[3] = PlyPos[3] + dt * 4
		--PlyVert = PlyVert + dt * 4
	end
	if love.keyboard.isDown("lshift") then
		PlyPos[3] = PlyPos[3] - dt * 4
		--PlyVert = PlyVert + dt * 4
	end


	if love.keyboard.isDown("w") then
		PlyPos = vadd(PlyPos, vmul(PlyDir, dt * 8))
	end
	if love.keyboard.isDown("s") then
		PlyPos = vadd(PlyPos, vmul(PlyDir, -dt * 8))
	end


	if love.keyboard.isDown("a") then
		PlyDir = vrot(PlyDir, dt * 2)
	end

	if love.keyboard.isDown("d") then
		PlyDir = vrot(PlyDir, -dt * 2)
	end

end


function love.update(dt) -- dt is deltatime
	CurTime = CurTime + dt
	handleMove(dt)
	notificationThink()
end


function renderHeightMap(x, dir)
	local w, h = love.graphics.getDimensions()

	for z = 1, 0, (-ZResDiv * ResMultZ) do
		local pointPos = vadd(PlyPos, vmul(dir, z * zMult))
		pointPos = vmul(pointPos, 1)

		local rx = math.floor(pointPos[1] + 1)
		local ry = math.floor(pointPos[2] + 1)

		if HeightMap[rx] == nil then
			HeightMap[rx] = {}
		end
		if HeightMap[rx][ry] == nil then
			HeightMap[rx][ry] = love.math.noise(rx / 32, ry / 32, 0) * 4
		end


		local col = HeightMap[rx][ry]
		local r, g, b = hsvToRGB(col, 1, 1)

		local hlb = (HeightMap[rx][ry] - 1) * 1
		local hl = (PlyPos[3] - hlb) / z + PlyVert

		local zfogcalc = math.abs(1 - z)
		love.graphics.setColor(r * zfogcalc, g * zfogcalc, b * zfogcalc)
		love.graphics.rectangle("fill", x * ResDivW, hl * 32, 1 * ResDivW, h)
	end
end

function love.draw() -- draw
	local w, h = love.graphics.getDimensions()

	for i = 0, w / ResDivW do
		--local iRel = -(i / (w / ResDivW))
		--local rotCalc = iRel + ((i / (w / ResDivW)) / 2)

		local iRel = -(i - ((w / ResDivW) / 2))
		local rotCalc = iRel / (w / 2)

		local dirrotated = vrot(PlyDir, rotCalc)

		renderHeightMap(i, dirrotated)
	end

	love.graphics.print("plyPos: x"..tostring(PlyPos[1])..", y"..tostring(PlyPos[2])..", z"..tostring(PlyPos[3]), 0, 0)
	love.graphics.print("plyDir: x"..tostring(PlyDir[1])..", y"..tostring(PlyDir[2])..", z"..tostring(PlyDir[3]), 0, 16)

	renderNotifications(w / 2, 0)
end
