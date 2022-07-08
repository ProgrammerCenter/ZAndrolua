#include "luaunistd.h"
#include <lauxlib.h>
#include <lua.h>

#ifdef __cplusplus
extern "C"{
#endif

int Access(lua_State* L){
    const char* name=luaL_checkstring(L, 1);
    int type=luaL_checkinteger(L, 2);
    lua_pushinteger(L,access(name, type));
    return 1;
}

#ifdef __USE_GNU

int eUidAccess(lua_State* L){
    const char* name=luaL_checkstring(L, 1);
    int type=luaL_checkinteger(L, 2);
    lua_pushinteger(L,euidaccess(name, type));
    return 1;
}

int eAccess(lua_State* L){
    const char* name=luaL_checkstring(L, 1);
    int type=luaL_checkinteger(L, 2);
    lua_pushinteger(L,eaccess(name, type));
    return 1;
}
#endif

#ifdef __USE_ATFILE
int Faccessat(lua_State* L){
    int fd=luaL_checkinteger(L, 1);
    const char* file=luaL_checkstring(L, 2);
    int type=luaL_checkinteger(L, 3);
    int flag=luaL_checkinteger(L, 4);
    lua_pushinteger(L, faccessat(fd, file, type, flag));
    return 1;
}
#endif

/*int LSeek(_l* L){
    int fd=luaL_checkinteger(L, 1);
    __off64_t offset=luaL_checkinteger(L, 2);
    int whence=luaL_checkinteger(L, 3);
    lua_pushinteger(L, lseek(fd,offset,whence));
    return 1;
}*/

int Close(_l* L){
    int fd=luaL_checkinteger(L, 1);
    lua_pushinteger(L, close(fd));
    return 1;
}

#ifdef __USE_MISC
int CloseFrom(_l* L){
    int lowfd=luaL_checkinteger(L, 1);
    closefrom(lowfd);
    return 1;
}
#endif

int Pipe(_l* L){
    int PipeDes[2]={luaL_checkinteger(L, 1), luaL_checkinteger(L, 2)};
    lua_pushinteger(L, pipe(PipeDes));
    return 1;
}

#ifdef __USE_GNU
int Pipe2(_l* L){
    int PipeDes[2]={luaL_checkinteger(L, 1), luaL_checkinteger(L, 2)};
    int flags=luaL_checkinteger(L, 3);
    lua_pushinteger(L, pipe2(PipeDes, flags));
    return 1;pllgg
}
#endif

int Alarm(_l* L){
    unsigned int seconds=luaL_checkinteger(L, 1);
    lua_pushinteger(L, alarm(seconds));
    return 1;
}

int Sleep(_l* L){
    unsigned int seconds=luaL_checkinteger(L, 1);
    lua_pushinteger(L, sleep(seconds));
    return 1;
}

#if (defined __USE_XOPEN_EXTENDED && !defined __USE_XOPEN2K8) \
    || defined __USE_MISC
int USleep(_l* L){
    __useconds_t useconds=luaL_checkinteger(L, 1);
    lua_pushinteger(L, usleep(useconds));
    return 1;
}
int UAlarm(_l* L){
    __useconds_t value=luaL_checkinteger(L, 1);
    __useconds_t interval=luaL_checkinteger(L, 2);
    lua_pushinteger(L, ualarm(value, interval));
    return 1;
}
#endif

int Pause(_l* L){
    pause();
    return 1;
}

int Chown(_l* L){
    const char* file=luaL_checkstring(L, 1);
    __uid_t owner=luaL_checkinteger(L, 2);
    __gid_t group=luaL_checkinteger(L, 3);
    lua_pushinteger(L, chown(file, owner, group));
    return 1;
}

#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int FChown(_l* L){
    int fd=luaL_checkinteger(L, 1);
    __uid_t owner=luaL_checkinteger(L, 2);
    __gid_t group=luaL_checkinteger(L, 3);
    lua_pushinteger(L, fchown(fd, owner, group));
    return 1;
}
int LChown(_l* L){
    const char* file=luaL_checkstring(L, 1);
    __uid_t owner=luaL_checkinteger(L, 2);
    __gid_t group=luaL_checkinteger(L, 3);
    lua_pushinteger(L, lchown(file, owner, group));
    return 1;
}
#endif

#ifdef __USE_ATFILE
int FChownat(_l* L){
    int fd=lci(1);
    const char* file=lcs(2);
    __uid_t owner=lci(3);
    __gid_t group=lci(4);
    int flag=lci(5);
    lpi(fchownat(fd,file,owner,group,flag));
    return 1;
}
#endif

int Chdir(_l* L){
    const char* path=lcs(1);
    lpi(chdir(path));
    return 1;
}

