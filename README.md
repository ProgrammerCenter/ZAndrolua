# ZAndroLua-
lua 5.3.3 for android pro Zenith

ZAndrolua基于AndroluAndrolua4.4.2
AndroLua是基于LuaJava开发的安卓平台轻量级脚本编程语言工具，既具有Lua简洁优雅的特质，又支持绝大部分安卓API，可以使你在手机上快速编写小型应用。
官方QQ群：236938279
http://jq.qq.com/?_wv=1027&k=dcofRr
百度贴吧：
http://c.tieba.baidu.com/mo/m?kw=androlua
项目地址：
http://sf.net/p/androlua
点击链接支持Androlua作者的工作，一块也可以哦：
https://qr.alipay.com/apt7ujjb4jngmu3z9a

本程序使用了以下开源项目部分代码

bson,crypt,md5
https://github.com/cloudwu/skynet

cjson
https://sourceforge.net/projects/cjson/

zlib
https://github.com/brimworks/lua-zlib

xml
https://github.com/chukong/quick-cocos2d-x

luv
https://github.com/luvit/luv
https://github.com/clibs/uv

zip
https://github.com/brimworks/lua-zip
https://github.com/julienr/libzip-android

luagl
http://luagl.sourceforge.net/

luasocket
https://github.com/diegonehab/luasocket

sensor
https://github.com/ddlee/AndroidLuaActivity

canvas
由落叶似秋开发

jni
由nirenr开发


与标准Lua5.3.1的不同
打开了部分兼容选项，module，unpack，bit32
添加string.gfind函数，用于递归返回匹配位置
增加tointeger函数，强制将数值转为整数
修改tonumber支持转换Java对象


本软件所申请权限皆用于动态测试项目，并无其他用处。
大部分权限皆可不授予，但是项目动态测试会出错。


参考链接
关于lua的语法和Android API请参考以下网页。
Lua官网：
http://www.lua.org
Android 中文API：
http://android.toolib.net/reference/packages.html

# 调用javaAPI例子
  创建java对象
  ```Lua
  object=Object()
  --Object varName=ClassName(Constructor argument list)
  --存储对象的变量名称=对象类的名称(对象类的构造方法参数列表)
  --ZAndrolua luajava库会自动处理类型并匹配对应java方法
  ```
  创建安卓控件对象，并设置为当前显示控件
  ```Lua
require "import"
--导入import模块
import "android.widget.TextView"
--用import导入TextView类
tv=TextView(activity)
--创建TextView对象，activity指的就是当前的activity对象
tv.Text="文本控件"
--设置文本
  activity.setContentView(tv)
  --调用当前activity的setContentView方法设置tv为当前显示控件对象
  ```
实现转换java Enumeration为用于Lua迭代的闭包
```Lua
Lua迭代的闭包=luajava.enum(实现Enumeration接口的Java对象)
```
转换为java Iterable接口为用于Lua迭代的闭包
```Lua
Lua迭代的闭包=luajava.each(java Iterable接口)
```
递归搜索文件实例
```Lua
function find(catalog,name)
  local n=0
  local t=os.clock()
  local ret={}
  require "import"
  import "java.io.File"
  import "java.lang.String"
  function FindFile(catalog,name)
    local name=tostring(name)
    local ls=catalog.listFiles() or File{}
    for 次数=0,#ls-1 do
      --local 目录=tostring(ls[次数])
      local f=ls[次数]
      if f.isDirectory() then--如果是文件夹则继续匹配
        FindFile(f,name)
       else--如果是文件则
        n=n+1
        if n%1000==0 then
          --print(n,os.clock()-t)
        end
        local nm=f.Name
        if string.find(nm,name) then
          --thread(insert,目录)
          table.insert(ret,nm)
          print(nm)
        end
      end
      luajava.clear(f)
    end
  end
  FindFile(catalog,name)
  print("ok",n,#ret)
end

import "java.io.File"

catalog=File("sdcard/")
name=".j?pn?g"
--task(find,catalog,name,print)
thread(find,catalog,name)
```
