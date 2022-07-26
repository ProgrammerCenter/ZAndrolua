
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
int lposix_android(lua_State* L)
{
		  lua_getglobal(L,"lposix");
		  
  static const luaL_Reg lposix_android_fun[]={
	                {"__system_property_get",lua__system_property_get},
					{NULL,NULL}
		  };
		  luaL_newlib(L,lposix_android_fun);
		  lua_setfield(L,1,"android");
		  return 1;
}
