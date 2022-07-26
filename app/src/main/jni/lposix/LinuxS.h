
#include  "posix_import.h"
static int lputchar(lua_State* L)
{
const char * putstr=luaL_checkstring(L,1);
putchar(putstr);
    return 0;
}
static int lperror(lua_State* L)
{
const char * attach_str=luaL_checkstring(L,1);
perror(attach_str);
    return 0;
}
static int labort(lua_State* L)
{
abort();
    return 0;
}


 static int lgnu_get_libc_version(lua_State* L){
		  
	const char* vseronx=gnu_get_libc_version();
		  lua_pushstring(L,vseronx);
		  return 1;
}

int lposix_Linux(lua_State* L)
{
		  lua_getglobal(L,"lposix");
		  
  static const luaL_Reg lposix_Linux_fun[]={
				
					{"gnu_get_libc_version",lgnu_get_libc_version},
					{"putchar",lputchar},
					{"abort",labort},
					{"perror",lperror},
					
					{NULL,NULL}
		  };
		  luaL_newlib(L,lposix_Linux_fun);
		  lua_setfield(L,1,"Linux");
		  return 1;
}

 

