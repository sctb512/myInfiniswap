cmd_/root/Infiniswap/infiniswap_bd/infiniswap.mod.o := gcc -Wp,-MD,/root/Infiniswap/infiniswap_bd/.infiniswap.mod.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.8/include -I/var/lib/dkms/mlnx-ofed-kernel/4.1/build/include -include /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.h  -I./arch/x86/include -Iarch/x86/include/generated/uapi -Iarch/x86/include/generated  -Iinclude -I./arch/x86/include/uapi -Iarch/x86/include/generated/uapi -I./include/uapi -Iinclude/generated/uapi -include ./include/linux/kconfig.h -Iubuntu/include  -D__KERNEL__ -fno-pie -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -fno-pie -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -maccumulate-outgoing-args -DCONFIG_X86_X32_ABI -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -DRETPOLINE -fno-delete-null-pointer-checks -Wno-maybe-uninitialized -O2 --param=allow-store-data-races=0 -DCC_HAVE_ASM_GOTO -Wframe-larger-than=1024 -fstack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -pg -mfentry -DCC_USING_FENTRY -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes  -D"KBUILD_STR(s)=$(pound)s" -D"KBUILD_BASENAME=KBUILD_STR(infiniswap.mod)"  -D"KBUILD_MODNAME=KBUILD_STR(infiniswap)" -DMODULE  -c -o /root/Infiniswap/infiniswap_bd/infiniswap.mod.o /root/Infiniswap/infiniswap_bd/infiniswap.mod.c

source_/root/Infiniswap/infiniswap_bd/infiniswap.mod.o := /root/Infiniswap/infiniswap_bd/infiniswap.mod.c

