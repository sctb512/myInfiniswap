SHELL = /bin/sh
INSTALL = /usr/bin/install -c
mkdir_p = mkdir -p
build_dir = /lib/modules/$(shell uname -r)
VERSION = 0.1
OFED_CFLAGS = -I/var/lib/dkms/mlnx-ofed-kernel/4.1/build/include -include /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.h
KSYMVERS = /root/Infiniswap/infiniswap_bd/Module.symvers /var/lib/dkms/mlnx-ofed-kernel/4.1/build/Module.symvers
NOSTDINC_FLAGS += -I/var/lib/dkms/mlnx-ofed-kernel/4.1/build/include -include /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.h

ismoduledir = /lib/modules/$(shell uname -r)/extra/infiniswap
ismodule := infiniswap.ko
issrc := ./
nbdxadm := nbdxadm

all: all-spec

install: all
	$(mkdir_p) $(DESTDIR)$(ismoduledir)
	$(INSTALL) -m 644 $(issrc)/$(ismodule) $(DESTDIR)$(ismoduledir)/$(ismodule)
	-/sbin/depmod -a
	-\cp $(nbdxadm)/nbdxadm /usr/local/bin/

uninstall:
	rm -f $(DESTDIR)$(ismoduledir)/$(ismodule)
	-/sbin/depmod -a
	-rm -f /usr/local/bin/nbdxadm

clean:
	$(MAKE) -C $(build_dir)/build SUBDIRS=`pwd` clean

obj-m := infiniswap.o

infiniswap-objs := 	\
	is_configfs.o	\
	is_mq.o	\
	is_main.o

all-spec:
	$(MAKE) -C $(build_dir)/build SUBDIRS=`pwd` KBUILD_EXTRA_SYMBOLS="$(KSYMVERS)"  modules
