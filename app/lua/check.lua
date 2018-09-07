local sharedDb = ngx.shared.shared_dict
local gray_list = sharedDb:get("gray_list")

local staffId = ngx.var.cookie_StaffId
local s_value = gray_list[staffId]

if s_value ~= nil and "gray" == s_value then
    return ngx.redirect("/gray")
end

return ngx.redirect("/product")