
/*需要被调用的C语言函数*/
#include "lenvset.h"
//编译控制以及测试开关头文件
#include "ctosd.h"
#include "posix_import.h"
#include "lposix_init.h"
/*static int dome(lua_State* L)
{
    //检查栈中的参数是否合法，1表示Lua调用时的第一个参数(从左到右)，依此类推。
    //如果Lua代码在调用时传递的参数不为number，该函数将报错并终止程序的执行。
    double op1 = luaL_checknumber(L,1);
    double op2 = luaL_checknumber(L,2);
    //将函数的结果压入栈中。如果有多个返回值，可以在这里多次压入栈中。
    lua_pushnumber(L,op1 + op2);
	
    //返回值用于提示该C函数的返回值数量，即压入栈中的返回值数量。
    return 1;
}*/


int luname(lua_State *L)
{
	struct utsname  unames;
	
	uname(&unames);
	
	lua_newtable(L);//创建一个表格，放在栈顶
	lua_pushstring(L, "sysname");//压入key
	lua_pushstring(L,unames.sysname);//压入value
	lua_settable(L,-3);//弹出key,value，并设置到table里面去
	lua_pushstring(L, "nodename");
	lua_pushstring(L,unames.nodename);
	lua_settable(L,-3);
	lua_pushstring(L, "release");
	lua_pushstring(L,unames.release);
	lua_settable(L,-3);
	lua_pushstring(L, "version");
	lua_pushstring(L,unames.version);
	lua_settable(L,-3);
	lua_pushstring(L, "machine");
	lua_pushstring(L,unames.machine);
	lua_settable(L,-3);
	  #if defined (__ANDROID__)
	  #else
	lua_pushstring(L, "__domainname");
	lua_pushstring(L,unames.__domainname);
	lua_settable(L,-3);
	  #endif
	
	return 1;//堆栈里现在就一个table.其他都被弹掉了。
}
 
 

static int laccess(lua_State* L)
{
	//等同posix标准定义的，access函数
  const char * ptna=luaL_checkstring(L,1);
  double modus =luaL_checknumber(L,2);
  lua_pushnumber(L,access(ptna,(int)modus));
	return 1;
}
static int lgetenv(lua_State* L)
{
	//等同posix标准定义的，getenv函数
    char * nmaes=luaL_checkstring(L,1);
	if (getenv(nmaes)==NULL)
	{
		bool  errorn=false;
		lua_pushboolean(L,errorn);
	    
	}
	else{
    lua_pushstring(L,getenv(nmaes));
    
   }
   return 1;
}

static int lputenv(lua_State* L)
{
	//等同posix标准定义的，putenv函数
    char * env_strs=luaL_checkstring(L,1);
    lua_pushnumber(L,putenv(env_strs));
  
    return 1;
}
static int lsetenv(lua_State* L)
{
	//等同posix标准定义 setenv函数
    char * name=luaL_checkstring(L,1);
	char * value=luaL_checkstring(L,2);
	int rewrite= luaL_checknumber(L,3);
	
    lua_pushnumber(L,setenv(name,value,rewrite));
  

    return 1;
}
static int lsysconf(lua_State* L)
{
	//等同posix标准定义的，sysconf函数
  int name =luaL_checknumber(L,1);
  lua_pushnumber(L,sysconf(name));
	return 1;
}
static int lsymlink(lua_State* L)
{
	//等同posix标准定义的，symlink函数
  const char * p1=luaL_checkstring(L,1);
  const char * p2 =luaL_checkstring(L,2);
  lua_pushnumber(L,symlink(p1,p2));
	return 1;
}
int luaopen_lposix(lua_State* L)
{

	
  static const luaL_Reg l[]={
	  {"putenv",lputenv},
	  {"setenv",lsetenv},
	  {"access",laccess},
	  {"symlink",lsymlink},
	  {"sysconf",lsysconf},
	  {"init",lposix_init},
	  {"uname",luname},
	  {NULL,NULL}};
	  
   
luaL_newlib(L,l);
	return 1;
}


