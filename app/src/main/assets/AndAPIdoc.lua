require "import"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.net.*"
import "android.content.*"
import "autotheme"
AndAPIdoc=[===[
@调用手机拨打电话API@
@import "android.net.Uri"
import "android.content.Intent"
uri = Uri.parse("tel:10010")
intent = Intent(Intent.ACTION_CALL, uri)
intent.setAction("android.intent.action.VIEW")
activity.startActivity(intent)@
@拨号@
@import "android.content.*"
import "android.net.*"
--导入包
uri = Uri.parse("tel:15800001234");-
intent = Intent(Intent.ACTION_CALL, uri);
intent.setAction("android.intent.action.VIEW");
activity.startActivity(intent);
--记得添加打电话权限@
@安装其他应用程序@
@import "android.content.Intent"
import "android.net.Uri"
intent = Intent(Intent.ACTION_VIEW)
安装包路径="/sdcard/a.apk"
intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive")
intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
activity.startActivity(intent)@
@搜索应用程序@
@import "android.content.Intent"
import "android.net.Uri"
intent = Intent("android.intent.action.VIEW")
intent .setData(Uri.parse( "market://details?id="..activity.getPackageName()))
this.startActivity(intent)@
@自带http模块@
@获取内容 get函数
Http.get(url,cookie,charset,header,callback)
url 网络请求的链接网址
cookie 使用的cookie，也就是服务器的身份识别信息
charset 内容编码
header 请求头
callback 请求完成后执行的函数

除了url和callback其他参数都不是必须的

回调函数接受四个参数值分别是
code 响应代码，2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错
content 内容，如果code是-1，则为出错信息
cookie 服务器返回的用户身份识别信息
header 服务器返回的头信息

向服务器发送数据 post函数
Http.post(url,data,cookie,charset,header,callback)
除了增加了一个data外，其他参数和get完全相同
data 向服务器发送的数据

下载文件 download函数
Http.download(url,path,cookie,header,callback)
参数中没有编码参数，其他同get，
path 文件保存路径

需要特别注意一点，只支持同时有127个网络请求，否则会出错


Http其实是对Http.HttpTask的封装，Http.HttpTask使用的更加通用和灵活的形式
参数格式如下
Http.HttpTask( url, String method, cookie, charset, header,  callback) 
所有参数都是必选，没有则传入nil

url 请求的网址
method 请求方法可以是get，post，put，delete等
cookie 身份验证信息
charset 内容编码
header 请求头
callback 回调函数

该函数返回的是一个HttpTask对象，
需要调用execute方法才可以执行，
t=Http.HttpTask(xxx)
t.execute{data}

注意调用的括号是花括号，内容可以是字符串或者byte数组，
使用这个形式可以自己封装异步上传函数@
@使用gif依赖库@
@import "gif"

--ImageView设置gif动态图
loadGif(id,file)
--或者
id.background=loadGif(file)

--如果不显示动态图请设置宽高@
@调用应用程序打开文件@
@function OpenFile(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  if Mime then
    intent = Intent();
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    intent.setAction(Intent.ACTION_VIEW);
    intent.setDataAndType(Uri.fromFile(File(path)), Mime);
    activity.startActivity(intent);
   else
    Toastc("找不到可以用来打开此文件的程序")
  end
end@
@获取手机存储空间信息@
@--获取手机内置剩余存储空间
function GetSurplusSpace()
  fs = StatFs(Environment.getDataDirectory().getPath())
  return Formatter.formatFileSize(activity, (fs.getAvailableBytes()))
end

--获取手机内置存储总空间
function GetTotalSpace()
  path = Environment.getExternalStorageDirectory()
  stat = StatFs(path.getPath())
  blockSize = stat.getBlockSize()
  totalBlocks = stat.getBlockCount()
  return Formatter.formatFileSize(activity, blockSize * totalBlocks)
end
---获取手机内部存储路径
Environment.getExternalStorageDirectory().toString()
@
@发送彩信@
@import "android.net.Uri"
import "android.content.Intent"
uri=Uri.parse("file:///sdcard/a.png") --图片路径
intent= Intent();
intent.setAction(Intent.ACTION_SEND);
intent.putExtra("address",mobile) --邮件地址
intent.putExtra("sms_body",content) --邮件内容
intent.putExtra(Intent.EXTRA_STREAM,uri)
intent.setType("image/icon.) --设置类型
this.startActivity(intent)@
@用文件管理器选择文件@
@
function ChooseFile()
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.net.URLDecoder"
  import "java.io.File"
  intent = Intent(Intent.ACTION_GET_CONTENT)
  intent.setType("*/");
  intent.addCategory(Intent.CATEGORY_OPENABLE)
  activity.startActivityForResult(intent,1);
  function onActivityResult(requestCode,resultCode,data)
    if resultCode == Activity.RESULT_OK then
      local str = data.getData().toString()
      local decodeStr = URLDecoder.decode(str,"UTF-8")
      print(decodeStr)
    end
  end
end
@
@文件操作@
@---创建新文件夹------
--使用File类
import "java.io.File"--导入File类
File(文件夹路径).mkdir()

--创建多级文件夹
File(文件夹路径).mkdirs()

--shell
os.execute('mkdir '..文件夹路径)
-------创建新文件---------------
--使用File类
import "java.io.File"--导入File类
File(文件路径).createNewFile()

--使用io库
io.open("/sdcard/aaaa", 'w')
-----追加更新文件----
io.open(文件路径,"a+"):write("更新的内容"):close()
----写入文件--------
io.open(文件路径,"w"):write("内容"):close()
-----读取文件------
io.open(文件路径):read("*a")
---写入文件(自动创建父文件夹)-------
function 写入文件(路径,内容)
  import "java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end
----删除文件或文件夹--
--使用File类
import "java.io.File"--导入File类
File(文件路径).delete()
--使用os方法
os.remove (filename)
---复制文件----
LuaUtil.copyDir(from,to)
---递归删除文件或文件夹----
--使用LuaUtil辅助库
LuaUtil.rmDir(路径)

--使用Shell
os.execute("rm -r "..路径)
---替换文件内字符串----
function 替换文件字符串(路径,要替换的字符串,替换成的字符串)
  if 路径 then
    路径=tostring(路径)
    内容=io.open(路径):read("*a")
    io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
   else
    return false
  end
end
-----获取文件列表----
import("java.io.File")
luajava.astable(File(文件夹路径).listFiles())
---获取文件名称---
import "java.io.File"--导入File类
File(路径).getName()
---获取文件大小---
function GetFileSize(path)
  import "java.io.File"
  import "android.text.format.Formatter"
  size=File(tostring(path)).length()
  Sizes=Formatter.formatFileSize(activity, size)
  return Sizes
end
---获取文件或文件夹最后修改时间----
function GetFilelastTime(path)
  f = File(path);
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time);
  return cal.getTime().toLocaleString()
end
---获取文件字节-----
import "java.io.File"--导入File类
File(路径).length()
---判断路径是不是文件夹----
import "java.io.File"--导入File类
File(路径).isDirectory()
--也可用来判断文件夹存不存在
---判断文件或文件夹是否存不存在----
import "java.io.File"--导入File类
File(路径).exists()
--使用io
function file_exists(path)
  local f=io.open(path,'r')
  if f~=nil then io.close(f) return true else return false end
end
--判断路径是不是系统隐藏文件--
import "java.io.File"--导入File类
File(路径).isHidden()
--替换文件内字符串---
function 替换文件字符串(路径,要替换的字符串,替换成的字符串)
  if 路径 then
    路径=tostring(路径)
    内容=io.open(路径):read("*a")
    io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
   else
    return false
  end
end
--按行读取文件-----
for c in io.lines(文件路径) do
  print(c)
end@
@图片图角@
@function GetRoundedCornerBitmap(bitmap,roundPx)
  import "android.graphics.PorterDuffXfermode"
  import "android.graphics.Paint"
  import "android.graphics.RectF"
  import "android.graphics.Bitmap"
  import "android.graphics.PorterDuff$Mode"
  import "android.graphics.Rect"
  import "android.graphics.Canvas"
  import "android.util.Config"
  width = bitmap.getWidth()
  output = Bitmap.createBitmap(width, width,Bitmap.Config.ARGB_8888)
  canvas = Canvas(output);
  color = 0xff424242;
  paint = Paint()
  rect = Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
  rectF = RectF(rect);
  paint.setAntiAlias(true);
  canvas.drawARGB(0, 0, 0, 0);
  paint.setColor(color);
  canvas.drawRoundRect(rectF, roundPx, roundPx, paint);
  paint.setXfermode(PorterDuffXfermode(Mode.SRC_IN));
  canvas.drawBitmap(bitmap, rect, rect, paint);
  return output;
end
import "android.graphics.drawable.BitmapDrawable"
圆角弧度=50
bitmap=loadbitmap(picturePath)
RoundPic=GetRoundedCornerBitmap(bitmap)@
@分享文件@
@function Sharing(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  intent = Intent()
  intent.setAction(Intent.ACTION_SEND)
  intent.setType(Mime)
  file = File(path)
  uri = Uri.fromFile(file)
  intent.putExtra(Intent.EXTRA_STREAM,uri)
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(Intent.createChooser(intent, "分享到:"))
end
Sharing(文件路径)
ChooseFile()@
@获取手机设备相关信息@
@
--手机设备相关信息在android.os.Build.BRAND()方法下所以需要
import"android.os.*"
--以下表元素(字段,Java的字段在lua中表现为表中元表)即为手机设备相关信息
Build.BOARD--获取设备基板名称
Build.BOOTLOADER--获取设备引导程序版本号
Build.BRAND--获取设备品牌
Build.CPU_ABI--获取设备指令集名称（CPU的类型）
Build.CPU_ABI2--获取第二个指令集名称
Build.DEVICE--获取设备驱动名称
Build.DISPLAY--获取设备显示的版本包（在系统设置中显示为版本号）和ID一样
Build.FINGERPRINT--设备的唯一标识。由设备的多个信息拼接合成
Build.HARDWARE--设备硬件名称，一般和基板名称一样（BOARD）
Build.HOST--设备主机地址
Build.ID--设备版本号
Build.MODEL--获取手机的型号 设备名称。如--SM-N9100（三星Note4）
Build.MANUFACTURER--获取设备制造商。如--samsung
android:os.Build.PRODUCT--产品的名称
android:os.Build.RADIO--无线电固件版本号，通常是不可用的 显示
unknownBuild.TAGS--设备标签。如release-keys或测试的test-keys
Build.TIME--时间
Build.TYPE--设备版本类型主要为”user” 或”eng”
Build.USER--设备用户名 基本上都为android-build
Build.VERSION.RELEASE--获取系统版本字符串
Build.VERSION.CODENAME--设备当前的系统开发代号，一般使用REL代替
Build.VERSION.INCREMENTAL--系统源代码控制值，一个数字或者git哈希值
Build.VERSION.SDK--系统的API级别，推荐使用下面的SDK_INT来查看
Build.VERSION.SDK_INT--系统的API级别，int数值类型
@
@分享文字@
@
--分享文字
text="分享的内容"
intent=Intent(Intent.ACTION_SEND);
intent.setType("text/plain");
intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
intent.putExtra(Intent.EXTRA_TEXT, text);
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
activity.startActivity(Intent.createChooser(intent,"分享到:"));@
@标题栏菜单按钮@
@tittle={"分享","帮助","皮肤","退出"}
function onCreateOptionsMenu(menu)
  for k,v in ipairs(tittle) do
    if tittle[v] then
      local m=menu.addSubMenu(v)
      for k,v in ipairs(tittle[v]) do
        m.add(v)
      end
     else
      local m=menu.add(v)
      m.setShowAsActionFlags(1)
    end
  end
end
function onMenuItemSelected(id,tittle)
  if y[tittle.getTitle()] then
    y[tittle.getTitle()]()
  end
end

y={}
y["帮助"]=function()
  --事件
end

--菜单
function onCreateOptionsMenu(menu)
  menu.add("打开").onMenuItemClick=function(a)

  end
  menu.add("新建").onMenuItemClick=function(a)

  end
end@
@调用安卓API将保存图片到本地@
@function SavePicture(name,bm)
  if bm then
    import "java.io.FileOutputStream"
    import "java.io.File"
    import "android.graphics.Bitmap"
    name=tostring(name)
    f = File(name)
    out = FileOutputStream(f)
    bm.compress(Bitmap.CompressFormat.PNG,90, out)
    out.flush()
    out.close()
    return true
   else
    return false
  end
end@
]===]
activity.setTitle("AndroidAPI")
activity.setTheme(autotheme())


list={}
for t,c in AndAPIdoc:gmatch("(%b@@)\n*(%b@@)") do
--print(t)
t=t:sub(2,-2)
c=c:sub(2,-2)
list[t]=c
list[#list+1]=t
end

function show(v)
local s=v.getText()
local c=list[s]
if c then
AndAPIdoc_dlg.setTitle(s)
AndAPIdoc_tv.setText(c)
AndAPIdoc_dlg.show()
--  local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String({c}))
-- listview.setAdapter(adapter)
end
end



listview=ListView(activity)
listview.setOnItemClickListener(AdapterView.OnItemClickListener{
onItemClick=function(parent, v, pos,id)
show(v)
end
})
local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(list))
listview.setAdapter(adapter)
activity.setContentView(listview)

AndAPIdoc_dlg=Dialog(activity,autotheme())
AndAPIdoc_sv=ScrollView(activity)
AndAPIdoc_tv=TextView(activity)
AndAPIdoc_tv.setTextSize(20)
AndAPIdoc_tv.TextIsSelectable=true
AndAPIdoc_sv.addView(AndAPIdoc_tv)
AndAPIdoc_dlg.setContentView(AndAPIdoc_sv)

func={}
func["捐赠"]=function()
intent = Intent();
intent.setAction("android.intent.action.VIEW");
content_url = Uri.parse("https://qr.alipay.com/apt7ujjb4jngmu3z9a");
intent.setData(content_url);
activity.startActivity(intent);
end
func["返回"]=function()
activity.finish()
end
func["AndroidAPI手册网站"]=function()
local url="https://www.apiref.com/android-zh"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end
items={"捐赠原软件作者(nirenr)","返回","AndroidAPI手册网站"}
function onCreateOptionsMenu(menu)
for k,v in ipairs(items) do
m=menu.add(v)
m.setShowAsActionFlags(1)
end
end

function onMenuItemSelected(id,item)
func[item.getTitle()]()
end




