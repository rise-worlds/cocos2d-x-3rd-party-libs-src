# OpenAL
OpenAL_VERSION := 1.23.1
OpenAL_URL := https://github.com/kcat/openal-soft/archive/refs/tags/$(OpenAL_VERSION).tar.gz
# OpenAL_VERSION := 1.20.1
# OpenAL_URL := https://github.com/kcat/openal-soft/archive/refs/tags/openal-soft-$(OpenAL_VERSION).tar.gz
# 36b1f70af321ff5acf75f99c9ad4239d4d1c4b2d35002831d3738b367488c8026ce4d49557ad55188457718661d8e81c638cc0acb135e5e952606c029312bac4  openal-soft-1.20.1.tar.gz

$(TARBALLS)/openal-soft-$(OpenAL_VERSION).tar.gz:
	$(call download,$(OpenAL_URL))

.sum-openal: openal-soft-$(OpenAL_VERSION).tar.gz


openal: openal-soft-$(OpenAL_VERSION).tar.gz .sum-openal
	$(UNPACK)
	$(MOVE)

DEPS_openal = 

.openal: openal
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) $(EX_ECFLAGS)"  cmake . -DLIBTYPE=STATIC -DALSOFT_EXAMPLES=OFF -DALSOFT_INSTALL_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=$(PREFIX)
	cd $< && $(MAKE) VERBOSE=1 install
	touch $@