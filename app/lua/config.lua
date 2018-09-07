local _M = {}

_M._VERSION = '0.0.1'

_M.redis_config = {
    ["host"]     = "192.168.4.196",
    ["port"]     = "6379",
    ["poolsize"] = "10",
    ["idletime"] = "9000",
    ["timeout"]  = "1000",
}

return _M