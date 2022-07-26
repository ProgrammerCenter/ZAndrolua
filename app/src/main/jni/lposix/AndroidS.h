static int LASDKV(lua_State* L)
//获取运行环境的Android sdk版本
{
     // 1. 获取 SDK 版本号 , 存储于 C 字符串sdk_verison_str 中
           char sdk[128] = "0";
             // 获取版本号方法
              __system_property_get("ro.build.version.sdk", sdk);
            //将版本号转为 int 值
          int sdk_verison = atoi(sdk);
     lua_pushnumber(L,sdk_verison);
  return 1;
}
int static AOSV(lua_State* L)
{
		  char OSV[256] = "0";;
		  __system_property_get("ro.build.version.release", OSV);
		 lua_pushnumber(L,atoi(OSV));
		  return 1;
}
int static LCONA(lua_State* L)
{
	
char OSCNA[256] = "0";
char* OSCN=OSCNA;	 
__system_property_get("ro.build.version.codename", OSCN);
		
lua_pushstring(L,OSCN);
		
return 1;
}
int static AN(lua_State* L)
{
	
char OSCNA[256] = "0";
char* OSCN=OSCNA;	 
__system_property_get("ro.product.brand", OSCN);
		
lua_pushstring(L,OSCN);
		
return 1;
}

int static LACPUR(lua_State* L)
{
	
char OSCNA[256] = "0";
char* OSCN=OSCNA;	 
__system_property_get("ro.product.cpu.abi", OSCN);
		
lua_pushstring(L,OSCN);
		
return 1;
}
int lposix_android(lua_State* L)
{
		  lua_getglobal(L,"lposix");
		  
  static const luaL_Reg lposix_android_fun[]={
					{"ASDKV",LASDKV},
					{"AOSV",AOSV},
					{"AOSCN",LCONA},
					{"ACPB",AN},
					{"ACPUV",LACPUR},
					{NULL,NULL}
		  };
		  luaL_newlib(L,lposix_android_fun);
		  lua_setfield(L,1,"android");
		  return 1;
}
