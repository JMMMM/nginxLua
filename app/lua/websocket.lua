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

local res,err = redis:subscribe(topic)
if not res then
    ngx.log(ngx.ERR,"failed to sub redis: ",err)
end


local push = function()
    while true do
        local res,err = redis:read_reply()
        if res then
            local item = res[3]
            local bytes,err = wb:send_text(item)
            ngx.log(ngx.INFO,item)
            if not bytes then
                ngx.log(ngx.ERR,"failed to send text:",err)
            end
        end
    end
end

local co = ngx.thread.spawn(push)

--main loop
while true do
    -- 获取数据
    local data, typ, err = wb:recv_frame()

    -- 如果连接损坏 退出
    if wb.fatal then
        ngx.log(ngx.ERR, "failed to receive frame: ", err)
        return ngx.exit(444)
    end

    if not data then
        local bytes, err = wb:send_ping()
        if not bytes then
          ngx.log(ngx.ERR, "failed to send ping: ", err)
          return ngx.exit(444)
        end
    elseif typ == "close" then
        wb:send_close()
        break
    elseif typ == "ping" then
        local bytes, err = wb:send_pong()
        if not bytes then
            ngx.log(ngx.ERR, "failed to send pong: ", err)
            return ngx.exit(444)
        end
    else
        ngx.log(ngx.INFO, "received a frame of type ", typ, " and payload ", data)
    end
end

wb:send_close()
ngx.thread.wait(co)