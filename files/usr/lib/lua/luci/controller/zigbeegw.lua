module("luci.controller.zigbeegw", package.seeall)

function index()
	
	if not nixio.fs.access("/etc/config/zigbeegw") then
		return
	end

	local page
	page = entry({"admin", "services", "zigbeegw"}, cbi("zigbeegw"), _("ZigBeeGW"), 40)
	page.dependent = true
end
