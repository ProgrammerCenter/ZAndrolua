#include "ctosd.h"
#if defined(OS_Android)
#include "AndroidS.h"
#endif
#if defined(OS_Linux)
#include "LinuxS.h"
#endif
static int lposix_init(lua_State* L)
{
		  
		  
		  #if defined (__ANDROID__)
		  lposix_android(L);
		  #endif
		  #if defined(OS_Linux)
		  lposix_Linux(L);
		  #endif
		  
		 return 0;
}
