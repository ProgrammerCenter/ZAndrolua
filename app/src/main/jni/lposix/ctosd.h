/* Identify known platforms by name.  */
#if defined (__linux) || defined (__linux__) || defined (linux)
#if defined (__ANDROID__)
#include <jni.h>
#include <string.h>
#include <aaudio/AAudio.h>
#include <sys/system_properties.h>
#define OS_Android
#else
#include<gnu/libc-version.h>
#define OS_Linux
#endif
#elif defined (__CYGWIN__)
#define OS_Cygwin
#elif defined (__MINGW32__)
#define OS_MinGW
#elif defined (__APPLE__)
#define OS_Darwin
#elif defined (_WIN32) || defined (__WIN32__) || defined (WIN32)
#if defined(_WIN64)
#define OS_Windows64 
#else 
#define OS_Windows32
#endif
#endif
