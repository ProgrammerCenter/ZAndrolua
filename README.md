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
  
