local function close_redis(red)  
    if not red then  
        return  
    end  
    local pool_max_idle_time = 10000 
    local pool_size = 100   
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)  
    if not ok then  
        ngx.say("set keepalive error : ", err)  
    end  
end   
local redis = require("resty.redis")  
  
local red = redis:new()  
red:set_timeout(1000)  
local ip = "192.168.4.196"
local port = 6379  
local ok, err = red:connect(ip, port)  
if not ok then  
    ngx.say("connect to redis error : ", err)  
    return close_redis(red)  
end  
ok, err = red:set("msg", "hello world")  
if not ok then  
    ngx.say("set msg error : ", err)  
    return close_redis(red)  
end  
  
local resp, err = red:get("msg")  
if not resp then  
    ngx.say("get msg error : ", err)  
    return close_redis(red)  
end  
if resp == ngx.null then  
    resp = '' 
end  
ngx.say("msg : ", resp)  
  
close_redis(red)
