AnimationMgr = class("AnimationMgr")

function AnimationMgr:ctor()
	-- body
	self.m_chilren = newSet()
end

function AnimationMgr.getInstance()
	-- body
	if not G.m_animationmgr then
		return G.m_animationmgr
	else
		G.m_animationmgr = AnimationMgr.create()
		return G.m_animationmgr
	end

end

function AnimationMgr:addChild(node)
	-- body
	self.m_chilren:insert(node)
end

function AnimationMgr:removeChild(node)
	-- body
	self.m_chilren:remove(node)
end

function AnimationMgr:update(dt)
	-- body

	for k,v in pairs(self.m_chilren) do
		v:update(dt)
	end
end