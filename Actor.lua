Actor = class("Actor",cc.Node)

function Actor:ctor()
	-- body
	self.m_path = {1,2,3,5,6}

	self.m_aimgr = AIMgr.create()
	self.m_sprite = display.newSprite("Lamborghini.png")
	self:add(self.m_sprite)
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

