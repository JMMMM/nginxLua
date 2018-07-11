local res,err = ngx.location.capture("/redis/hget",{args={key="gray",mKey="16218"}})
local parser = require "redis.parser"
local server,type = parser.parse_reply(res.body)
if not server then
    server="192.168.4.89:8080"
end
ngx.var.target = server
return
