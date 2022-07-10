#include "LinuxS.h"
#if defined (__ANDROID__)
#include "AndroidS.h"
#endif
#if defined (__linux) || defined (__linux__) || defined (linux)
#if defined (__ANDROID__)
#else
#include "LinuxS.h"
#endif
#endif
static int OSBII(lua_State* L)
{
		  
		  
		  #if defined (__ANDROID__)
		  lposix_android(L);
		  #endif
		  
		  
		 return 0;
}
