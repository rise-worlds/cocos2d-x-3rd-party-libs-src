# minizip

MINIZIP_GITURL := git@github.com:nmoinvaz/minizip.git


$(TARBALLS)/libminizip-git.tar.xz:
	$(call download_git,$(MINIZIP_GITURL),1.2,244c3fef45b2325e5df283648acb873b086c39f1)

.sum-minizip: libminizip-git.tar.xz
	$(warning $@ not implemented)
	touch $@


minizip: libminizip-git.tar.xz .sum-minizip
	$(UNPACK)
	$(APPLY) $(SRC)/minizip/010-unzip-add-function-unzOpenBuffer.patch
	$(MOVE)

DEPS_minizip = zlib $(DEPS_zlib)

.minizip: minizip
	$(RECONF)
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) -DUSE_FILE32API" ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@
