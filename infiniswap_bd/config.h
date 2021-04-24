/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Have the kernel patch for lookup_bdev()
   https://www.redhat.com/archives/dm-devel/2016-April/msg00372.html */
#define HAVE_LOOKUP_BDEV_PATCH /**/

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "infiniswap@umich.edu"

/* Define to the full name of this package. */
#define PACKAGE_NAME "infiniswap block device"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "infiniswap block device 0.1"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "infiniswap-block-device"

/* Define to the home page for this package. */
#define PACKAGE_URL "https://github.com/SymbioticLab/infiniswap"

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.1"

/* the name of physical backup disk, default is "/dev/sda4" */
#define USER_BACKUP_DISK "/dev/vdb"

/* the max page number in a single bio request, default is 32 */
#define USER_BIO_PAGE_CAP 32

/* the max page number in a single struct request (swap IO request),
   MAX_SGL_LEN */
#define USER_MAX_PAGE_NUM 1

/* the max remote memory size from one server (MAX_MR_SIZE_GB), default is 32
   */
#define USER_MAX_REMOTE_MEMORY 32

/* the number of queried server in looking for remote memory
   (SERVER_SELECT_NUM), default is 1 */
#define USER_NUM_SERVER_SELECT 1

/* the name of stackbd disk */
#define USER_STACKBD_NAME "stackbd"

/* stackbd (backup) disk size */
#define USER_STACKBD_SIZE 12
