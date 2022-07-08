#include "LinuxS.h"
#if defined (__ANDROID__)
#include "AndroidS.h"
#endif

static int OSBII(lua_State* L)
{
		  
		  
		  #if defined (__ANDROID__)
		  lposix_android(L);
		  #endif
		  
		 return 0;
}
