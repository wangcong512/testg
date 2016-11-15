Map = class("Map",cc.Node)
Map.CellWidth = 32
Map.RenderWidth = 256
function Map.convertCell2Pixel(x,y)
	-- body
	x = x or 0
	if not y then
		return x*Map.CellWidth
	end

	local pt = {}
	pt.x,pt.y = x*Map.CellWidth,y*Map.CellWidth
	return pt
end

function Map.convertPixel2Cell(x,y)
	-- body
	x = x or 0
	if not y then
		return math.floor(x/Map.CellWidth)
	end

	local pt = {}
	pt.x,pt.y = math.floor(x/Map.CellWidth),math.floor(y/Map.CellWidth)
	return pt
end

function Map:ctor()
 	-- body
 	self.m_total_time = 10
 	self.m_hero = Actor.create()
 	
 	self.m_hero:setPosition(ccp(200,200))

 	self.m_camera = Camera.create(self)

 	self.m_map_width = 0
 	self.m_map_height = 0

 	self.m_total_time = 10

 	self.m_map_data = MapData.create()

 	--init
 	self:onCreate()
 	self:initTouch()

 	self:add(self.m_hero)


 
end 

function Map:initTouch()
	-- body
	--注册事件
 	--触屏事件  
    local function onTouchBegan(touch, event)  
        printInfo("onTouchBegan")
        --printInfo("x:%d,y:%d",touch:getLocation().x,touch:getLocation().y)
         
        self.m_hero:getPathAIMgr():addPathByPt(touch:getLocation())  
        return true  
    end  
      
    local function onTouchMoved(touch, event)  
        printInfo("onTouchMoved")
        --printInfo("x:%d,y:%d",touch:getLocation().x,touch:getLocation().y)  
    end  
      
    local function onTouchEnded(touch, event)  
        printInfo("onTouchEnded")  
        --printInfo("x:%d,y:%d",touch:getLocation().x,touch:getLocation().y)
    end  
      
    local listenerTouch = cc.EventListenerTouchOneByOne:create()  
    listenerTouch:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)  
    listenerTouch:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)  
    listenerTouch:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)  
      
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listenerTouch,self)  

end

function Map.getInstance()
	-- body
	-- local instance =  Map.create()
	-- return instance
	if G.m_game_map then
		return G.m_game_map
	else
		G.m_game_map = Map.create()
		return G.m_game_map
	end

end

function Map:onCreate( ... )
	-- body
	
    self.m_bk = display.newSprite("76.jpg")
    self.m_bk:setAnchorPoint(cc.p(0,0))
    self.m_bk:move(cc.p(0, 0))
            :addTo(self)


    self:initMap()


end



function Map:initMap()
	-- body
	local size = self:getContentSize()
	size.width = 2500
	size.height = 1667

	self.m_map_width = size.width
	self.m_map_height = size.height


end

--间隔一段时间调整一下镜头
function Map:update(dt)
	-- body
	local temp_value = dt + dt

	self.m_total_time = self.m_total_time + dt
	--printInfo(" Map:update total_time:%f dt:%f",self.m_total_time,dt)
	-- if self.m_total_time < 0 then
	-- 	self.m_total_time  = 0.0
	-- end
	-- if self.m_total_time > 1 then
	self:ajustPosition()
	-- 	self.m_total_time = self.m_total_time - 2
	-- 	printInfo(" Map:update total_time:%f",self.m_total_time)
	-- end

	self.m_camera:update(dt)
	if self.m_hero then self.m_hero:update(dt) end


	
end

function Map:ajustPosition()
	-- body

	local x = self.m_camera.m_pos.x
	local y = self.m_camera.m_pos.y
	local width = self.m_camera.m_width
	local height = self.m_camera.m_height
	--printInfo(" Map:ajustPosition x:%d y:%d",-x,-y)

	local map_max_move_x = math.max(0,self.m_map_width - width)
	local map_max_move_y = math.max(0,self.m_map_height - height)
	--printInfo(" Map:ajustPosition move x:%d y:%d",self.m_map_width,width)

	x = math.min(x,map_max_move_x)
	y = math.min(y,map_max_move_y)
	--printInfo(" Map:ajustPosition x:%d y:%d",-x,-y)

	x = math.max(x,0)
	y = math.max(y,0)


	self:setPosition(-x, -y)
	--printInfo(" Map:ajustPosition x:%d y:%d",-x,-y)
	


end