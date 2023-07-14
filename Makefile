#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

# PAK NAME ����Ͱ������ļ���һ��.
PKG_NAME:=luci-app-vhUSBService

# �����������������д.
LUCI_PKGARCH:=all
PKG_VERSION:=2.0.2
PKG_RELEASE:=20210917

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk

# ��������ʾ��menuconfig�еĲ˵�·��
# SUBMENU������ŵ������Լ�diy��һ���˵�ѡ��,
# ����˵�����ȫ���Լ��İ�,�ȽϺ���.
define Package/$(PKG_NAME)
 	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=VirtualHere USB Service for LuCI
	DEPENDS:=@(i386||x86_64||arm||mipsel)
	PKGARCH:=all
endef

# ������˵��,��Ҫ������.
define Package/$(PKG_NAME)/description
    This package contains LuCI configuration pages for VH USB Service.
endef


#preinst : ��װǰִ�� , һ����������½�Ŀ¼ ,
#����ļ�������һ�������ڵ�Ŀ¼�����,������Щ��Ҫ��װǰ�½�Ŀ¼.���ߴ���һЩ�ļ���ͻ,��ԭ�����ļ�����#
define Package/$(PKG_NAME)/preinst
endef




#postinst : ��װ���ִ�� ,һ����ǰ�װ���Ȩ��,����ֱ������.
# ��װ��ִ�еĽű�
# ���������þ��ǰ�װ���./usr/bin/vhusbd���ִ��Ȩ��.

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	chmod 755 "$${IPKG_INSTROOT}/usr/bin/vhusbd" >/dev/null 2>&1
	chmod 755 "$${IPKG_INSTROOT}/usr/bin/vhusbd" >/dev/null 2>&1
fi
exit 0

#prerm : ж��ǰִ��

#postrm : ж�����ִ��

endef

define Build/Prepare
endef

define Build/Compile
endef

ifeq ($(ARCH),x86_64)
	EXE_FILE:=vhusbdx86
endif
ifeq ($(ARCH),i386)
	EXE_FILE:=vhusbdx86
endif
ifeq ($(ARCH),mipsel)
	EXE_FILE:=vhusbdmipsel
endif
ifeq ($(ARCH),arm)
	EXE_FILE:=vhusbdarm
endif

# ��װ��ҵ
# ����һ����Ǹ����ļ�
# ����и����ļ�ֱ�Ӳο��޸�,�ǳ���.

define Package/$(PKG_NAME)/install

	# ��������һ��
	# ��һ����ָ�����Ƶ���Ŀ¼
	# �ڶ����ǿ����ļ�.
 
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	#cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
  $(INSTALL_BIN) ./luasrc/* $(1)/usr/lib/lua/luci
   
	$(INSTALL_DIR) $(1)/
	#cp -pR ./root/* $(1)/
  $(INSTALL_BIN) ./root/* $(1)/ 
  
	$(INSTALL_DIR) $(1)/usr/bin
	#cp -pR ./bin/$(EXE_FILE) $(1)/usr/bin/vhusbd
  $(INSTALL_BIN) ./bin/$(EXE_FILE) $(1)/usr/bin/vhusbd
 
endef


$(eval $(call BuildPackage,$(PKG_NAME)))

# call BuildPackage - OpenWrt buildroot signature
