Actor = class("Actor",cc.Node)

function Actor:ctor( ... )
	-- body
	self.m_path = {1,2,3,5,6}

	self.m_aimgr = AIMgr.create()
end

function Actor:update(dt)
	-- body
	self.m_aimgr:update()
end

