function love.conf(t)
	t.version = "11.3"
	t.window.title = "heightmap renderer"
	t.window.borderless = false
    t.window.width = 800
    t.window.height = 600
    t.window.vsync = 1
	t.console = true
	t.modules.joystick = false
end