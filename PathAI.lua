PathAI = class("PathAI")

function PathAI:ctor(parent)

	self.m_path = {}
	self.m_parent = parent



	self:init()

end

function PathAI:init()
	-- body
	for i=1,10 do
		local node = {}
		node.x = i
		node.y = i
		table.insert(self.m_path,node)
	end
end

function PathAI:addPath(path)
	-- body
	self.m_path = path or {}
end

function PathAI:update(dt)
	-- body
	local distance = dt*Camera.speed
	self.m_src = {x = 0,y = 0}
	self.m_dst = self.m_path[1]
	self.m_dst_pixel = Map.convertCell2Pixel(self.m_dst)
	local dis_vector = cc.pSub(self.m_dst,self.m_src)
	self.m_normalize = cc.pNormalize(dis_vector)
	self.m_angle = math.acos(cc.pNormalize(dis_vector).x)
	
	local distance_x = self.m_normalize.x*distance
	local distance_y = self.m_normalize.y*distance
	local delta = cc.p(distance_x,distance_y)

	self.m_start_pos = cc.pAdd(self.m_start_pos,delta)

	if distance_x > 0 then
		if self.m_start_pos.x > dst_pixel.x then
			self.m_start_pos.x = dst_pixel.x
			

			
			--进入下一个点
			self:toNextNode()

		else

		end
	else
		if self.m_start_pos.x < dst_pixel.x then
			self.m_start_pos.x = dst_pixel.x
		else

		end

	end


	if distance_y > 0 then

		if self.m_start_pos.y > dst_pixel.y then
			self.m_start_pos.y = dst_pixel.y
		else

		end
	else
		if self.m_start_pos.y < dst_pixel.y then
			self.m_start_pos.y = dst_pixel.y
		else

		end

	end

	--printInfo("camera move distance distance:%f",distance)

	-- if math.abs(self.m_target_pos.x - self.m_pos.x) > distance then

	-- 	if self.m_target_pos.x > self.m_pos.x then
	-- 		self.m_pos.x = self.m_pos.x + distance
	-- 	else
	-- 		self.m_pos.x = self.m_pos.x - distance
	-- 	end

	-- else

	-- end

	-- if math.abs(self.m_target_pos.y - self.m_pos.y) > distance then

	-- 	if self.m_target_pos.y > self.m_pos.y then
	-- 		self.m_pos.y = self.m_pos.y + distance
	-- 	else
	-- 		self.m_pos.y = self.m_pos.y - distance
	-- 	end

	-- else

	-- end


end

function PathAI:toNextNode()
	-- body
	self.m_src = {}
	self.m_src.x = self.m_path[1].x
	self.m_src.y = self.m_path[1].y
	table.remove(self.m_path,1)
	self.m_dst = self.m_path[1]
	self.m_dst_pixel = Map.convertCell2Pixel(self.m_dst)
	local dis_vector = cc.pSub(self.m_dst,self.m_src)
	self.m_normalize = cc.pNormalize(dis_vector)
	self.m_angle = math.acos(cc.pNormalize(dis_vector).x)
end