deps_/root/Infiniswap/infiniswap_bd/infiniswap.mod.o := \
    $(wildcard include/config/module/unload.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/../../compat/config.h \
  include/generated/uapi/linux/version.h \
  include/uapi/linux/if.h \
  include/uapi/linux/libc-compat.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/types.h \
  include/linux/types.h \
    $(wildcard include/config/have/uid16.h) \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  include/uapi/linux/types.h \
  arch/x86/include/uapi/asm/types.h \
  include/uapi/asm-generic/types.h \
  include/asm-generic/int-ll64.h \
  include/uapi/asm-generic/int-ll64.h \
  arch/x86/include/uapi/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/uapi/asm-generic/bitsperlong.h \
  include/uapi/linux/posix_types.h \
  include/linux/stddef.h \
  include/uapi/linux/stddef.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compiler.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
    $(wildcard include/config/gcov/kernel.h) \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  arch/x86/include/asm/posix_types.h \
    $(wildcard include/config/x86/32.h) \
  arch/x86/include/uapi/asm/posix_types_64.h \
  include/uapi/asm-generic/posix_types.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/socket.h \
  include/linux/socket.h \
    $(wildcard include/config/proc/fs.h) \
    $(wildcard include/config/compat.h) \
  arch/x86/include/uapi/asm/socket.h \
  include/uapi/asm-generic/socket.h \
  arch/x86/include/uapi/asm/sockios.h \
  include/uapi/asm-generic/sockios.h \
  include/uapi/linux/sockios.h \
  include/linux/uio.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/kernel.h \
  include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/panic/timeout.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /usr/lib/gcc/x86_64-linux-gnu/4.8/include/stdarg.h \
  include/linux/linkage.h \
  include/linux/stringify.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/export.h \
  include/linux/export.h \
    $(wildcard include/config/have/underscore/symbol/prefix.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \
  arch/x86/include/asm/linkage.h \
    $(wildcard include/config/x86/64.h) \
    $(wildcard include/config/x86/alignment/16.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/bitops.h \
  include/linux/bitops.h \
  arch/x86/include/asm/bitops.h \
    $(wildcard include/config/x86/cmov.h) \
  arch/x86/include/asm/alternative.h \
    $(wildcard include/config/smp.h) \
  arch/x86/include/asm/asm.h \
  arch/x86/include/asm/rmwcc.h \
  arch/x86/include/asm/barrier.h \
    $(wildcard include/config/x86/ppro/fence.h) \
  arch/x86/include/asm/nops.h \
    $(wildcard include/config/mk7.h) \
    $(wildcard include/config/x86/p6/nop.h) \
  include/asm-generic/barrier.h \
  include/asm-generic/bitops/find.h \
    $(wildcard include/config/generic/find/first/bit.h) \
  include/asm-generic/bitops/sched.h \
  arch/x86/include/asm/arch_hweight.h \
  arch/x86/include/asm/cpufeatures.h \
    $(wildcard include/config/page/table/isolation.h) \
  arch/x86/include/asm/required-features.h \
    $(wildcard include/config/x86/minimum/cpu/family.h) \
    $(wildcard include/config/math/emulation.h) \
    $(wildcard include/config/x86/pae.h) \
    $(wildcard include/config/x86/cmpxchg64.h) \
    $(wildcard include/config/x86/use/3dnow.h) \
    $(wildcard include/config/matom.h) \
    $(wildcard include/config/paravirt.h) \
  arch/x86/include/asm/disabled-features.h \
    $(wildcard include/config/x86/intel/mpx.h) \
    $(wildcard include/config/x86/intel/memory/protection/keys.h) \
  include/asm-generic/bitops/const_hweight.h \
  include/asm-generic/bitops/le.h \
  arch/x86/include/uapi/asm/byteorder.h \
  include/linux/byteorder/little_endian.h \
  include/uapi/linux/byteorder/little_endian.h \
  include/linux/swab.h \
  include/uapi/linux/swab.h \
  arch/x86/include/uapi/asm/swab.h \
  include/linux/byteorder/generic.h \
  include/asm-generic/bitops/ext2-atomic-setbit.h \
  include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  include/linux/typecheck.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/printk.h \
    $(wildcard include/config/printk.h) \
  include/linux/printk.h \
    $(wildcard include/config/message/loglevel/default.h) \
    $(wildcard include/config/early/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/init.h \
  include/linux/init.h \
    $(wildcard include/config/broken/rodata.h) \
    $(wildcard include/config/lto.h) \
  include/linux/kern_levels.h \
  include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  include/uapi/linux/kernel.h \
  include/uapi/linux/sysinfo.h \
  arch/x86/include/asm/cache.h \
    $(wildcard include/config/x86/l1/cache/shift.h) \
    $(wildcard include/config/x86/internode/cache/shift.h) \
    $(wildcard include/config/x86/vsmp.h) \
  include/linux/dynamic_debug.h \
  include/uapi/linux/uio.h \
  include/uapi/linux/socket.h \
  include/uapi/linux/hdlc/ioctl.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat_autoconf.h \
    $(wildcard include/config/compat/is///skb/tx/hash.h) \
    $(wildcard include/config/compat/iser/attr/is/visible.h) \
    $(wildcard include/config/compat/if/iscsi/scsi/req.h) \
    $(wildcard include/config/compat/scsi/target/unblock.h) \
    $(wildcard include/config/compat/eth/hw/addr/random.h) \
    $(wildcard include/config/compat/lro/enabled/ipoib.h) \
    $(wildcard include/config/compat/netdev/features.h) \
    $(wildcard include/config/compat/is/work/busy.h) \
    $(wildcard include/config/compat/is/maxrate.h) \
    $(wildcard include/config/compat/is/qcn.h) \
    $(wildcard include/config/compat/is/reinit/completion.h) \
    $(wildcard include/config/compat/netif/is/bond/master.h) \
    $(wildcard include/config/compat/netif/is/xps.h) \
    $(wildcard include/config/compat/netif/has/set/xps/queue.h) \
    $(wildcard include/config/compat/sock/has/queue.h) \
    $(wildcard include/config/compat/skb/has/frag/list.h) \
    $(wildcard include/config/compat/has/irq/affinity/hint.h) \
    $(wildcard include/config/compat/has/irq/affinity/notifier.h) \
    $(wildcard include/config/compat/netif/f/rxhash.h) \
    $(wildcard include/config/compat/is/linux/cpu/rmap.h) \
    $(wildcard include/config/compat/rcu.h) \
    $(wildcard include/config/compat/is/kstrtox.h) \
    $(wildcard include/config/compat/is/ip/tos2prio.h) \
    $(wildcard include/config/compat/is/bitop.h) \
    $(wildcard include/config/compat/dev/uc/mc/add/const.h) \
    $(wildcard include/config/compat/ndo/vf/mac/vlan.h) \
    $(wildcard include/config/compat/is/vf/info/spoofchk.h) \
    $(wildcard include/config/compat/is/vf/info/linkstate.h) \
    $(wildcard include/config/compat/is/pci/physfn.h) \
    $(wildcard include/config/compat/xprt/reserve/xprt/cong/2params.h) \
    $(wildcard include/config/compat/reserve/xprt/2params.h) \
    $(wildcard include/config/compat/xprt/alloc/4params.h) \
    $(wildcard include/config/compat/xprtrdma/needed.h) \
    $(wildcard include/config/compat/virtqueue/get/buf.h) \
    $(wildcard include/config/compat/virtqueue/kick.h) \
    $(wildcard include/config/compat/zc/request.h) \
    $(wildcard include/config/compat/gfp/t.h) \
    $(wildcard include/config/compat/is/bitmap.h) \
    $(wildcard include/config/compat/is/prio/tc/map.h) \
    $(wildcard include/config/is/rx/handler/result.h) \
    $(wildcard include/config/is/ndo/add/slave.h) \
    $(wildcard include/config/module/eeprom/ethtool.h) \
    $(wildcard include/config/timestamp/ethtool.h) \
    $(wildcard include/config/compat/indir/setting.h) \
    $(wildcard include/config/compat/en/sysfs.h) \
    $(wildcard include/config/compat/vxlan/enabled.h) \
    $(wildcard include/config/compat/vxlan/dynamic/port.h) \
    $(wildcard include/config/compat/ifla/vf/link/state/max.h) \
    $(wildcard include/config/compat/vlan/egress/visible.h) \
    $(wildcard include/config/compat/setnumtcs/int.h) \
    $(wildcard include/config/compat/fdb/api/exists.h) \
    $(wildcard include/config/compat/fdb/add/nlattr.h) \
    $(wildcard include/config/compat/fdb/del/nlattr.h) \
    $(wildcard include/config/compat/fdb/const/addr.h) \
    $(wildcard include/config/compat/fdb/u16/vid.h) \
    $(wildcard include/config/compat/select/queue/accel.h) \
    $(wildcard include/config/compat/select/queue/fallback.h) \
    $(wildcard include/config/compat/ptp/clock.h) \
    $(wildcard include/config/compat/ptp/n/pins.h) \
    $(wildcard include/config/compat/ptp/clock/register.h) \
    $(wildcard include/config/compat/this.h) \
    $(wildcard include/config/compat/is/vf/info/max/tx/rate.h) \
    $(wildcard include/config/compat/net/device/is/num/tc.h) \
    $(wildcard include/config/compat/is/filter/dev.h) \
    $(wildcard include/config/compat/is/int/setapp.h) \
    $(wildcard include/config/compat/is/enum/pcie/link/width.h) \
    $(wildcard include/config/compat/svc/xprt/ops/xpo/secure/port.h) \
    $(wildcard include/config/compat/is/irq/desc/get/irq/data.h) \
    $(wildcard include/config/compat/is/svc/xprt/class/xcl/ident.h) \
    $(wildcard include/config/compat/is/xprt/create/net.h) \
    $(wildcard include/config/compat/is/rpc/rqst/rq/xmit/bytes/sent.h) \
    $(wildcard include/config/compat/is/sunrpc/addr/h.h) \
    $(wildcard include/config/compat/is/inet/sock/inet/num.h) \
    $(wildcard include/config/compat/is/sock/sk/wq.h) \
    $(wildcard include/config/compat/is/netdev/dql.h) \
    $(wildcard include/config/compat/is/xmit/more.h) \
    $(wildcard include/config/compat/is/get/tunable.h) \
    $(wildcard include/config/compat/scsi/transfer/length.h) \
    $(wildcard include/config/compat/is/smp/mb//after/atomic.h) \
    $(wildcard include/config/compat/iscsit/wait/conn.h) \
    $(wildcard include/config/compat/iscsit/aborted/task.h) \
    $(wildcard include/config/compat/iscsit/get/sup/prot/ops.h) \
    $(wildcard include/config/compat/iscsit/priv/cmd.h) \
    $(wildcard include/config/compat/is/file/inode.h) \
    $(wildcard include/config/compat/is/this/cpu/ptr.h) \
    $(wildcard include/config/compat/is/const/pci/error/handlers.h) \
    $(wildcard include/config/compat/is/dcbnl/ops/const.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/module.h \
    $(wildcard include/config/dtrace.h) \
    $(wildcard include/config/ctf.h) \
    $(wildcard include/config/cc/stackprotector/strong.h) \
  include/linux/module.h \
    $(wildcard include/config/sysfs.h) \
    $(wildcard include/config/module/sig.h) \
    $(wildcard include/config/modules/tree/lookup.h) \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/kallsyms.h) \
    $(wildcard include/config/tracepoints.h) \
    $(wildcard include/config/event/tracing.h) \
    $(wildcard include/config/livepatch.h) \
    $(wildcard include/config/constructors.h) \
    $(wildcard include/config/debug/set/module/ronx.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/list.h \
  include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  include/uapi/linux/const.h \
  include/linux/stat.h \
  arch/x86/include/uapi/asm/stat.h \
  include/uapi/linux/stat.h \
  include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  include/linux/seqlock.h \
    $(wildcard include/config/debug/lock/alloc.h) \
  include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
    $(wildcard include/config/preempt.h) \
  include/linux/preempt.h \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/preempt/notifiers.h) \
  arch/x86/include/asm/preempt.h \
  arch/x86/include/asm/percpu.h \
    $(wildcard include/config/x86/64/smp.h) \
  include/asm-generic/percpu.h \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  include/linux/thread_info.h \
  include/linux/bug.h \
  arch/x86/include/asm/bug.h \
    $(wildcard include/config/debug/bugverbose.h) \
  include/asm-generic/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  arch/x86/include/asm/thread_info.h \
    $(wildcard include/config/vm86.h) \
    $(wildcard include/config/ia32/emulation.h) \
  arch/x86/include/asm/page.h \
  arch/x86/include/asm/page_types.h \
    $(wildcard include/config/physical/start.h) \
    $(wildcard include/config/physical/align.h) \
  arch/x86/include/asm/page_64_types.h \
    $(wildcard include/config/randomize/base.h) \
    $(wildcard include/config/randomize/base/max/offset.h) \
  arch/x86/include/asm/page_64.h \
    $(wildcard include/config/debug/virtual.h) \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/x86/vsyscall/emulation.h) \
  include/linux/range.h \
  include/asm-generic/memory_model.h \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/sparsemem.h) \
  include/linux/pfn.h \
  include/asm-generic/getorder.h \
  arch/x86/include/asm/cpufeature.h \
    $(wildcard include/config/x86/feature/names.h) \
    $(wildcard include/config/x86/fast/feature/tests.h) \
  arch/x86/include/asm/processor.h \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/x86/debugctlmsr.h) \
    $(wildcard include/config/xen.h) \
  arch/x86/include/asm/processor-flags.h \
  arch/x86/include/uapi/asm/processor-flags.h \
  arch/x86/include/asm/math_emu.h \
  arch/x86/include/asm/ptrace.h \
  arch/x86/include/asm/segment.h \
    $(wildcard include/config/x86/32/lazy/gs.h) \
  arch/x86/include/uapi/asm/ptrace.h \
  arch/x86/include/uapi/asm/ptrace-abi.h \
  arch/x86/include/asm/paravirt_types.h \
    $(wildcard include/config/x86/local/apic.h) \
    $(wildcard include/config/pgtable/levels.h) \
    $(wildcard include/config/queued/spinlocks.h) \
    $(wildcard include/config/paravirt/debug.h) \
  arch/x86/include/asm/desc_defs.h \
  arch/x86/include/asm/kmap_types.h \
    $(wildcard include/config/debug/highmem.h) \
  include/asm-generic/kmap_types.h \
  arch/x86/include/asm/pgtable_types.h \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/mem/soft/dirty.h) \
  arch/x86/include/asm/pgtable_64_types.h \
  arch/x86/include/asm/sparsemem.h \
  arch/x86/include/asm/nospec-branch.h \
    $(wildcard include/config/retpoline.h) \
  arch/x86/include/asm/alternative-asm.h \
  arch/x86/include/asm/msr-index.h \
    $(wildcard include/config/tdp/nominal.h) \
    $(wildcard include/config/tdp/level/1.h) \
    $(wildcard include/config/tdp/level/2.h) \
    $(wildcard include/config/tdp/control.h) \
    $(wildcard include/config/tdp/level1.h) \
    $(wildcard include/config/tdp/level2.h) \
  arch/x86/include/asm/spinlock_types.h \
    $(wildcard include/config/paravirt/spinlocks.h) \
  include/asm-generic/qrwlock_types.h \
  include/asm-generic/ptrace.h \
  arch/x86/include/uapi/asm/sigcontext.h \
  arch/x86/include/asm/current.h \
  arch/x86/include/asm/msr.h \
  arch/x86/include/asm/msr-index.h \
  arch/x86/include/uapi/asm/errno.h \
  include/uapi/asm-generic/errno.h \
  include/uapi/asm-generic/errno-base.h \
  arch/x86/include/asm/cpumask.h \
  include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
  include/linux/bitmap.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/string.h \
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  include/uapi/linux/string.h \
  arch/x86/include/asm/string.h \
  arch/x86/include/asm/string_64.h \
  arch/x86/include/uapi/asm/msr.h \
  include/uapi/linux/ioctl.h \
  arch/x86/include/uapi/asm/ioctl.h \
  include/asm-generic/ioctl.h \
  include/uapi/asm-generic/ioctl.h \
  arch/x86/include/asm/paravirt.h \
  arch/x86/include/asm/special_insns.h \
  arch/x86/include/asm/fpu/types.h \
  include/linux/personality.h \
  include/uapi/linux/personality.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/math64.h \
  include/linux/math64.h \
    $(wildcard include/config/arch/supports/int128.h) \
  arch/x86/include/asm/div64.h \
  include/asm-generic/div64.h \
  include/linux/err.h \
  include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  arch/x86/include/asm/irqflags.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/atomic.h \
  include/linux/atomic.h \
    $(wildcard include/config/generic/atomic64.h) \
  arch/x86/include/asm/atomic.h \
  arch/x86/include/asm/cmpxchg.h \
  arch/x86/include/asm/cmpxchg_64.h \
  arch/x86/include/asm/atomic64_64.h \
  include/asm-generic/atomic-long.h \
  include/linux/bottom_half.h \
  include/linux/spinlock_types.h \
  include/linux/lockdep.h \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/lock/stat.h) \
  include/linux/rwlock_types.h \
  arch/x86/include/asm/spinlock.h \
  include/linux/jump_label.h \
    $(wildcard include/config/jump/label.h) \
  arch/x86/include/asm/jump_label.h \
  arch/x86/include/asm/qrwlock.h \
  include/asm-generic/qrwlock.h \
  include/linux/rwlock.h \
  include/linux/spinlock_api_smp.h \
    $(wildcard include/config/inline/spin/lock.h) \
    $(wildcard include/config/inline/spin/lock/bh.h) \
    $(wildcard include/config/inline/spin/lock/irq.h) \
    $(wildcard include/config/inline/spin/lock/irqsave.h) \
    $(wildcard include/config/inline/spin/trylock.h) \
    $(wildcard include/config/inline/spin/trylock/bh.h) \
    $(wildcard include/config/uninline/spin/unlock.h) \
    $(wildcard include/config/inline/spin/unlock/bh.h) \
    $(wildcard include/config/inline/spin/unlock/irq.h) \
    $(wildcard include/config/inline/spin/unlock/irqrestore.h) \
  include/linux/rwlock_api_smp.h \
    $(wildcard include/config/inline/read/lock.h) \
    $(wildcard include/config/inline/write/lock.h) \
    $(wildcard include/config/inline/read/lock/bh.h) \
    $(wildcard include/config/inline/write/lock/bh.h) \
    $(wildcard include/config/inline/read/lock/irq.h) \
    $(wildcard include/config/inline/write/lock/irq.h) \
    $(wildcard include/config/inline/read/lock/irqsave.h) \
    $(wildcard include/config/inline/write/lock/irqsave.h) \
    $(wildcard include/config/inline/read/trylock.h) \
    $(wildcard include/config/inline/write/trylock.h) \
    $(wildcard include/config/inline/read/unlock.h) \
    $(wildcard include/config/inline/write/unlock.h) \
    $(wildcard include/config/inline/read/unlock/bh.h) \
    $(wildcard include/config/inline/write/unlock/bh.h) \
    $(wildcard include/config/inline/read/unlock/irq.h) \
    $(wildcard include/config/inline/write/unlock/irq.h) \
    $(wildcard include/config/inline/read/unlock/irqrestore.h) \
    $(wildcard include/config/inline/write/unlock/irqrestore.h) \
  include/linux/time64.h \
  include/uapi/linux/time.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/uidgid.h \
    $(wildcard include/config/uidgid/strict/type/checks.h) \
    $(wildcard include/config/user/ns.h) \
  include/linux/uidgid.h \
    $(wildcard include/config/multiuser.h) \
  include/linux/highuid.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/kmod.h \
    $(wildcard include/config/mlnx/block/request.h) \
  include/linux/kmod.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/gfp.h \
  include/linux/gfp.h \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/zone/device.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/deferred/struct/page/init.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/cma.h) \
  include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
  include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/memory/isolation.h) \
    $(wildcard include/config/memcg.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/page/extension.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/numa/balancing.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  include/linux/wait.h \
  include/uapi/linux/wait.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/numa.h \
  include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  include/linux/nodemask.h \
    $(wildcard include/config/movable/node.h) \
  include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  include/linux/page-flags-layout.h \
  include/generated/bounds.h \
  include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
    $(wildcard include/config/have/bootmem/info/node.h) \
  include/linux/notifier.h \
  include/linux/errno.h \
  include/uapi/linux/errno.h \
  include/linux/mutex.h \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/mutex/spin/on/owner.h) \
  include/linux/osq_lock.h \
  include/linux/rwsem.h \
    $(wildcard include/config/rwsem/spin/on/owner.h) \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  arch/x86/include/asm/rwsem.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/srcu.h \
  include/linux/srcu.h \
  include/linux/rcupdate.h \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/rcu/stall/common.h) \
    $(wildcard include/config/no/hz/full.h) \
    $(wildcard include/config/rcu/nocb/cpu.h) \
    $(wildcard include/config/tasks/rcu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/prove/rcu.h) \
    $(wildcard include/config/rcu/boost.h) \
    $(wildcard include/config/rcu/nocb/cpu/all.h) \
    $(wildcard include/config/no/hz/full/sysidle.h) \
  include/linux/completion.h \
  include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/debug/objects/free.h) \
  include/linux/ktime.h \
  include/linux/jiffies.h \
  include/linux/timex.h \
  include/uapi/linux/timex.h \
  include/uapi/linux/param.h \
  arch/x86/include/uapi/asm/param.h \
  include/asm-generic/param.h \
    $(wildcard include/config/hz.h) \
  include/uapi/asm-generic/param.h \
  arch/x86/include/asm/timex.h \
  arch/x86/include/asm/tsc.h \
    $(wildcard include/config/x86/tsc.h) \
  include/generated/timeconst.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/timekeeping.h \
  include/linux/timekeeping.h \
  include/linux/rcutree.h \
  include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
  include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
    $(wildcard include/config/no/hz/common.h) \
  include/linux/sysctl.h \
    $(wildcard include/config/sysctl.h) \
  include/linux/rbtree.h \
  include/uapi/linux/sysctl.h \
  arch/x86/include/asm/mmzone.h \
  arch/x86/include/asm/mmzone_64.h \
  arch/x86/include/asm/smp.h \
    $(wildcard include/config/x86/io/apic.h) \
    $(wildcard include/config/x86/32/smp.h) \
    $(wildcard include/config/debug/nmi/selftest.h) \
  arch/x86/include/asm/mpspec.h \
    $(wildcard include/config/eisa.h) \
    $(wildcard include/config/x86/mpparse.h) \
  arch/x86/include/asm/mpspec_def.h \
  arch/x86/include/asm/x86_init.h \
  arch/x86/include/uapi/asm/bootparam.h \
  include/linux/screen_info.h \
  include/uapi/linux/screen_info.h \
  include/linux/apm_bios.h \
  include/uapi/linux/apm_bios.h \
  include/linux/edd.h \
  include/uapi/linux/edd.h \
  arch/x86/include/asm/e820.h \
    $(wildcard include/config/efi.h) \
    $(wildcard include/config/hibernation.h) \
  arch/x86/include/uapi/asm/e820.h \
    $(wildcard include/config/x86/pmem/legacy.h) \
    $(wildcard include/config/intel/txt.h) \
  include/linux/ioport.h \
  arch/x86/include/asm/ist.h \
  arch/x86/include/uapi/asm/ist.h \
  include/video/edid.h \
    $(wildcard include/config/x86.h) \
  include/uapi/video/edid.h \
  arch/x86/include/asm/apicdef.h \
  arch/x86/include/asm/apic.h \
    $(wildcard include/config/x86/x2apic.h) \
  include/linux/pm.h \
    $(wildcard include/config/vt/console/sleep.h) \
    $(wildcard include/config/pm.h) \
    $(wildcard include/config/pm/clk.h) \
    $(wildcard include/config/pm/generic/domains.h) \
  arch/x86/include/asm/fixmap.h \
    $(wildcard include/config/paravirt/clock.h) \
    $(wildcard include/config/provide/ohci1394/dma/init.h) \
    $(wildcard include/config/pci/mmconfig.h) \
    $(wildcard include/config/x86/intel/mid.h) \
  arch/x86/include/asm/acpi.h \
    $(wildcard include/config/acpi/apei.h) \
    $(wildcard include/config/acpi.h) \
    $(wildcard include/config/acpi/numa.h) \
  include/acpi/pdc_intel.h \
  arch/x86/include/asm/numa.h \
    $(wildcard include/config/numa/emu.h) \
  arch/x86/include/asm/topology.h \
  include/asm-generic/topology.h \
  arch/x86/include/asm/mmu.h \
    $(wildcard include/config/modify/ldt/syscall.h) \
  arch/x86/include/asm/realmode.h \
    $(wildcard include/config/acpi/sleep.h) \
  arch/x86/include/asm/io.h \
    $(wildcard include/config/mtrr.h) \
    $(wildcard include/config/x86/pat.h) \
  arch/x86/include/generated/asm/early_ioremap.h \
  include/asm-generic/early_ioremap.h \
    $(wildcard include/config/generic/early/ioremap.h) \
  include/asm-generic/iomap.h \
    $(wildcard include/config/has/ioport/map.h) \
    $(wildcard include/config/pci.h) \
    $(wildcard include/config/generic/iomap.h) \
  include/asm-generic/pci_iomap.h \
    $(wildcard include/config/no/generic/pci/ioport/map.h) \
    $(wildcard include/config/generic/pci/iomap.h) \
  include/xen/xen.h \
    $(wildcard include/config/xen/dom0.h) \
    $(wildcard include/config/xen/pvh.h) \
  include/xen/interface/xen.h \
  arch/x86/include/asm/xen/interface.h \
  arch/x86/include/asm/xen/interface_64.h \
  arch/x86/include/asm/pvclock-abi.h \
  arch/x86/include/asm/xen/hypervisor.h \
  include/xen/features.h \
  include/xen/interface/features.h \
  arch/x86/include/asm/pvclock.h \
    $(wildcard include/config/kvm/guest.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/clocksource.h \
  include/linux/clocksource.h \
    $(wildcard include/config/arch/clocksource/data.h) \
    $(wildcard include/config/clocksource/watchdog.h) \
    $(wildcard include/config/clksrc/probe.h) \
  arch/x86/include/asm/clocksource.h \
  arch/x86/include/uapi/asm/vsyscall.h \
  include/asm-generic/fixmap.h \
  arch/x86/include/asm/hardirq.h \
    $(wildcard include/config/kvm/intel.h) \
    $(wildcard include/config/have/kvm.h) \
    $(wildcard include/config/x86/thermal/vector.h) \
    $(wildcard include/config/x86/mce/threshold.h) \
    $(wildcard include/config/x86/mce/amd.h) \
    $(wildcard include/config/hyperv.h) \
  arch/x86/include/asm/idle.h \
  arch/x86/include/asm/io_apic.h \
  arch/x86/include/asm/irq_vectors.h \
    $(wildcard include/config/pci/msi.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/topology.h \
  include/linux/topology.h \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
    $(wildcard include/config/sched/smt.h) \
  include/linux/smp.h \
    $(wildcard include/config/up/late/init.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/llist.h \
    $(wildcard include/config/suse/kernel.h) \
    $(wildcard include/config/compat/sles/11/2.h) \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  include/linux/llist.h \
  include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
  include/linux/elf.h \
  arch/x86/include/asm/elf.h \
    $(wildcard include/config/x86/x32/abi.h) \
  arch/x86/include/asm/user.h \
  arch/x86/include/asm/user_64.h \
  arch/x86/include/uapi/asm/auxvec.h \
  arch/x86/include/asm/vdso.h \
    $(wildcard include/config/x86/x32.h) \
  include/linux/mm_types.h \
    $(wildcard include/config/split/ptlock/cpus.h) \
    $(wildcard include/config/arch/enable/split/pmd/ptlock.h) \
    $(wildcard include/config/have/cmpxchg/double.h) \
    $(wildcard include/config/have/aligned/struct/page.h) \
    $(wildcard include/config/transparent/hugepage.h) \
    $(wildcard include/config/userfaultfd.h) \
    $(wildcard include/config/aio.h) \
    $(wildcard include/config/mmu/notifier.h) \
    $(wildcard include/config/arch/want/batched/unmap/tlb/flush.h) \
  include/linux/auxvec.h \
  include/uapi/linux/auxvec.h \
  include/linux/uprobes.h \
    $(wildcard include/config/uprobes.h) \
  arch/x86/include/asm/uprobes.h \
  include/uapi/linux/elf.h \
  include/uapi/linux/elf-em.h \
  include/linux/kobject.h \
    $(wildcard include/config/uevent/helper.h) \
    $(wildcard include/config/debug/kobject/release.h) \
  include/linux/sysfs.h \
  include/linux/kernfs.h \
    $(wildcard include/config/kernfs.h) \
  include/linux/idr.h \
  include/linux/kobject_ns.h \
  include/linux/kref.h \
  include/linux/moduleparam.h \
    $(wildcard include/config/alpha.h) \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/ppc64.h) \
  include/linux/rbtree_latch.h \
  arch/x86/include/asm/module.h \
    $(wildcard include/config/m486.h) \
    $(wildcard include/config/m586.h) \
    $(wildcard include/config/m586tsc.h) \
    $(wildcard include/config/m586mmx.h) \
    $(wildcard include/config/mcore2.h) \
    $(wildcard include/config/m686.h) \
    $(wildcard include/config/mpentiumii.h) \
    $(wildcard include/config/mpentiumiii.h) \
    $(wildcard include/config/mpentiumm.h) \
    $(wildcard include/config/mpentium4.h) \
    $(wildcard include/config/mk6.h) \
    $(wildcard include/config/mk8.h) \
    $(wildcard include/config/melan.h) \
    $(wildcard include/config/mcrusoe.h) \
    $(wildcard include/config/mefficeon.h) \
    $(wildcard include/config/mwinchipc6.h) \
    $(wildcard include/config/mwinchip3d.h) \
    $(wildcard include/config/mcyrixiii.h) \
    $(wildcard include/config/mviac3/2.h) \
    $(wildcard include/config/mviac7.h) \
    $(wildcard include/config/mgeodegx1.h) \
    $(wildcard include/config/mgeode/lx.h) \
  include/asm-generic/module.h \
    $(wildcard include/config/have/mod/arch/specific.h) \
    $(wildcard include/config/modules/use/elf/rel.h) \
    $(wildcard include/config/modules/use/elf/rela.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.30.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.31.h \
    $(wildcard include/config/mips.h) \
    $(wildcard include/config/parisc.h) \
    $(wildcard include/config/sparc.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.32.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.33.h \
    $(wildcard include/config/pccard.h) \
    $(wildcard include/config/compat/firmware/class.h) \
    $(wildcard include/config/fw/loader.h) \
    $(wildcard include/config/ppc.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.34.h \
    $(wildcard include/config/preempt/rt.h) \
    $(wildcard include/config/preempt/desktop.h) \
    $(wildcard include/config/pcmcia.h) \
    $(wildcard include/config/need/dma/map/state.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.35.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.36.h \
    $(wildcard include/config/compat/no/printk/needed.h) \
    $(wildcard include/config/lock/kernel.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.37.h \
    $(wildcard include/config/compat/is/eth/flag/txvlan.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.38.h \
    $(wildcard include/config/xps.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-2.6.39.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.0.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.1.h \
    $(wildcard include/config/arm.h) \
    $(wildcard include/config/arm64.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.2.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.3.h \
    $(wildcard include/config/bql.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.4.h \
    $(wildcard include/config/compat/dev/hw/addr/random.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.5.h \
    $(wildcard include/config/tca/codel/unspec.h) \
    $(wildcard include/config/tc/codel/xstats.h) \
    $(wildcard include/config/tca/fq/codel/unspec.h) \
    $(wildcard include/config/tca/fq/codel/xstats/qdisc.h) \
    $(wildcard include/config/tc/fq/codel/qd/stats.h) \
    $(wildcard include/config/tc/fq/codel/cl/stats.h) \
    $(wildcard include/config/tc/fq/codel/xstats.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.6.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.7.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.8.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.9.h \
    $(wildcard include/config/compat/netif/has/pick/tx.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.10.h \
  include/linux/random.h \
    $(wildcard include/config/arch/random.h) \
  include/linux/once.h \
  include/uapi/linux/random.h \
  include/linux/irqnr.h \
  include/uapi/linux/irqnr.h \
  arch/x86/include/asm/archrandom.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/netdev_features.h \
  include/linux/netdev_features.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.11.h \
    $(wildcard include/config/compat/scatterlist/sg/pcopy/to/buffer.h) \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.12.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.13.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.14.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.15.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.16.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-3.17.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-4.0.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-4.1.h \
  /var/lib/dkms/mlnx-ofed-kernel/4.1/build/include/linux/compat-4.10.h \
  include/linux/vermagic.h \
  include/generated/utsrelease.h \

/root/Infiniswap/infiniswap_bd/infiniswap.mod.o: $(deps_/root/Infiniswap/infiniswap_bd/infiniswap.mod.o)

$(deps_/root/Infiniswap/infiniswap_bd/infiniswap.mod.o):
