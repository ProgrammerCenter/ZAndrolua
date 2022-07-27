
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
static int lchroot_Linux(lua_State *L){
lua_pushnumber(L,chroot(luaL_checkstring(L,1)));
return 1;
static int lgetpwuid_Linux(lua_State *L){
	int userid=checkint(L,1);
	 
	struct passwd  *passwds=getpwuid(userid);
	if (passwds==NULL)
	{
		
		lua_pushnil(L);
		return 1;
	
	}
	lua_newtable(L);//创建一个表格，放在栈顶
	lua_pushstring(L, "pw_name");//压入key
	lua_pushstring(L,passwds->pw_name);//压入value
	lua_settable(L,-3);//弹出key,value，并设置到table里面去
	lua_pushstring(L, "pw_passwd");
	lua_pushstring(L,passwds->pw_passwd);
	lua_settable(L,-3);
	lua_pushstring(L, "pw_uid");
	lua_pushnumber(L,passwds->pw_uid);
	lua_settable(L,-3);
	lua_pushstring(L, "pw_gid");
	lua_pushnumber(L,passwds->pw_gid);
	lua_settable(L,-3);
	lua_pushstring(L, "pw_gecos");
	lua_pushstring(L,passwds->pw_gecos);
	lua_settable(L,-3);
	lua_pushstring(L, "pw_dir");
	lua_pushstring(L,passwds->pw_dir);
	lua_settable(L,-3);
	lua_pushstring(L, "pw_shell");
	lua_pushstring(L,passwds->pw_shell);
	lua_settable(L,-3);
	return 1;
	
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
					{"chroot",lchroot_Linux},
					{"putchar",lputchar},
					{"abort",labort},
					{"getpwuid",lgetpwuid_Linux},
					{"perror",lperror},
					{NULL,NULL}
		  };
		  luaL_newlib(L,lposix_Linux_fun);
		  lua_setfield(L,1,"Linux");
		  return 1;
}

 

