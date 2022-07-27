  int  checkint(lua_State* L,int arg){
	int intnum=(int)luaL_checknumber(L,arg);
	int decimals=(luaL_checknumber(L,arg)-intnum)*10000;
	if(decimals==0)
	{
		return intnum;
	}
	else{
		luaL_argerror(L,arg," bad argument #1 ");
		return NULL;
		
	}
}
int isint(lua_State* L,int arg){
	if(lua_isnumber(L,arg)){
		int intnum=(int)luaL_checknumber(L,arg);
		int decimals=(luaL_checknumber(L,arg)-intnum)*10000;
		if(decimals==0){
			
			return 1;
		}
		else{
			
			return 0;
		}
	}
	else{
		return 0;
		
	}
}
