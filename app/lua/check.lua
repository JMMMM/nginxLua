local sharedDb = ngx.shared.shared_dict

local staffId = ngx.var.cookie_StaffId
local s_value = sharedDb:get(staffId)

if s_value ~= nil and "gray" == s_value then
    ngx.say("gray")
    return
end
ngx.say("product")
return