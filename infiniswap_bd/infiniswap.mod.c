#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x7377b0b2, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x6c3d54e4, __VMLINUX_SYMBOL_STR(fs_bio_set) },
	{ 0x2ecda6f9, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xd2b09ce5, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0xf9a482f9, __VMLINUX_SYMBOL_STR(msleep) },
	{ 0xb961104e, __VMLINUX_SYMBOL_STR(alloc_disk) },
	{ 0xd9e8c2ca, __VMLINUX_SYMBOL_STR(blk_cleanup_queue) },
	{ 0x841fdfa1, __VMLINUX_SYMBOL_STR(alloc_disk_node) },
	{ 0xda3e43d1, __VMLINUX_SYMBOL_STR(_raw_spin_unlock) },
	{ 0xb43a926b, __VMLINUX_SYMBOL_STR(backport_dependency_symbol) },
	{ 0x784213a6, __VMLINUX_SYMBOL_STR(pv_lock_ops) },
	{ 0x964fcf43, __VMLINUX_SYMBOL_STR(param_ops_int) },
	{ 0x754d539c, __VMLINUX_SYMBOL_STR(strlen) },
	{ 0x747bea72, __VMLINUX_SYMBOL_STR(ib_dealloc_pd) },
	{ 0x4898a15d, __VMLINUX_SYMBOL_STR(blk_queue_max_hw_sectors) },
	{ 0xc4f331c6, __VMLINUX_SYMBOL_STR(cpu_online_mask) },
	{ 0x79aa04a2, __VMLINUX_SYMBOL_STR(get_random_bytes) },
	{ 0xc98187fe, __VMLINUX_SYMBOL_STR(blk_mq_start_request) },
	{ 0x84368bed, __VMLINUX_SYMBOL_STR(__tracepoint_block_bio_remap) },
	{ 0x5245d7ad, __VMLINUX_SYMBOL_STR(ib_destroy_qp) },
	{ 0xdf566a59, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_r9) },
	{ 0x44b1d426, __VMLINUX_SYMBOL_STR(__dynamic_pr_debug) },
	{ 0x949b04cf, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x85df9b6c, __VMLINUX_SYMBOL_STR(strsep) },
	{ 0x7a2af7b4, __VMLINUX_SYMBOL_STR(cpu_number) },
	{ 0x75607057, __VMLINUX_SYMBOL_STR(kthread_create_on_node) },
	{ 0xb8a4bb19, __VMLINUX_SYMBOL_STR(lookup_bdev) },
	{ 0xe2d5255a, __VMLINUX_SYMBOL_STR(strcmp) },
	{ 0xf26e02c3, __VMLINUX_SYMBOL_STR(rdma_connect) },
	{ 0x229c511, __VMLINUX_SYMBOL_STR(blk_mq_init_queue) },
	{ 0xf432dd3d, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xfe7c4287, __VMLINUX_SYMBOL_STR(nr_cpu_ids) },
	{ 0x7e526bfa, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_r10) },
	{ 0xfb578fc5, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x43dbc89, __VMLINUX_SYMBOL_STR(blk_alloc_queue) },
	{ 0x8f64aa4, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irqrestore) },
	{ 0xb16bdecb, __VMLINUX_SYMBOL_STR(current_task) },
	{ 0x76545de5, __VMLINUX_SYMBOL_STR(ib_get_dma_mr) },
	{ 0xb1998c9c, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x20c55ae0, __VMLINUX_SYMBOL_STR(sscanf) },
	{ 0x6f5f225c, __VMLINUX_SYMBOL_STR(kthread_stop) },
	{ 0x8b2da6fe, __VMLINUX_SYMBOL_STR(del_gendisk) },
	{ 0x9da55a32, __VMLINUX_SYMBOL_STR(blk_mq_free_tag_set) },
	{ 0x4c9d28b0, __VMLINUX_SYMBOL_STR(phys_base) },
	{ 0xa1c76e0a, __VMLINUX_SYMBOL_STR(_cond_resched) },
	{ 0x2c252aea, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0xbee988a7, __VMLINUX_SYMBOL_STR(config_group_init_type_name) },
	{ 0x71a50dbc, __VMLINUX_SYMBOL_STR(register_blkdev) },
	{ 0x370f8884, __VMLINUX_SYMBOL_STR(generic_make_request) },
	{ 0x59626381, __VMLINUX_SYMBOL_STR(configfs_register_subsystem) },
	{ 0x79bb27a3, __VMLINUX_SYMBOL_STR(init_net) },
	{ 0xa7dfd363, __VMLINUX_SYMBOL_STR(rdma_create_id) },
	{ 0x2519a306, __VMLINUX_SYMBOL_STR(bio_endio) },
	{ 0x61d36a82, __VMLINUX_SYMBOL_STR(ib_destroy_cq) },
	{ 0x61651be, __VMLINUX_SYMBOL_STR(strcat) },
	{ 0xb5a459dc, __VMLINUX_SYMBOL_STR(unregister_blkdev) },
	{ 0x9581c401, __VMLINUX_SYMBOL_STR(rdma_create_qp) },
	{ 0x9e9792d2, __VMLINUX_SYMBOL_STR(rdma_resolve_route) },
	{ 0x78764f4e, __VMLINUX_SYMBOL_STR(pv_irq_ops) },
	{ 0xb601be4c, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_rdx) },
	{ 0xb1b3410d, __VMLINUX_SYMBOL_STR(blkdev_put) },
	{ 0x5e46f9f2, __VMLINUX_SYMBOL_STR(blk_queue_make_request) },
	{ 0xf5b621c7, __VMLINUX_SYMBOL_STR(blk_queue_physical_block_size) },
	{ 0xdb7305a1, __VMLINUX_SYMBOL_STR(__stack_chk_fail) },
	{ 0x1000e51, __VMLINUX_SYMBOL_STR(schedule) },
	{ 0xa202a8e5, __VMLINUX_SYMBOL_STR(kmalloc_order_trace) },
	{ 0xaccabc6a, __VMLINUX_SYMBOL_STR(in4_pton) },
	{ 0x3c3e8e19, __VMLINUX_SYMBOL_STR(put_disk) },
	{ 0x43261dca, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irq) },
	{ 0x2ea2c95c, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_rax) },
	{ 0xbfdcb43a, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_r11) },
	{ 0xa78b1427, __VMLINUX_SYMBOL_STR(wake_up_process) },
	{ 0xef2cef14, __VMLINUX_SYMBOL_STR(blk_mq_alloc_tag_set) },
	{ 0xf34911c1, __VMLINUX_SYMBOL_STR(configfs_unregister_subsystem) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
	{ 0x87b393c2, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0xd52bf1ce, __VMLINUX_SYMBOL_STR(_raw_spin_lock) },
	{ 0x1df89e48, __VMLINUX_SYMBOL_STR(bio_clone_bioset) },
	{ 0x9327f5ce, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irqsave) },
	{ 0xb7b92011, __VMLINUX_SYMBOL_STR(blk_mq_end_request) },
	{ 0x32aa2502, __VMLINUX_SYMBOL_STR(ib_dereg_mr) },
	{ 0xcf21d241, __VMLINUX_SYMBOL_STR(__wake_up) },
	{ 0xb3f7646e, __VMLINUX_SYMBOL_STR(kthread_should_stop) },
	{ 0x34f22f94, __VMLINUX_SYMBOL_STR(prepare_to_wait_event) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x69acdf38, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x98a5f450, __VMLINUX_SYMBOL_STR(add_disk) },
	{ 0xd3719d59, __VMLINUX_SYMBOL_STR(paravirt_ticketlocks_enabled) },
	{ 0xb93d3401, __VMLINUX_SYMBOL_STR(set_user_nice) },
	{ 0x391e37da, __VMLINUX_SYMBOL_STR(rdma_resolve_addr) },
	{ 0xfa66f77c, __VMLINUX_SYMBOL_STR(finish_wait) },
	{ 0x63c4d61f, __VMLINUX_SYMBOL_STR(__bitmap_weight) },
	{ 0x90619b90, __VMLINUX_SYMBOL_STR(__ib_alloc_pd) },
	{ 0x8fb21437, __VMLINUX_SYMBOL_STR(ib_create_cq) },
	{ 0x4b06d2e7, __VMLINUX_SYMBOL_STR(complete) },
	{ 0x28318305, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0xb3c2c29f, __VMLINUX_SYMBOL_STR(bdget) },
	{ 0x486578fc, __VMLINUX_SYMBOL_STR(blkdev_get) },
	{ 0xf8e1d141, __VMLINUX_SYMBOL_STR(blk_queue_logical_block_size) },
	{ 0x3768905b, __VMLINUX_SYMBOL_STR(config_group_init) },
	{ 0xe24ecd1d, __VMLINUX_SYMBOL_STR(blk_mq_map_queue) },
	{ 0x51a0783b, __VMLINUX_SYMBOL_STR(bdput) },
	{ 0x9f3c87ac, __VMLINUX_SYMBOL_STR(dma_ops) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=mlx_compat,ib_core,rdma_cm,configfs";


MODULE_INFO(srcversion, "ADE797C7F1172B29683AAB8");
