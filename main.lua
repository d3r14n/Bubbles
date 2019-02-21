require "Bubble"

function love.load()
	if not love.window.setFullscreen(true) then
		love.window.setMode(1000, 650, {resizable=true, vsync=false})
	end

	love.mouse.setVisible(true)

	background = {0, 0, 0}
	seconds = 0
	bubble = {}
	timeBetweenBubbles = 0.75
	secondsWithoutBubbles = 0
	fullBubble = false
	bubbleLines = 2

	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()

	love.graphics.setFont(love.graphics.newFont(24))
end

function love.update(dt)
	secondsWithoutBubbles = secondsWithoutBubbles + dt

	love.graphics.setBackgroundColor(background)

	if secondsWithoutBubbles >= timeBetweenBubbles then
		secondsWithoutBubbles = 0
		local x = table.getn(bubble) + 1
		bubble[x] = Bubble:new()
		local bubbleSize = love.math.random(10, 100)
		bubble[x]:blow(love.math.random(0, love.graphics.getWidth()), love.graphics.getHeight()+bubbleSize, bubbleSize, {love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255), love.math.random(30, 150)}, love.math.random(10, 30))
	end

	for i=1, table.getn(bubble) do
		bubble[i].secondsAlive = bubble[i].secondsAlive + dt
		bubble[i]:float()
	end

end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("Press \"Space\" to change the bubbles style.", 10, 10)
	love.graphics.print("Press any arrow key to change the bubble figure.", 10, 35)
	love.graphics.print("Press any other key to exit.", 10, 60)
	for i=1, table.getn(bubble) do
		if bubble[i].alive then
			love.graphics.setColor(bubble[i].color)
			if bubbleLines <= 2 then
				bubbleLines = 2
				if fullBubble then
					love.graphics.circle("fill", bubble[i].x, bubble[i].y, bubble[i].size)
				else
					love.graphics.circle("line", bubble[i].x, bubble[i].y, bubble[i].size)
				end
			else
				if bubbleLines >= 12 then
					bubbleLines = 12
				end
				if fullBubble then
					love.graphics.circle("fill", bubble[i].x, bubble[i].y, bubble[i].size, bubbleLines)
				else
					love.graphics.circle("line", bubble[i].x, bubble[i].y, bubble[i].size, bubbleLines)
				end
			end
		end
	end
end

function love.keypressed(key)
	if key == "space" or key == "left" or key == "right" or key == "up" or key == "down" then
		if key == "space" then
			if fullBubble then
				fullBubble = false
			else
				fullBubble = true
			end
		end
		if key == "left" or key == "down" then
			bubbleLines = bubbleLines - 1
		end
		if key == "right" or key == "up" then
			bubbleLines = bubbleLines + 1
		end
	else
		love.event.quit()
	end
end

function love.mousepressed(x, y, mouseButton)
	if mouseButton == 1 or mouseButton == 2 then
		for i=1, table.getn(bubble) do
			if x > bubble[i].x - bubble[i].size and x < bubble[i].x + bubble[i].size and y > bubble[i].y - bubble[i].size and y < bubble[i].y + bubble[i].size then
				bubble[i]:die()
			end
		end
	end
end