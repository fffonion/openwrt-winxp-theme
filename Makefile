include $(TOPDIR)/rules.mk

LUCI_NAME:=luci-theme-xp
LUCI_TITLE:=Windows XP Luna Theme
LUCI_DEPENDS:=+luci-base +luci-theme-openwrt

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Codex

define Package/luci-theme-xp/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	if [ "$$(uci -q get luci.main.mediaurlbase)" = "/luci-static/xp" ]; then
		uci -q set luci.main.mediaurlbase='/luci-static/openwrt.org'
	fi
	uci -q delete luci.themes.XP
	uci commit luci
}
endef

define Package/luci-theme-xp/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	if ! uci -q get luci.themes.XP >/dev/null 2>&1; then
		uci set luci.themes.XP='/luci-static/xp'
	fi
	if ! uci -q get luci.main.mediaurlbase >/dev/null 2>&1; then
		uci set luci.main.mediaurlbase='/luci-static/xp'
	fi
	uci commit luci
	rm -f /tmp/luci-indexcache.*
	rm -rf /tmp/luci-modulecache/
	/etc/init.d/rpcd reload 2>/dev/null
	exit 0
}
endef

ifneq ($(wildcard ../../luci.mk),)
include ../../luci.mk
else
include $(TOPDIR)/feeds/luci/luci.mk
endif

# call BuildPackage - OpenWrt buildroot signature
