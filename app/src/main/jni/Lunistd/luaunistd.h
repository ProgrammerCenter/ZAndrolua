#ifndef LUA_UNISTD_H
#define LUA_UNISTD_H

#include <stdio.h>
#include <string.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <unistd.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C"{
#endif

#define _l lua_State
#define lcs(idx) luaL_checkstring(L, idx)
#define lci(idx) luaL_checkinteger(L, idx)
#define lpi(x) lua_pushinteger(L, x)
#define lps(x) lua_pushstring(L, x)
#define q return 1

struct Array{
    char** data;
    unsigned int len;
};

typedef struct Array Array;

int Access(lua_State*);
#ifdef __USE_GNU
int eUidAccess(lua_State*);
int eAccess(lua_State*);
#endif
#ifdef __USE_ATFILE
int Faccessat(lua_State*);
#endif

int LSeek(_l*);
int Close(_l*);

#ifdef __USE_MISC
int CloseFrom(_l*);
#endif

int Pipe(_l*);
#ifdef __USE_GNU
int Pipe2(_l*);
#endif

int Alarm(_l*);
int Sleep(_l*);

#if (defined __USE_XOPEN_EXTENDED && !defined __USE_XOPEN2K8) \
    || defined __USE_MISC
int UAlarm(_l*);
int USleep(_l*);
#endif

int Pause(_l*);
int Chown(_l*);

#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int FChown(_l*);
int LChown(_l*);
#endif

#ifdef __USE_ATFILE
int FChownat(_l*);
#endif

int Chdir(_l*);
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int FChdir(_l*);
#endif

int GetCwd(_l*);
#ifdef __USE_GNU
int Get_Current_dir_name(_l*);
#endif

#if (defined __USE_XOPEN_EXTENDED && !defined __USE_XOPEN2K8) \
    || defined __USE_MISC
int Getwd(_l*);
#endif

int Dup(_l*);
int Dup2(_l*);
#ifdef __USE_GNU
int Dup3(_l*);
#endif

int Execve(_l*);
#ifdef __USE_XOPEN2K8
int FExecve(_l*);
#endif
int Execv(_l*);
int Execvp(_l*);
#ifdef __USE_GNU
int Execvpe(_l*);
#endif

#if defined __USE_MISC || defined __USE_XOPEN
int Nice(_l*);
#endif

int Exit(_l*);

int PathConf(_l*);
int FPathConf(_l*);
int SysConf(_l*);
#ifdef __USE_POSIX2
int ConfStr(_l*);
#endif

int GetPid(_l*);
int GetPPid(_l*);
int GetPGrp(_l*);
int __GetPGid(_l*);
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int GetPGid(_l*);
#endif
int SetPGid(_l*);
#if defined __USE_MISC || defined __USE_XOPEN_EXTENDED
int SetPGrp(_l*);
#endif
int SetSid(_l*);
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int GetSid(_l*);
#endif
int GetUid(_l*);
int GetEUid(_l*);
int GetGid(_l*);
int GetEGid(_l*);
#ifdef __USE_GNU
int Group_Member(_l*);
#endif

static void printcharpp(Array);
static Array LuaTableToArr(_l* L, int start);
static void NewI(lua_State*, int, const char*);

int luaopen_luaunistd(lua_State*);

#ifdef __cplusplus
}
#endif

#endif
