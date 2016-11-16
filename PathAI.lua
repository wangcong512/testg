PathAI = class("PathAI")

function PathAI:ctor(parent)

	self.m_path = {}
	self.m_parent = parent

	self.m_is_move = false

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

	self.m_path = table.reverse(self.m_path)


	
	self.m_src = {x = 0,y = 0}
	self.m_dst = self.m_path[#self.m_path]
	self.m_dst_pixel = Map.convertCell2Pixel(self.m_dst.x,self.m_dst.y)
	local dis_vector = cc.pSub(self.m_dst,self.m_src)
	self.m_normalize = cc.pNormalize(dis_vector)
	self.m_angle = math.acos(cc.pNormalize(dis_vector).x)

	self.m_start_pos = {x = 0,y = 0}
	self.m_is_move = true
end

function PathAI:addPathByPt(dst_pt_pixel)
	-- body
	local src = Map.convertPixel2Cell(dst_pt_pixel.x,dst_pt_pixel.y)
	printInfo("add_positon x:%d y:%d",self.m_parent:getPosition3D().x,0)
	local dst = Map.convertPixel2Cell(self.m_parent:getPosition3D().x,self.m_parent:getPosition3D().y)
	local path = Path:GenPath(src,dst)

	self:addPath(path)

end

function PathAI:addPath(path)
	-- body
	path = path or {}
	self.m_path = path--table.reverse(path)

	dump(self.m_path)
	self.m_src = Map.convertPixel2Cell(self.m_parent:getPosition3D().x,self.m_parent:getPosition3D().y)
	self.m_dst = self.m_path[#self.m_path]
	self.m_dst_pixel = Map.convertCell2Pixel(self.m_dst.x,self.m_dst.y)
	local dis_vector = cc.pSub(self.m_dst,self.m_src)
	self.m_normalize = cc.pNormalize(dis_vector)
	self.m_angle = math.acos(cc.pNormalize(dis_vector).x)

	self.m_start_pos = {x = self.m_parent:getPosition3D().x,y = self.m_parent:getPosition3D().y}
	self.m_is_move = true


end


function PathAI:update(dt)
	-- body

	if not self.m_is_move then
		return
	end

	local distance = dt*Camera.speed
	local distance_x = self.m_normalize.x*distance
	local distance_y = self.m_normalize.y*distance
	local delta = cc.p(distance_x,distance_y)

	self.m_start_pos = cc.pAdd(self.m_start_pos,delta)

	

	if distance_x > 0 then
		if self.m_start_pos.x > self.m_dst_pixel.x then
			--self.m_start_pos.x = self.m_dst_pixel.x
			

			
			--进入下一个点
			
			--没有路径走的时候停止
			self.m_is_move = self:toNextNode()
			return

		else

		end
	else
		if self.m_start_pos.x < self.m_dst_pixel.x then
			--self.m_start_pos.x = self.m_dst_pixel.x
			--self.m_is_move = self:toNextNode()
			self.m_is_move = self:toNextNode()
			return
		else

		end

	end


	if distance_y > 0 then

		if self.m_start_pos.y > self.m_dst_pixel.y then
			--self.m_start_pos.y = self.m_dst_pixel.y
			self.m_is_move = self:toNextNode()
			return

		else

		end
	else
		if self.m_start_pos.y < self.m_dst_pixel.y then
			--self.m_start_pos.y = self.m_dst_pixel.y
			self.m_is_move = self:toNextNode()
			return
		else

		end

	end

	self.m_parent:setPosition(self.m_start_pos)

	

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
	
	self.m_src = table.remove(self.m_path)
	
	if #self.m_path <= 0 then return false end

	self.m_dst = self.m_path[#self.m_path]
	printInfo("toNext_node index:%d x:%d y:%d",#self.m_path,self.m_dst.x,self.m_dst.y)
	self.m_dst_pixel = Map.convertCell2Pixel(self.m_dst.x,self.m_dst.y)
	local dis_vector = cc.pSub(self.m_dst,self.m_src)
	self.m_normalize = cc.pNormalize(dis_vector)
	self.m_angle = math.acos(cc.pNormalize(dis_vector).x)
	self:changeDir()
	return true
end

function PathAI:changeDir()
	-- body

	--pi/8   0.3927
	--pi3/8  1.1781
	--pi5/8  1.9635
	--pi7/8  2.7489
	--pi9/8  3.5343  
	--pi11/8 4.3197 
	--pi13/8 5.1051 
	--pi15/8 5.8905 
	--pi17/8 6.6759

	local pi_1_8 =  0.3927
	local pi_3_8 =  1.1781
	local pi_5_8 =  1.9635
	local pi_7_8 =  2.7489
	local pi_9_8 =  3.5343  
	local pi_11_8 = 4.3197   
	local pi_13_8 = 5.1051 
	local pi_15_8 = 5.8905 
	local pi_17_8 = 6.6759
	local pi_19_8 = -0.3927


	local dir = ActorAnimation.DirType.MoveDown


	if self.m_angle > pi_19_8  and  self.m_angle <= pi_1_8 then
		dir = ActorAnimation.DirType.MoveRightDown
	elseif self.m_angle > pi_1_8  and  self.m_angle <= pi_3_8 then
		dir = ActorAnimation.DirType.MoveRight
	elseif self.m_angle > pi_3_8  and  self.m_angle <= pi_7_8 then
		dir = ActorAnimation.DirType.MoveRightUp
	elseif self.m_angle > pi_7_8  and  self.m_angle <= pi_9_8 then
		dir = ActorAnimation.DirType.MoveUp
	elseif self.m_angle > pi_9_8  and  self.m_angle <= pi_11_8 then
		dir = ActorAnimation.DirType.MoveLeftUp
	elseif self.m_angle > pi_11_8  and  self.m_angle <= pi_13_8 then
		dir = ActorAnimation.DirType.MoveLeft
	elseif self.m_angle > pi_13_8  and  self.m_angle <= pi_15_8 then
		dir = ActorAnimation.DirType.MoveDownLeft
	elseif self.m_angle > pi_15_8  and  self.m_angle <= pi_17_8 then
		dir = ActorAnimation.DirType.MoveDown
	else

	end



	self.m_parent:changeDir(dir)
end