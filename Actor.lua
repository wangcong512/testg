Actor = class("Actor",cc.Node)

function Actor:ctor()
	-- body
	self.m_path = {1,2,3,5,6}

	self.m_aimgr = AIMgr.create()
	self.m_sprite = display.newSprite("Lamborghini.png")
	self:add(self.m_sprite)
	self.m_sprite:setRotation(90)
	self.m_path_ai = PathAI:create(self)
end

function Actor:update(dt)
	-- body
	self.m_aimgr:update(dt)
	self.m_path_ai:update(dt)
end

function Actor:getPathAIMgr()
	-- body

	return self.m_path_ai
end

function Actor:changeDir(dir)
	-- body

	if dir == ActorAnimation.DirType.MoveDown then
		self.m_sprite:setRotation(0)
	elseif dir == ActorAnimation.DirType.MoveDownLeft then
		self.m_sprite:setRotation(45)

	elseif dir == ActorAnimation.DirType.MoveLeft then
		self.m_sprite:setRotation(90)

	elseif dir == ActorAnimation.DirType.MoveLeftUp then
		self.m_sprite:setRotation(135)
	elseif dir == ActorAnimation.DirType.MoveUp then
		self.m_sprite:setRotation(180)
	elseif dir == ActorAnimation.DirType.MoveRightUp then
		self.m_sprite:setRotation(225)
	elseif dir == ActorAnimation.DirType.MoveRight then
		self.m_sprite:setRotation(270)
	elseif dir == ActorAnimation.DirType.MoveRightDown then
		self.m_sprite:setRotation(315)

	else


	end





end

