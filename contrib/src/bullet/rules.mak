# bullet

BULLET_GITURL := git@github.com:bulletphysics/bullet3.git

$(TARBALLS)/libbullet-git.tar.xz:
	$(call download_git,$(BULLET_GITURL),master,19f999a)

.sum-bullet: libbullet-git.tar.xz
	$(warning $@ not implemented)
	touch $@

bullet: libbullet-git.tar.xz .sum-bullet
	$(UNPACK)
	$(APPLY) $(SRC)/bullet/cocos2d.patch
	$(MOVE)

ifdef HAVE_TIZEN
EX_ECFLAGS = -fPIC
endif

ifdef HAVE_LINUX
EX_ECFLAGS = -fPIC
endif

.bullet: bullet toolchain.cmake
	cd $< && $(HOSTVARS) CXXFLAGS="$(CXXFLAGS) $(EX_ECFLAGS)" CFLAGS="$(CFLAGS) $(EX_ECFLAGS)" $(CMAKE) -DCMAKE_BUILD_TYPE=Release -DBUILD_CPU_DEMOS=OFF -DBUILD_EXTRAS=OFF -DBUILD_UNIT_TESTS=OFF -DBUILD_DEMOS=OFF -DBUILD_MULTITHREADING=ON
	cd $< && $(MAKE) VERBOSE=1 install
	touch $@
