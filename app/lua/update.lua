local redis_pool = require("redis_pool")
local ok,client = redis_pool.get_connect()

if not ok then
    ngx.say("redis pool exception ")
end

local resp,err = client:lrange("gray_list",0,-1)

if not resp then
    ngx.say("get gray_list error:",err)
    return redis_pool.close(client)
end

redis_pool.close(client)
if resp == ngx.null then
    resp =''
end

local sharedDb = ngx.shared.shared_dict
sharedDb:set('gray_list',resp)
ngx.say(resp)