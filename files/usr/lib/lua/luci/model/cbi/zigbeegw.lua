local fs = require "nixio.fs"
local util = require "nixio.util"

local running=(luci.sys.call("pidof zigbeegw > /dev/null") == 0)
if running then	
	m = Map("zigbeegw", translate("ZigBeeGW"), translate("ZigBeeGW is running"))
else
	m = Map("zigbeegw", translate("ZigBeeGW"), translate("ZigBeeGW is not running"))
end

s = m:section(TypedSection, "zigbeegw", translate("ZigBeeGW"))
s.anonymous = true

s:tab("basic",  translate("Basic"))

enable = s:taboption("basic", Flag, "enabled", translate("Enable"))

device = s:taboption("basic", Value, "device", translate("Device"),translate("Default Device is /dev/ttyUSB0"))

path = s:taboption("basic", Value, "path", translate("Database Path"),translate("Default Database Path is /tmp/zigbeegw/"))

s:taboption("basic", DummyValue,"opennewwindow" ,translate("<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"Home Automation\" onclick=\"window.open('http://'+window.location.host+':8000')\" /></p>"), detailInfo)

return m