#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int FChdir(_l* L){
    int fd=lci(1);
    lpi(fchdir(fd));
    return 1;
}
#endif

int GetCwd(_l* L){
    char buf[255]={0};
    size_t size=sizeof(buf);
    getcwd(buf, size);
    lps(buf);
    return 1;
}

#ifdef __USE_GNU
int Get_Current_dir_name(_l* L){
    const char* res=get_current_dir_name();
    lps(res);
    return 1;
}
#endif

#if (defined __USE_XOPEN_EXTENDED && !defined __USE_XOPEN2K8) \
    || defined __USE_MISC
int Getwd(_l* L){
    char buf[255]={0};
    getwd(buf);
    lps(buf);
    return 1;
}
#endif

int Dup(_l* L){
    int fd=lci(1);
    lpi(dup(fd));
    return 1;
}
int Dup2(_l* L){
    int fd=lci(1);
    int fd2=lci(2);
    lpi(dup2(fd, fd2));
    return 1;
}
#ifdef __USE_GNU
int Dup3(_l* L){
    int fd=lci(1);
    int fd2=lci(2);
    int fd3=lci(3);
    lci(dup3(fd,fd2,fd3));
    return 1;
}
#endif

int Execve(_l* L){
    const char* path=lcs(1);
    char** const args=LuaTableToArr(L, 2).data;
    char** const envp=LuaTableToArr(L, 3).data;
    lpi(execve(path, args, envp));
    return 1;
}
#ifdef __USE_XOPEN2K8
int FExecve(_l* L){
    int fd=lci(1);
    char** const args=LuaTableToArr(L, 2).data;
    char** const envp=LuaTableToArr(L, 3).data;
    lpi(fexecve(fd, args, envp));
    return 1;
}
#endif

int Execv(_l* L){
    const char* path=lcs(1);
    char** const args=LuaTableToArr(L, 2).data;
    lpi(execv(path, args));
    return 1;
}
int Execvp(_l* L){
    const char* file=lcs(1);
    char** const args=LuaTableToArr(L, 2).data;
    lpi(execvp(file, args));
    return 1;
}
#ifdef __USE_GNU
int Execvpe(_l* L){
    const char* file=lcs(1);
    char** const args=LuaTableToArr(L, 2).data;
    char** const envp=LuaTableToArr(L, 3).data;
    lpi(execvpe(file,args,envp));
    return 1;
}
#endif

#if defined __USE_MISC || defined __USE_XOPEN
int Nice(_l* L){
    int inc=lci(1);
    lpi(nice(inc));
    return 1;
}
#endif

int Exit(_l* L){
    _exit(lci(1));
    q;
}

int PathConf(_l* L){
    lpi(pathconf(lcs(1), lci(2)));
    q;
}
int FPathConf(_l* L){
    lpi(fpathconf(lci(1), lci(2)));q;
}
int SysConf(_l* L){
    lpi(sysconf(lci(1)));q;
}
#ifdef __USE_POSIX2
int ConfStr(_l* L){
    char buf[1024];
    confstr(lci(1),buf,1024);
    lps(buf);q;
}
#endif

int GetPid(_l* L){
    lpi(getpid());q;
}
int GetPPid(_l* L){
    lpi(getppid());q;
}
int GetPGrp(_l* L){
    lpi(getpgrp());q;
}
/*int __GetPGid(_l* L){
    lpi(__getpgid(lci(1)));q;
}*/
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int GetPGid(_l* L){
    lpi(getpgid(lci(1)));q;
}
#endif

int SetPGid(_l* L){
    lpi(setpgid(lci(1), lci(2)));q;
}
#if defined __USE_MISC || defined __USE_XOPEN_EXTENDED
int SetPGrp(_l* L){
    lpi(setpgrp());q;
}
#endif
int SetSid(_l* L){
    lpi(setsid());q;
}
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
int GetSid(_l* L){
    lpi(getsid(lci(1)));q;
}
#endif
int GetUid(_l* L){
    lpi(getuid());q;
}
int GetEUid(_l* L){
    lpi(geteuid());q;
}
int GetGid(_l* L){
    lpi(getgid());q;
}
int GetEGid(_l* L){
    lpi(getegid());q;
}
#ifdef __USE_GNU
int Group_Member(_l* L){
    lpi(group_member(lci(1)));q;
}
#endif

/*** Built-in ***/

static int testPrintcpp(_l* L){
    LuaTableToArr(L, 1);
    LuaTableToArr(L, 1);
    LuaTableToArr(L, 2);
    return 1;
}

