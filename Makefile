#
# Copyright (C) 2010-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-zigbeegw
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-zigbeegw
  SECTION:=LuCI
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI Support for zigbeegw
  DEPENDS:=+libc +zigbeegw
  PKGARCH:=all
endef

define Package/luci-app-zigbeegw/description
LuCI Support for zigbeegw
endef

define Build/Compile
endef

define Package/luci-app-zigbeegw/install
	$(CP) ./files/* $(1)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./init.d/zigbeegw.init $(1)/etc/init.d/zigbeegw
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./init.d/zigbeegw.conf $(1)/etc/config/zigbeegw
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_CONF) ./hotplug.d/30-mrvldongle $(1)/etc/hotplug.d/usb/
endef

define Package/luci-app-zigbeegw/postinst
#!/bin/sh
[ -n "${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-zigbeegw ) && rm -f /etc/uci-defaults/luci-zigbeegw
	chmod 755 /etc/init.d/zigbeegw >/dev/null 2>&1
	/etc/init.d/zigbeegw enable >/dev/null 2>&1
	exit 0
}
endef

define Package/luci-app-zigbeegw/conffiles
/etc/config/zigbeegw
endef

$(eval $(call BuildPackage,luci-app-zigbeegw))
