DEBUG = 0
TARGET = iphone:latest:8.0
PACKAGE_VERSION = 0.0.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ReachabilitySwitch
ReachabilitySwitch_FILES = Switch.xm
ReachabilitySwitch_LIBRARIES = flipswitch substrate
ReachabilitySwitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk