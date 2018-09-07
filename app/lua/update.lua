local redis_pool = require("redis_pool")
local config = require("config")

local pool = redis_pool:new(config.redis_config)
local ok, err = redis_pool:get_connect()
if not ok then ngx.log(ngx.ERR, err) end

local resp, err = pool.client:lrange("gray_list", 0, -1)
redis_pool:return_connect()

local sharedDb = ngx.shared.shared_dict
sharedDb:set('gray_list', resp)
ngx.say(resp)