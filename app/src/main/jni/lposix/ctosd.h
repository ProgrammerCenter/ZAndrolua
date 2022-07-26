/* Identify known platforms by name.  */
#if defined (__linux) || defined (__linux__) || defined (linux)
#define OS_Linux
#if defined (__ANDROID__)
#include <jni.h>
#include <string.h>
#include <aaudio/AAudio.h>
#include <sys/system_properties.h>
#define OS_Android
#undef OS_Linux
#else
#include<gnu/libc-version.h>
#endif
#elif defined (__CYGWIN__)
#define OS_Cygwin
#elif defined (__MINGW32__)
#define OS_MinGW
#elif defined (OSX)
#define OS_OSX
#elif defined (__APPLE__)
#define OS_Darwin
#elif defined (_WIN32) || defined (__WIN32__) || defined (WIN32)
#define OS_Windows
#endif
