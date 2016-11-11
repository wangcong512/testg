ActorAnimation = class("ActorAnimation",cc.ActionInterval)

ActorAnimation.DirType = {}
ActorAnimation.DirType.MoveDown = 1
ActorAnimation.DirType.MoveDownLeft = 2
ActorAnimation.DirType.MoveLeft = 3
ActorAnimation.DirType.MoveLeftUp = 4
ActorAnimation.DirType.MoveUp = 5
ActorAnimation.DirType.MoveRightUp = 6
ActorAnimation.DirType.MoveRight = 7
ActorAnimation.DirType.MoveRightDown = 8


ActorAnimation.BodyParts = {}
ActorAnimation.BodyParts.Cloth = 1
ActorAnimation.BodyParts.Weapon = 2
ActorAnimation.BodyParts.Mount = 3
ActorAnimation.BodyParts.Wing = 4


function ActorAnimation.create()
	-- body
	self.m_cloth = display.newSprite()
	self.m_weapon = display.newSprite()
	self.m_mount = display.newSprite()
	self.m_wing = display.newSprite()

	self.m_frames = 0
	self.m_cur_frame = 1
	self.m_kf = 0
	self.m_frames = {}


	self.m_action_id = 1


end

--异步加载frame
function ActorAnimation:load(res_name)
	-- body
	local path_info = io.pathinfo(res_name)
	while true do
		local temp_path = string.format("%s%d%s",res_name,res_index,G.res_suffix)
	    local temp_plist_path = string.format("%s%d.plist",res_name,res_index)
	    local fullpath =  cc.FileUtils:getInstance():fullPathForFilename(temp_path);
	    if not cc.FileUtils:getInstance():isFileExist(temp_path) then
	        break
	    end
        local function reloadCallBack(texture)
            -- body
            cc.SpriteFrameCache:getInstance():addSpriteFrames(temp_plist_path,texture)
            res_queue = res_queue - 1
            if res_queue == 0 then
               	self.m_frames = {}
                for k,v in pairs(ActorAnimation.DirType) do
                	self.m_frames[v] = {}
                	for i = 1,10 do
	                	local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("%s_%d_%d.png",path_info.basename,v,i))
	                    if frame then
	                        table.insert(self.m_frames[v][i],frame)
	                    end
                	end

                    
                end

                -- local animation = cc.Animation:createWithSpriteFrames(frames,0.1,-1)
                -- local animate = cc.Animate:create(animation)
                
                -- self.m_sprite:runAction(animate)



            end
        end
        cc.TextureCache:getInstance():addImageAsync(temp_path,reloadCallBack)
        res_index = res_index + 1
        res_queue = res_index

        
    end


end


function ActorAnimation:update(dt)
	-- body

	for i=1,#ActorAnimation.BodyParts do
		self.m_frames[i] = self.m_frames[i] or {}
		self.m_frames[self.m_action_id] = self.m_frames[self.m_action_id] or {}
		self.m_sprite:setSpriteFrame(self.m_frames[i][self.m_action_id][self.m_cur_frame])
	end



end

function ActorAnimation:changeState(action_id)
	-- body
	if action_id > #ActorAnimation.DirType then
		printInfo("ActorAnimation:changeState eror action_id:%d",action_id)
	else
		self.m_action_id = action_id
	end
	
end