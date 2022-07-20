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
``` Lua
Lua迭代的闭包=enum(实现Enumeration接口的Java对象)
``` Lua
转换为java Iterable接口为用于Lua迭代的闭包
``` Lua
each(java Iterable接口)
``` Lua
递归搜索文件实例
``` Lua
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
单文件文件管理器
``` Lua
require "import"
--import "android.app.*"
--import "android.os.*"
import "android.widget.*"
import "android.view.*"
--import "gif"
import "java.io.File" --文件系统
import "android.app.AlertDialog" --对话框
import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.net.Uri" --系统打开文件
import "com.androlua.LuaUtil" --辅助库 删除文件夹
import "android.text.format.Formatter" --格式化文件大小
import "android.content.*"
import "android.app.Dialog"
import "android.webkit.MimeTypeMap"
import "lua/xalstd"
function imagdiog(imagpth,Title)
  limags= {LinearLayout;
    {
      ImageView;--图片控件
      id="lmagviews";
      src=imagpth;
      layout_width="1100";--图片宽度
      layout_height='2000';--图片高度
    };
  }
  limagslayout=loadlayout(limags)
  local 图片对话框=Dialog(activity)--,R.Theme_AppLua_Dialog)--,R.style.BottomDialog)
  --设置弹窗布局
  图片对话框.setTitle(Title)
  图片对话框.setContentView(limagslayout)
  --设置对话框标题
  图片对话框.getWindow().getAttributes().width=1000
  图片对话框.getWindow().getAttributes().height=2000
  图片对话框.show()
end
layout={
  LinearLayout;
  orientation="vertical";
  layout_width="fill";
  layout_height="fill";
  {
    TextView;
    id="path_TextView";
    text="path: /sdcard";
  };
  {
    LinearLayout;
    {
      Button;
      id="addFile_Button";
      text="+文件";
    };

    {
      Button;
      id="addDir_Button";
      text="+文件夹";
    };
  };
  {
    AbsoluteLayout;
    layout_height="-1";
    layout_width="-1";
    {
      LinearLayout;
      id="fileEdit_LinearLayout";
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      {
        LinearLayout;
        layout_width="-1";
        {
          Button;
          id="back_Button";
          text="<返回";
        };
        {
          Button;
          id="save_ucmfile";
          text="以ucm模式打开文件";
        };
        {
          Button;
          id="save_Button";
          text="保存";
        };

      };
      {
        Button;
        id="save_stringsx";
        text="替换文字";
      };
      {
        Button;
        id="save_filemessage";
        text="文件信息";
      };
      {
        EditText;
        id="file_EditText";
        layout_height="-1";
        layout_width="-1";
        gravity="start";
        backgroundColor="#fffae8";
      };
    };
    {
      ListView;
      id="dir_ListView";
      layout_height="-1";
      layout_width="-1";
    };

  };
};
Filemessage={
  LinearLayout;
  orientation="vertical";
  layout_width="fill";
  layout_height="fill";
  {
    TextView;
    id="path_TextView";
    text="path: /sdcard";
  }
}
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置md主题
activity.setTitle("文件管理")
activity.setContentView(loadlayout(layout))
Dsds=activity.getSharedPreferences("xasetfil", Context.MODE_PRIVATE)
Dsdedit=Dsds.edit()
if(Dsds.getString("LFMIDsd",null)==nil)
  then
  Dsd="/sdcard"
 else
  Dsd=Dsds.getString("LFMIDsd","")
