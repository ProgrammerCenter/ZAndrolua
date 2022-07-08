

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
