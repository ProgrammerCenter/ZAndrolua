---自动导入一些必要的库---
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "java.io.*"
import "java.util.*"
import "http"
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "apkapk"
import "android.graphics.Typeface"
import "java.io.File"
activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setTitle("Apk提取")
activity.ActionBar.hide()
activity.setContentView(loadlayout(apkapk))
if Build.VERSION.SDK_INT >= 23 then
  --状态栏颜色
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xFFFAFAFA);
  --状态栏暗亮色
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end
--LuaAdapter(Lua适配器)
--创建自定义项目视图
item=

{
  LinearLayout;
  layout_height="fill";
  layout_width="fill";
  orientation="horizontal";
  {
    ImageView;
    id="图";
    layout_height="60dp";
    layout_width="60dp";
    layout_marginLeft="20dp";
    layout_marginRight="20dp";
    padding="5dp";
  };
  {
    LinearLayout;
    layout_height="60dp";
    layout_width="-1";
    orientation="vertical";
    {
      TextView;
      id="字1";
      layout_height="30dp";
      layout_width="-1";
      gravity="bottom";
      singleLine="true";
      typeface=Typeface.DEFAULT_BOLD;
    };
    {
      TextView;
      id="字2";
      layout_height="30dp";
      layout_width="-1";
      gravity="top";
      singleLine="true";
    };
  };
};

appmessagealy=

{
  LinearLayout;
  layout_height="fill";
  layout_width="fill";
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="app名称";
    layout_marginTop="5sp";
    layout_width="80%w";


    layout_gravity="center",
  };
  {
    TextView;
    id="app版本";
    layout_marginTop="5sp";
    layout_width="80%w";


    layout_gravity="center",
  };
  {
    TextView;
    id="app最后更新时间";
    layout_marginTop="5sp";
    layout_width="80%w";


    layout_gravity="center",
  };
  {
    TextView;
    id="appPackageName";
    layout_marginTop="5sp";
    layout_width="80%w";


    layout_gravity="center",
  };
 {
    TextView;
    id="appdata";
    layout_marginTop="5sp";
    layout_width="80%w";


    layout_gravity="center",
  };
};

function GetAppInfo(包名)
  import "android.content.pm.PackageManager"
  local pm = activity.getPackageManager();
  local 图标 = pm.getApplicationInfo(tostring(包名),0)
  local 图标 = 图标.loadIcon(pm);
  local pkg = activity.getPackageManager().getPackageInfo(包名, 0);
  local 应用名称 = pkg.applicationInfo.loadLabel(activity.getPackageManager())
  local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName
  local 最后更新时间 = activity.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
  local cal = Calendar.getInstance();
  cal.setTimeInMillis(最后更新时间);
  local 最后更新时间 = cal.getTime().toLocaleString()
  return 包名,版本号,最后更新时间,图标,应用名称
end
--创建适配器
adp=LuaAdapter(activity,item)
--设置适配器
lv.Adapter=adp
--查询已安装的APP
function 查找()
  require "import"
  import "android.content.Intent"
  Thread.sleep(100)
  pm = activity.getPackageManager()
  intent = Intent(Intent.ACTION_MAIN, nil)
  intent.addCategory(Intent.CATEGORY_LAUNCHER)
  resolveInfos = pm.queryIntentActivities(intent, 0)
  if resolveInfos ~= nil and resolveInfos.size() > 0 then
    for i=0,resolveInfos.size()-1 do
      call("刷新",resolveInfos[i].activityInfo.applicationInfo.loadIcon(pm),resolveInfos[i].activityInfo.applicationInfo.loadLabel(pm),resolveInfos[i].activityInfo.packageName)
      Thread.sleep(100)
    end
  end
end

function 刷新(image,text1,text2)
  adp.add{图=image,字1=text1,字2=text2}
  adp.notifyDataSetChanged()
