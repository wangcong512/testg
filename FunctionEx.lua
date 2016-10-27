function newSet()
	-- body    
	local reverse = {} --以数据为key，数据在set中的位置为value
    local set = {} --一个数组，其中的value就是要管理的数据
    return setmetatable(set,{__index = {
          insert = function(set,value)
              if not reverse[value] then
                    table.insert(set,value)
                    reverse[value] = table.getn(set)
              end
          end,

          remove = function(set,value)
              local index = reverse[value]
              if index then
                    reverse[value] = nil
                    local top = table.remove(set) --删除数组中最后一个元素
                    if top ~= value then
                        --若不是要删除的值，则替换它
                        reverse[top] = index
                        set[index] = top
                    end
              end
          end,

          find = function(set,value)
              local index = reverse[value]
              return (index and true or false)
          end,
    }})

end