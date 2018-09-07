local redis_pool = require("redis_pool")

local client = redis_pool:new('192.168.4.196', '6379', 5000)
local ok, err = redis_pool:get_connect()
if not ok then ngx.log(ngx.ERR, err) end

local resp, err = client:lrange("gray_list", 0, -1)
redis_pool.return_connect(client)

local sharedDb = ngx.shared.shared_dict
sharedDb:set('gray_list', resp)
ngx.say(resp)