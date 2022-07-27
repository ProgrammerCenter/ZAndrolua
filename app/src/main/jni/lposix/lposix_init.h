#include "ctosd.h"
#if defined(OS_Android)
#include "AndroidS.h"
#endif
#if defined(OS_Linux)
#include "LinuxS.h"
#endif
static void pushkv(lua_State* L,char*key,int value){
	
	lua_pushstring(L, key);

	lua_pushnumber(L,value);
	
	lua_settable(L,-3);
}
static int initMacroValue(lua_State* L){
	lua_getglobal(L,"lposix");
    pushkv(L,"F_OK",0);
	pushkv(L, "X_OK",1);
	pushkv(L, "W_OK",2);
	pushkv(L, "R_OK",2);
	pushkv(L, "STDIN_FILENO",0);
	pushkv(L, "STDOUT_FILENO",1);
	pushkv(L, "STDERR_FILENO",2);
	pushkv(L,"_PC_FILESIZEBITS",0);
    pushkv(L,"_PC_LINK_MAX",1);
    pushkv(L,"_PC_MAX_CANON",2);
    pushkv(L,"_PC_MAX_INPUT",3);
    pushkv(L,"_PC_NAME_MAX",4);
    pushkv(L,"_PC_PATH_MAX",5);
    pushkv(L,"_PC_PIPE_BUF",6);
    pushkv(L,"_PC_2_SYMLINKS",7);
    pushkv(L,"_PC_ALLOC_SIZE_MIN",8);
    pushkv(L,"_PC_REC_INCR_XFER_SIZE",9);
    pushkv(L,"_PC_REC_MAX_XFER_SIZE",10);
    pushkv(L,"_PC_REC_MIN_XFER_SIZE",11);
    pushkv(L,"_PC_REC_XFER_ALIGN",12);
    pushkv(L,"_PC_SYMLINK_MAX",13);
    pushkv(L,"_PC_CHOWN_RESTRICTED",14);
    pushkv(L,"_PC_NO_TRUNC",15);
    pushkv(L,"_PC_VDISABLE",16);
    pushkv(L,"_PC_ASYNC_IO",17);
    pushkv(L,"_PC_PRIO_IO",18);
    pushkv(L,"_PC_SYNC_IO",19);

	lua_settable(L,-1);
	return 0;
	
}
static int lposix_init(lua_State* L)
{
		  
		  
		  #if defined (__ANDROID__)
		  lposix_android(L);
		  #endif
		  #if defined(OS_Linux)
		  lposix_Linux(L);
		  #endif
		initMacroValue(L);
		 return 0;
}
