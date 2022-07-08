

int lOSN(lua_State* L){	
#ifdef PLATFORM_ID
	//ESA扩展
	//获取操作系统名称,值为程序编译时目标平台名称
	char* COSNAME=PLATFORM_ID;
	lua_pushstring(L,COSNAME);
	return 1;
   #else
  
   lua_pushnil(L);
   return 1;
	#endif
	
}
static int CPUA (lua_State* L){
#if defined (__linux) || defined (__linux__) || defined (linux)
 struct utsname sysm;
	uname(&sysm);
	char * osmachine=sysm.machine;
	//等同posix标准定义的uname函数处理过的utsname结构体的machine成员值
    lua_pushstring(L,osmachine);
	return 1;
	#else
	
	lua_pushnil(L);
	
	return 1;
	#endif
	
	
}

