local _M = {}
_M._VERSION ='0.0.1'

local resty_redis = require "resty.redis"

_M.new = function(self,conf)
    self.host = conf.host
    self.port = conf.port
    self.timeout = conf.timeout
    self.poolsize = conf.poolsize
    self.idletime = conf.idletime

    self.client = resty_redis:new()
    return setmetatable({client = self.client},{__index=_M})
end

_M.get_connect = function(self)
    self.client:set_timeout(self.timeout)
    local ok,err = self.client:connect(self.host,self.port)
    if not ok then return false,err end
    return true,""
end

_M.return_connect = function(self)
    local pool_max_idle_time = 1000
    local pool_size = 10
    return self.client:set_keepalive(pool_max_idle_time, pool_size)
end

return _M