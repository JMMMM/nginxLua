local res,err = ngx.location.capture("/redis/hget",{args={key="gray",mKey="16218"}})
local parser = require "redis.parser"
local server,type = parser.parse_reply(res.body)
if not res or not server then
    server="default"
end
ngx.say("server is :" .. server)
