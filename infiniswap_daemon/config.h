/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define to 1 if you have the <arpa/inet.h> header file. */
#define HAVE_ARPA_INET_H 1

/* Define to 1 if you have the <infiniband/verbs.h> header file. */
#define HAVE_INFINIBAND_VERBS_H 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `ibverbs' library (-libverbs). */
#define HAVE_LIBIBVERBS 1

/* Define to 1 if you have the `pthread' library (-lpthread). */
#define HAVE_LIBPTHREAD 1

/* Define to 1 if you have the `rdmacm' library (-lrdmacm). */
#define HAVE_LIBRDMACM 1

/* Define to 1 if your system has a GNU libc compatible `malloc' function, and
   to 0 otherwise. */
#define HAVE_MALLOC 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define to 1 if you have the <netdb.h> header file. */
#define HAVE_NETDB_H 1

/* Define to 1 if you have the <netinet/in.h> header file. */
#define HAVE_NETINET_IN_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Name of package */
#define PACKAGE "infiniswap-daemon"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "infiniswap@umich.edu"

/* Define to the full name of this package. */
#define PACKAGE_NAME "infiniswap daemon"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "infiniswap daemon 0.1"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "infiniswap-daemon"

/* Define to the home page for this package. */
#define PACKAGE_URL "https://github.com/SymbioticLab/infiniswap"

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.1"

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* the limit of hitting evict_threshold before triggering eviction
   (MEM_EVICT_HIT_THRESHOLD), default is 1 */
#define USER_EVICT_HIT_LIMIT 1

/* the limit of hitting expand_threshold before triggering expansion
   (MEM_EXPAND_HIT_THRESHOLD), default is 20 */
#define USER_EXPAND_HIT_LIMIT 20

/* how many block devices a single daemon can connect to, default is 32 */
#define USER_MAX_CLIENT 32

/* the maximum size (in GB) of remote memory this daemon can provide
   (MAX_FREE_MEM_GB, MAX_MR_SIZE_GB), default is 32 */
#define USER_MAX_REMOTE_MEMORY 32

/* the weight of measured free memory in the weighted moving average for
   current free memory calculation (CURR_FREE_MEM_WEIGHT), default is 0.7 */
#define USER_MEASURED_FREE_MEM_WEIGHT 0.7

/* the lower threshold of host free memory to evict remote memory chunks
   (FREE_MEM_EVICT_THRESHOLD), default is 8 */
#define USER_REMOTE_MEMORY_EVICT 8

/* the upper threshold of host free memory to expand remote memory chunks
   (FREE_MEM_EXPAND_THRESHOLD), default is 16 */
#define USER_REMOTE_MEMORY_EXPAND 16

/* Version number of package */
#define VERSION "0.1"

/* Define for Solaris 2.5.1 so the uint32_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
   #define below would cause a syntax error. */
/* #undef _UINT32_T */

/* Define for Solaris 2.5.1 so the uint64_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
   #define below would cause a syntax error. */
/* #undef _UINT64_T */

/* Define to rpl_malloc if the replacement function should be used. */
/* #undef malloc */

/* Define to the type of an unsigned integer type of width exactly 16 bits if
   such a type exists and the standard includes do not define it. */
/* #undef uint16_t */

/* Define to the type of an unsigned integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
/* #undef uint32_t */

/* Define to the type of an unsigned integer type of width exactly 64 bits if
   such a type exists and the standard includes do not define it. */
/* #undef uint64_t */