end
thread(查找)
apkds=activity.getSharedPreferences("xasetfil", Context.MODE_PRIVATE)
if(apkds.getString("Apkstoragepath",null)==nil)
  then
  BACKUP_PATH="/sdcard/Download/"
 else
  BACKUP_PATH=apkds.getString("Apkstoragepath","")
end
APK = ".apk"--后缀
if not File(BACKUP_PATH).exists() then
  File(BACKUP_PATH).mkdirs()
end

function 复制(name,path)
  dest = BACKUP_PATH..name..APK
  --path:app程序源文件路径 dest:新的存储路径 name:app名称
  thread(CopyRunnable,path,dest)
end

function getApk(packageName)
  --通过包名获取程序源文件路径
  appDir = activity.getPackageManager().getApplicationInfo(packageName, 0).sourceDir
  return appDir
end


--将程序源文件Copy到指定目录
function CopyRunnable(path,dest)
  require "import"
  import "java.io.*"
  fDest = File(dest)
  if fDest.exists() then
    fDest.delete()
  end
  fDest.createNewFile()
  input = FileInputStream(File(path))
  output = FileOutputStream(fDest)
  inC = input.getChannel()
  outC = output.getChannel()
  inC.transferTo(0, inC.size(), outC)
  inC.close()
  outC.close()
  call("提示框","提取apk成功，保存在"..dest)
end

import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
function 颜色字体(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(c),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end
function 安卓11警告弹窗(app信息)
  AlertDialog.Builder(this)
  .setMessage("由Android11权限变化，所以查看应用信息可能会出错")
  .setPositiveButton("确认",{onClick=function(v)
      应用信息框(app信息)
  end})
  .show()
  end
function 确认框()
  AlertDialog.Builder(this)
  .setTitle(颜色字体("Apk提取",0xFFFF0000))
  .setMessage(颜色字体("您确认要提取"..应用名.."的apk吗？",0xFF30A9DE))
  .setPositiveButton("确认",{onClick=function(v) 复制(应用名,getApk(包名)) end})
  .setNegativeButton("取消",nil)
  .show()
end
function 应用信息框(应用信息)
  local 包名,版本号,最后更新时间,图标,应用名称=GetAppInfo(应用信息)
AlertDialog.Builder(this)
  .setTitle("app信息")
  .setView(loadlayout(appmessagealy))
  .setNegativeButton("确认",nil)
  .show()
  app版本.setText(版本号)
  app名称.setText(应用名称)
  app最后更新时间.setText(最后更新时间)
  appPackageName.setText(包名)
  appdatas="/storage/emulated/0/Android/data/"..包名

  if(File(appdatas).isDirectory()==true)
      --判断应用在Android/data目录下文件夹存不存在。
    then
  appdata.setText(appdatas)
  --设置用于显示应用Android/data目录的控件显示应用Android/data目录。
  else
  appdata.setText("此Android APP目前未创建Android/data目录下的文件夹")
  ---设置应用没有在Android/data目录下存在文件夹时，显示应用Android/data目录文件夹的控件文本。
  end
end
function 选择框(str,app包名)

  AlertDialog.Builder(this)
  .setTitle("选项")
  .setMessage("请选择选项")
  .setPositiveButton("提取apk",{onClick=function(v)
      确认框(str)
  end})
  .setNeutralButton("查看应用信息",{onClick=function(v)
      if(Build.VERSION.SDK_INT >29) 
    then
    安卓11警告弹窗(app包名)
    else
      应用信息框(app包名)
      end
  end})
  .setNegativeButton("取消",nil)
  .show()
end
function 提示框(文字)
  AlertDialog.Builder(this)
  .setMessage(颜色字体(文字,0xFF30A9DE))
  .setPositiveButton("确认",{onClick=function(v) end})
  .show()
end

lv.onItemClick=function(l,v,p,i)
  应用名=v.Tag.字1.text
  包名=v.Tag.字2.text
  选择框(应用名,包名)
  return true
end


--会用的就用吧
