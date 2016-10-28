Camera = class("Camera")
Camera.pos_x = 0
Camera.pos_y = 0
Camera.speed = 100

function Camera:ctor(parent)
	-- body

	self.m_pos = cc.p(0,0)
	self.m_target_pos = cc.p(0,0)
	self.m_parent = parent
	local size = cc.Director:getInstance():getWinSize()
	self.m_width = size.width
	self.m_height = size.height
end

function Camera:setCameraPos(pos)
	-- body
	self.m_pos = pos
end

function Camera:moveCamera(pos)
	-- body
end

function Camera:update(dt)
	-- body
	local distance = dt*Camera.speed
	--printInfo("camera move distance distance:%f",distance)

	if math.abs(self.m_target_pos.x - self.m_pos.x) > distance then

		if self.m_target_pos.x > self.m_pos.x then
			self.m_pos.x = self.m_pos.x + distance
		else
			self.m_pos.x = self.m_pos.x - distance
		end

	end

	if math.abs(self.m_target_pos.y - self.m_pos.y) > distance then

		if self.m_target_pos.y > self.m_pos.y then
			self.m_pos.y = self.m_pos.y + distance
		else
			self.m_pos.y = self.m_pos.y - distance
		end

	end

end

function Camera:moveToPoint()
	-- body
end