static Array LuaTableToArr(_l* L, int start){
    int len=luaL_len(L, start);
    char** res=(char**)malloc(sizeof(char*)*8);
    char** temp={0};
    int resMaxLen=8;
    int resLen=0;
    const char* str={0};
    for(int i=0;i<len;i++){
        lua_rawgeti(L, start, i+1);
        str=lua_tostring(L, -1);
        if(resLen<resMaxLen){
            res[resLen]=(char*)malloc(sizeof(char)*strlen(str)+1);
            strcpy(res[resLen++], str);
        }else{
            temp=(char**)malloc(sizeof(char*)*(resMaxLen=resMaxLen+8));
            for(int j=0;j<resLen;j++){
                temp[j]=(char*)malloc(sizeof(char)*strlen(res[j])+1);
                strcpy(temp[j], res[j]);
            }
            free(res);
            res=temp;
            res[resLen]=(char*)malloc(sizeof(char)*strlen(str)+1);
            strcpy(res[resLen++], str);
        }
    }
    Array Result={res, len};
    //printcharpp(Result);
    return Result;
}

static void printcharpp(Array arr){
    for(int i=0;i<arr.len;i++){
        printf("%d| %s\n",i+1,arr.data[i]);
    }
}

static luaL_Reg unistd[]={
    {"access", Access},
#ifdef __USE_GNU
    {"euidacess", eUidAccess},
    {"eaccess", eAccess},
#endif
#ifdef __USE_ATFILE
    {"faccessat", Faccessat},
#endif
    {"lseek", LSeek},
    {"close", Close},
#ifdef __USE_MISC
    {"closefrom", CloseFrom},
#endif
    {"pipe", Pipe},
#ifdef __USE_GNU
    {"pipe2", Pipe2},
#endif
    {"alarm", Alarm},
    {"sleep", Sleep},
#if (defined __USE_XOPEN_EXTENDED && !defined __USE_XOPEN2K8) \
    || defined __USE_MISC
    {"ualarm", UAlarm},
    {"usleep", USleep},
#endif
    {"pause", Pause},
    {"chown", Chown},
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
    {"fchown", FChown},
    {"lchown", LChown},
#endif
#ifdef __USE_ATFILE
    {"fchownat", FChownat},
#endif
    {"chdir", Chdir},
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
    {"fchown", FChown},
#endif
    {"getcwd", GetCwd},
    {"execve", Execve},
#ifdef __USE_XOPEN2K8
    {"fexecve", FExecve},
#endif
    {"execv", Execv},
//    {"testprintcpp", testPrintcpp},
    {"execvp", Execvp},
#ifdef __USE_GNU
    {"execvpe", Execvpe},
#endif
#if defined __USE_MISC || defined __USE_XOPEN
    {"nice", Nice},
#endif
    {"_exit", Exit},
    {"pathconf", PathConf},
    {"fpathconf", FPathConf},
    {"sysconf", SysConf},
#ifdef __USE_POSIX2
    {"confstr", ConfStr},
#endif
    {"getpid", GetPid},
    {"getppid", GetPPid},
    {"getpgrp", GetPGrp},
    {"__getpgid", __GetPGid},
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
    {"getpgid", GetPGid},
#endif
    {"setpgid", SetPGid},
#if defined __USE_MISC || defined __USE_XOPEN_EXTENDED
    {"setpgrp", SetPGrp},
#endif
    {"setsid", SetSid},
#if defined __USE_XOPEN_EXTENDED || defined __USE_XOPEN2K8
    {"getsid", GetSid},
#endif
    {"getuid", GetUid},
    {"geteuid", GetEUid},
    {"getgid", GetGid},
    {"getegid", GetEGid},
#ifdef __USE_GNU
    {"group_member", Group_Member},
#endif
    {NULL, NULL}
};

static void NewI(lua_State* L, int Value, const char* Name){
    lua_pushinteger(L, Value);
    lua_setglobal(L, Name);
}

int luaopen_luaunistd(lua_State* L){
    NewI(L, R_OK, "R_OK");
    NewI(L, W_OK, "W_OK");
    NewI(L, X_OK, "X_OK");
    NewI(L, F_OK, "F_OK");
#ifdef _STDIO_H
    NewI(L, SEEK_SET, "SEEK_SET");
    NewI(L, SEEK_CUR, "SEEK_CUR");
    NewI(L, SEEK_END, "SEEK_END");
#ifdef __USE_GNU
    NewI(L, SEEK_DATA, "SEEK_DATA");
    NewI(L, SEEK_HOLE, "SEEK_HOLE");
#endif
#endif
#if defined __USE_MISC && !defined L_SET
    NewI(L, L_SET, "L_SET");
    NewI(L, L_INCR, "L_INCR");
    NewI(L, L_XTND, "L_XTND");
#endif
    luaL_newlib(L,unistd);
    return 1;
}

#ifdef __cplusplus
}
#endif

