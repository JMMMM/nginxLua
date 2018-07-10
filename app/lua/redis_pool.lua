local redis = require "resty.redis"
local redis_pool = {}

function redis_pool:get_connect()
    local client,err = redis:new()
    if not client then
        return false,"redis.socket_failed:" .. (err or "nil")
    end
    client:set_timeout(5000)
    local result,msg = client:connect("192.168.4.89","6379")
    if not result then
        return false,msg
    end

    return true,client
end

function redis_pool:close(client)
    if not client then
        return
    end

    local pool_max_idle_time = 1000
    local pool_size =10
    local ok,err = client.set_keepalive(pool_max_idle_time,pool_size)
    if not ok then
        ngx.say("set keepalive error:",err)
     end
end

return redis_pool