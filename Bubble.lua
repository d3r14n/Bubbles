Bubble =
{
	x = nil,
	y = nil,
	windX = 0,
	windY = 0,
	size = nil,
	color = nil,
	resistence = nil,
	secondsAlive = 0,
	alive = true
}

function Bubble:new(object)
	object = object or {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function Bubble:blow(horizontal, vertical, air, soap, quality)
	self.x = horizontal
	self.y = vertical
	self.windX = love.math.random(-50, 50)/100
	self.windY = love.math.random(50, 200)/100
	self.size = air
	self.color = soap
	self.resistence = quality
end

function Bubble:float()
	if self.alive then
		self.x = self.x + self.windX
		self.y = self.y - self.windY
		if self.secondsAlive >= self.resistence then
			self:die()
		end
	end
end

function Bubble:die()
	self.alive = false
end