end
local path = Dsd
local adp = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
dir_ListView.setAdapter(adp)
function update()
  path_TextView.text = "path: "..path
  if File(path).isDirectory() then --打开文件夹
    dir_ListView.setVisibility(View.VISIBLE)
    fileEdit_LinearLayout.setVisibility(View.GONE)

    adp.clear() --清空
    adp.add("../") --父文件夹
    local ls = File(path).listFiles()
    if ls then --不为空
      local fileList = luajava.astable( ls )
      table.sort(fileList, function(a,b) --排序
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
      for i,v in ipairs(fileList) do
        if v.isDirectory() then --文件夹
          adp.add(v.Name.."/")
         else
          local cal = Calendar.getInstance()
          local time = v.lastModified() --最后修改时间
          cal.setTimeInMillis(time)
          adp.add( v.Name.."\n\t\t\t"..Formatter.formatFileSize(activity, v.length()).."\t\t\t\t\t\t"..cal.getTime().toLocaleString() )
        end
      end
    end
   else --查看文件
    if (string.match(filnamexss,"%.png")~=nil)
      imagdiog(path,"图片查看器")
     elseif(string.match(filnamexss,"%.gif")~=nil)
      imagdiog(path,"图片查看器",true)
     else
      dir_ListView.setVisibility(View.GONE)
      fileEdit_LinearLayout.setVisibility(View.VISIBLE)
      local file = io.open(path, "r")
      file_EditText.text = file:read("*a")
      file:close(file)
    end
  end
end
update()
--系统打开文件
function openFile(path)
  local FileName = tostring(File(path).Name)
  local ExtensionName = FileName:match("%.(.+)")
  local Mime = MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  if Mime then
    intent = Intent()
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    intent.setAction(Intent.ACTION_VIEW);
    intent.setDataAndType(Uri.fromFile(File(path)), Mime);
    activity.startActivity(intent)
    return true
   else
    Toast.makeText(activity,"找不到可以用来打开此文件的程序",1).show();
    return false
  end
end
--列表点击事件
dir_ListView.onItemClick=function(l,v,p,s)
  local name = v.Text
  filnamexss= v.Text
  if string.sub(name, -1) == "/" then
    name = string.sub(name, 1, -2)
   else
    name = string.match(name, "(.-)\n")
  end
  if name == ".." then
    path = string.match(path, "(.*)/.+$")
   else
    path = path.."/"..name
  end
  update()
end
function onCreateOptionsMenu(menu)

  --菜单代码起始位置。
  menu.add("获取root权限").onMenuItemClick=function(v)
    rootfta=os.execute("su")
    if(rootfta==nil)
      then
      AlertDialog.Builder(this)
      .setTitle("获取root权限失败，或者已经获得root权限")
      .setIcon(android.R.drawable.ic_dialog_info)
      .setNeutralButton("确定", nil)
      .show()
     else
      AlertDialog.Builder(this)
      .setTitle("获取root权限成功")
      .setIcon(android.R.drawable.ic_dialog_info)
      .setNeutralButton("确定", nil)
      .show()
    end
  end
  menu.add("统计文件文本信息").onMenuItemClick=function(a)
    if(filetf==false)
      then
      print("请打开文件后点击菜单")
     else
    end
  end
  menu.add("向项目添加xa库").onMenuItemClick=function(a)


  end
end
--菜单代码末尾。
local pop = PopupMenu(activity, path_TextView) --弹出菜单
local menu = pop.Menu
--将文件以脚本模式运行。
menu.add("以运行命令脚本模式运行此文件").onMenuItemClick=function(v)
  --path = string.match(path, "(.*)/.+$")
  openFile(path)
  function exec(cmd,su)
    path = string.match(path, "(.*)/.+$")
    cmd=tostring(cmd)
    if cmd:find(".sh") then
      cmd=io.open(cmd):read("*a")
     else
      print("不是脚本文件，如要打开，请用其他应用打开。")
    end
    if su==0 then
      p=io.popen(string.format('%s',cmd))
     else
      p=io.popen(string.format('%s',"su -c "..cmd))
    end
    local s=p:read("*a")
    p:close()
    return s
  end
  exec(path,0)
end
menu.add("设置文件路径上一级路径为默认路径").onMenuItemClick=function(v)
  path = string.match(path, "(.*)/.+$")
  openFile(path)
  if(File(path).isDirectory()==true)
    then
    Dsdedit.putString("LFMIDsd",path)
    Dsdedit.commit()
   else
  end
end
menu.add("复制文件路径").onMenuItemClick=function(v)
  path = string.match(path, "(.*)/.+$")
  openFile(path)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(path)
end
--系统打开
menu.add("打开(系统)").onMenuItemClick=function(v)
  openFile(path)
  -- path = string.match(path, "(.*)/.+$")
  --[[[  if(path=="/Sdcard/Android/data/(.*)/.+$")
    then
      AlertDialog.Builder(this)
      .setTitle("注意")
      .setMessage("注意此文件为系统重要文件，在Android11中需要获取root权限才能打开")
      .setNeutralButton("确定", nil)
       .show()
      end]]
end
--删除文件/文件夹
menu.add("删除").onMenuItemClick=function(v)
  AlertDialog.Builder(this)
  .setTitle("真的要删除"..path.."吗？")
  .setMessage("（将无法恢复）")
  .setPositiveButton("删除",function()
    LuaUtil.rmDir(File(path))
    path = string.match(path, "(.*)/.+$")
    update()
    Toast.makeText(activity, "删除成功",Toast.LENGTH_SHORT).show()
  end
  )
  .setNeutralButton("取消",nil)
  .show()
end
--重命名/移动文件

menu.add("重命名/移动").onMenuItemClick=function(v)
  local editText = EditText(activity)

  AlertDialog.Builder(this)
  .setTitle("请输入")
  .setIcon(android.R.drawable.ic_dialog_info)
  .setView(editText)
  .setPositiveButton("确定", function()
    File(path).renameTo(
    File( string.match(path, "(.*)/.+$").."/"..editText.text )
    )
    Toast.makeText(activity, "移动成功",Toast.LENGTH_SHORT).show()
    path = string.match(path, "(.*)/.+$")
    update()
  end)
  .setNegativeButton("取消", nil)
  .show();
end

--列表项目长按
dir_ListView.onItemLongClick = function(l,v,p,s)
  local name = v.text
  if string.sub(name, -1) == "/" then
    name = string.sub(name, 1, -2)
   else
    name = string.match(name, "(.-)\n")
  end
  if name == ".." then
    path = string.match(path, "(.*)/.+$")
   else
    path = path.."/"..name
  end
  pop.show() --弹出菜单
end
--返回父文件夹
back_Button.onClick = function(v)
  path = string.match(path, "(.*)/.+$")
  update()
end
save_ucmfile.onClick=function(v)
  activity.newActivity("ucm",{path})
end
--保存文件
save_Button.onClick = function()
  local file = io.open(path, "w")
  file:write(file_EditText.text)
  file:close(file)
  Toast.makeText(activity, "保存成功",Toast.LENGTH_SHORT).show()
  path = string.match(path, "(.*)/.+$")
  update()
end
stringxgui={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,

  {
    EditText;
    hint="请输入替换文字";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="sxedit1";
  };
  {
    EditText;
    hint="请输入被替换文字";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="sxedit2";
  };
};
---文本替换。
save_filemessage.onClick=function ()
  fiesetMessagex= xalstd.text_Inputs(path)
  AlertDialog.Builder(this)
  .setTitle("标题")
  .setMessage("字符总长度:"..utf8.len(fiesetMessagex,1,-1))
  .setNeutralButton("确认",nil)
  .show()

end
save_stringsx.onClick = function()
  openFile(path)
  function 替换文件字符串(路径,要替换的字符串,替换成的字符串)
    path = string.match(path, "(.*)/.+$")
    if( string.match(路径, "(.*)/.+$")==nil)
      then
      return "noflie"
    end
    if 路径 then
      路径=tostring(路径)
      内容=io.open(路径):read("*a")
      if (string.match(内容,要替换的字符串))
        io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
        return 内容:gsub(要替换的字符串,替换成的字符串)
       else
        return false
      end
     else
      return false
    end
  end


  AlertDialog.Builder(this)
  .setTitle("字符替换")
  .setView(loadlayout(stringxgui))
  .setPositiveButton("确定",{onClick=function(v)
      varsssss=(替换文件字符串(path,sxedit2.Text,sxedit1.Text))
      if(varsssss)
        file_EditText.Text=varsssss
       else
        print("没有找到要替换文字")
      end
  end})
  .setNegativeButton("取消",nil)
  .show()

end
--新建文件
addFile_Button.onClick = function()
  local editText = EditText(activity)

  AlertDialog.Builder(this)
  .setTitle("请输入")
  .setIcon(android.R.drawable.ic_dialog_info)
  .setView(editText)
  --[[ .setNegativeButton("aly文件", function
    File(path.."/"..editText.text..".aly").mkdirs()
    update()
    end)]]
  --对话框中间控件。
  .setNegativeButton("LUA文件", function()
    File(path.."/"..editText.text..".Lua").mkdirs()
    update()
  end)
  --对话框最前控件。
  .setNeutralButton("确定", function()
    File(path.."/"..editText.text).createNewFile()
    update()
  end)
  --对话框最后控件。
  .setPositiveButton("取消", nil)
  .show();
end
--新建文件夹
addDir_Button.onClick = function()
  local editText = EditText(activity)
  AlertDialog.Builder(this)
  .setTitle("请输入")
  .setView(editText)
  .setIcon(android.R.drawable.ic_dialog_info)
  .setNegativeButton("确定", function()
    File(path.."/"..editText.text).mkdirs()
    update()
  end)
  .setNeutralButton("取消", nil)
  .show();
end
        


  
