local redis_pool = require("redis_pool")

local ok,client = redis_pool.get_connect()

if not ok then
    ngx.say("redis pool exception ")
end

client:set("msg","hello demo4!");

local resp, err = client:get("msg")

if not resp then
    ngx.say("get msg error : ", err)
    return close_redis(red)
end

if resp == ngx.null then
    resp = ''
end

ngx.say(resp)
redis_pool.close(client)