#include <dirent.h>
#include <fcntl.h>
#include <fnmatch.h>
#include <glob.h>
#include <grp.h>
#include <netdb.h>
#include <pwd.h>
#include <regex.h>
#include <tar.h>
#include <termios.h>
#include <unistd.h>
#include <utime.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <netinet/tcp.h>
#include <sys/mman.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/times.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#if defined (__ANDROID__)
#elif defined (__linux) || defined (__linux__) || defined (linux)
#include <wordexp.h>
#endif


