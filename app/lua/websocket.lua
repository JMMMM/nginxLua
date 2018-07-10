local server = require "resty.websocket.server"
local pool = require "redis_pool"
local ok,redis = pool:get_connect()

local topic = "topic1"

local wb,err = server:new{
    timeout = 5000,
    max_payload_len = 65535
}

--create success
if not wb then
  ngx.log(ngx.ERR, "failed to new websocket: ", err)
  return ngx.exit(444)
end

