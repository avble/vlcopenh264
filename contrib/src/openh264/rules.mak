# openh264 

OPENH264_VERSION := 1.5.0
OPENH264_URL := https://github.com/cisco/openh264/archive/v1.5.0.tar.gz 

ifdef GPL
PKGS += openh264 
endif

$(TARBALLS)/openh264-$(OPENH264_VERSION).tar.gz: 
	$(call download,$(OPENH264_URL))

.sum-openh264: openh264-$(OPENH264_VERSION).tar.gz

openh264: openh264-$(OPENH264_VERSION).tar.gz .sum-openh264
	$(UNPACK)
	$(MOVE)
	cp ../src/openh264/bootstrap $@
	cp ../src/openh264/Makefile $@

.openh264: openh264
	cd $< &&  ./bootstrap $(HOSTCONF) 
	cd $< && $(MAKE) OS=android NDKROOT=$(ANDROID_NDK) TARGET=$(ANDROID_ABI) install
	touch $@
