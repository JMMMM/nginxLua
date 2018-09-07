local sharedDb = ngx.shared.shared_dict

local staffId = ngx.var.cookie_StaffId
local s_value = sharedDb:get(staffId)

if s_value ~= nil and "gray" == s_value then
    return ngx.location.capture("/gray")
end

return ngx.location.capture("/product")