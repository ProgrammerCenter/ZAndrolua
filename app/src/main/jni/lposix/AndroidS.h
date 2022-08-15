
int static lua__system_property_get(lua_State* L){
	char* AttributeName=luaL_checkstring(L,1);
	char AttributeValue[16384];
	__system_property_get(AttributeName,AttributeValue);
	
	if (strlen(AttributeValue)==0)
	{
		lua_pushnil(L);
		return 1;
	}
	else
	{
	lua_pushstring(L,AttributeValue);
	
	return 1;
	}
	
}
static int lgetpwuid_Android(lua_State *L){
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
static int lchroot_Android(lua_State *L){
lua_pushnumber(L,chroot(luaL_checkstring(L,1)));
return 1;
}
int lposix_android(lua_State* L)
{
		  lua_getglobal(L,"lposix");
		  
  static const luaL_Reg lposix_android_fun[]={
	          {"__system_property_get",lua__system_property_get},
	          {"getpwuid",lgetpwuid_Android},
		      {"chroot",lchroot_Android},
			  {NULL,NULL}
		  };
		  luaL_newlib(L,lposix_android_fun);
		  lua_setfield(L,1,"android");
		  return 1;
}
