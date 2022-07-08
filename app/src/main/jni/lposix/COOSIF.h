/* Identify known platforms by name.  */
#if defined (__linux) || defined (__linux__) || defined (linux)
#define PLATFORM_ID "Linux"
#if defined (__ANDROID__)
#include <jni.h>
#include <string.h>
#include <aaudio/AAudio.h>
#include <sys/system_properties.h>
#define PLATFORM_ID "Android"
#else
#include<gnu/libc-version.h>
#endif
#elif defined (__CYGWIN__)
#define PLATFORM_ID "Cygwin"
#elif defined (__MINGW32__)
#define PLATFORM_ID "MinGW"
#elif defined (OSX)
#define PLATFORM_ID "MacOSX"
#elif defined (__APPLE__)
#define PLATFORM_ID "Darwin"
#elif defined (_WIN32) || defined (__WIN32__) || defined (WIN32)
#define PLATFORM_ID "Windows"
#endif
