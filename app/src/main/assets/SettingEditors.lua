require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.File"
import "android.content.Context"
import "android.app.AlertDialog"
import "android.R$id"
import "lua/xalstd"
import "android.widget.Button"
import "android.widget.EditText"
import "android.graphics.drawable.GradientDrawable$Orientation"
import "android.content.Intent"
import "android.net.Uri"
import "java.net.URLDecoder"
import "java.io.File"
import "http"
 git_set_btn_onclick,luapths,luadirs,luapojcts=...
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
activity.setContentView("xagui/se")
filePerms.Text="获取root权限"
function ChooseFile()
  intent = Intent(Intent.ACTION_GET_CONTENT)
  intent.setType("*/*");
  local intentcots
  intent.addCategory(Intent.CATEGORY_OPENABLE)
  activity.startActivityForResult(intent,1);
  function onActivityResult(requestCode,resultCode,data)
    local str = data.getData().toString()
    local decodeStr = URLDecoder.decode(str,"UTF-8")
    --   print(decodeStr)
  end
end
InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入:";
  };
  {
    EditText;
    hint="请输入目录";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};
gitUserInformation={}
xaset=activity.getSharedPreferences("xasetfil", Context.MODE_PRIVATE)
sped = xaset.edit()
--xaLliblist_b=f1.list()
xaLliblist=luajava.astable(File("/data/user/0/"..activity.getPackageName().."/app_lua/").list())
xaLliblist_b={}
for i,v in ipairs(xaLliblist) do
  xaLliblist_b[i]=tostring(xaLliblist[i])
end
xase_get=function(setname)
  return xaset.getString(setname,null)
  end
xase_set=function(key,值)
  sped.putString(key,值)
    sped.commit()
  end
function onCreateOptionsMenu(menu)
  menu.add("恢复默认设置").onMenuItemClick=function(a)
    sped.putString("Apkstoragepath","/sdcard/Download/")
    --提交保存数据
    sped.commit()

    sped.putString("rootOpenfile","false")
    sped.commit()

    sped.putString("LFMIDsd","/sdcard")
    sped.commit()

    sped.putString("debugft","false")
    sped.commit()

  end
  menu.add("重新加载lua lib").onMenuItemClick=function(a)
    AlertDialog.Builder(this)
    .setTitle("注意事项")
    .setIcon(android.R.drawable.ic_dialog_info)
    .setMessage([[启动后将会覆盖掉用户自定义的与自带lua lib同名的lua文件，而且重新加载lua lib可能会消耗较长时间，而且必须重启后生效。]])
    .setNeutralButton("确认",function()
      LuaUtil.copyDir("/data/user/0/"..activity.getPackageName().."/files/lua/",
      "/data/user/0/"..activity.getPackageName().."/app_lua/" )
    end)
    .show()
  end
  menu.add("注意事项").onMenuItemClick=function(a)
    AlertDialog.Builder(this)
    .setTitle("注意事项")
    .setIcon(android.R.drawable.ic_dialog_info)
    .setMessage([[切勿胡乱输入字符，所有设置都必须重启后才能生效
    切勿在第1次运行项目之前就添加自带库，因为这样会出问题。切勿把项目的init.lua复制到/storage/emulated/0/等目录，
 
       或者在/storage/emulated/0/等目录存在init.lua否则软件会出错。
   
        因为本软件识别目录是否为工程目录的方法是判断当前目录下是否存在init.lua]])
    .setNeutralButton("确认",nil)
    .show()
  end
end
if(xaset.getString("Apkstoragepath",null)==nil)
  then
  --设置配置文件键值对
  sped.putString("Apkstoragepath","/sdcard/Download/")
  --提交保存配置文件键值对数据数据
  sped.commit()

  sped.putString("rootOpenfile","false")
  sped.commit()

  sped.putString("LFMIDsd","/sdcard")
  sped.commit()
  sped.putString("debugft","false")
  sped.commit()

end
filePerms.onClick=function()
  ftss=os.execute("su")
  if (ftss~=nil)
    print("root权限获取成功")
    else
    print("root权限获取失败")
    end
  end
btn9.onClick=function()
  AlertDialog.Builder(this)
  .setTitle("是否关闭或启动")
    .setPositiveButton("启动",function()
      File("/sdcard/AndroLua/xaplug").mkdir()
  if File("/storage/emulated/0/AndroLua/fonts/xaplugis").isDirectory()==false
  then
 File("/storage/emulated/0/AndroLua/fonts/xaplugis").mkdir()
end
end)
    .setNegativeButton("关闭",function()
      os.remove ("/storage/emulated/0/AndroLua/fonts/xaplugis")
    end)
  .show();
  end
btn6.onClick=function()
  -- print(xaLliblist[1])
  AlertDialog.Builder(this)
  .setTitle("已添加默认库")
  .setItems(xaLliblist_b,nil)
  .setNegativeButton("确定",nil)
  .show();
end

btn5.onClick=function()
  AlertDialog.Builder(this)
  .setTitle("从文件管理器选择还是设置路径")
  .setMessage("请选择从文件管理器或者路径添加自带库")
  .setPositiveButton("从文件管理器选择",function()
    print("功能正在开发中,请勿点击，因为此功能目前无效")
    ChooseFile()
  end)
  .setNegativeButton("从路径添加",function()
    AlertDialog.Builder(this)
    .setTitle("请输入目录")
    .setView(loadlayout(InputLayout))
    .setPositiveButton("将整个文件夹的内容添加到自带库",function()
      LuaUtil.copyDir(edit.text,"/data/user/0/"..activity.getPackageName().."/app_lua/") end)
    .setNegativeButton("单个文件添加",function()
      xalstd.CopyIcon_Nat(edit.text,"/data/user/0/"..activity.getPackageName().."/app_lua/")
    end)
    .setNeutralButton("取消",nil)
    .show();
  end)
   .setNeutralButton("取消",nil)
  .show();
end
btn8.onClick=function()
  Download_layout={
  LinearLayout;
  orientation="vertical";
  id="Download_father_layout",
  {
    TextView;
    id="linkhint",
    layout_marginTop="10dp";
    text="下载链接",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_gravity="center";
  };
  {
    EditText;
    id="linkedit",
    layout_width="80%w";
    layout_gravity="center"; 
  };
  {
    TextView;
    id="pathhint",
    text="库名称",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_marginTop="10dp";
    layout_gravity="center";
  };
  {
    EditText;
    id="pathedit",
    layout_width="80%w";
    layout_gravity="center";
  };
};

AlertDialog.Builder(this)
.setTitle("下载文件")
.setView(loadlayout(Download_layout))
.setPositiveButton("下载",{onClick=function(v)
    http.download(linkedit.text,"/data/user/0/"..activity.getPackageName().."/app_lua/"..
   pathedit.text )
  end})
.setNegativeButton("取消",nil)
.show()
  end
btn7.onClick=function(v)
  AlertDialog.Builder(this)
  .setTitle("是否确定")
  .setPositiveButton("确定",{onClick=function(v)
      LuaUtil.copyDir("/data/user/0/"..activity.getPackageName().."/files/lua/DefaultPlug-ins/",
      "/storage/emulated/0/AndroLua/plugin/")

  end})
  .setNegativeButton("取消",nil)
  .show()
end
btn4.onClick=function(v)
  AlertDialog.Builder(this)
  .setTitle("请输入目录")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("确定",{onClick=function(v)
      sped.putString("LFMIDsd",edit.Text)
      --提交保存配置文件键值对数据
      sped.commit()

  end})
  .setNegativeButton("取消",nil)
  .show()
  import "android.view.View$OnFocusChangeListener"
  edit.setOnFocusChangeListener(OnFocusChangeListener{
    onFocusChange=function(v,hasFocus)
      if hasFocus then
        Prompt.setTextColor(0xFD009688)
      end
  end})


end
sedit1.onClick=function(v)
  AlertDialog.Builder(this)
  .setTitle("请输入目录")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("确定",{onClick=function(v)
      sped.putString("Apkstoragepath",edit.Text)
      --提交保存数据
      sped.commit()

  end})
  .setNegativeButton("取消",nil)
  .show()
  import "android.view.View$OnFocusChangeListener"
  edit.setOnFocusChangeListener(OnFocusChangeListener{
    onFocusChange=function(v,hasFocus)
      if hasFocus then
        Prompt.setTextColor(0xFD009688)
      end
  end})


end
btn10.onClick=function(v)
  if git_set_btn_onclick
    git_set_btn_onclick(luapths,luadirs,luapojcts)
    else
    print("此功能开发中")
    end
  end
btn3.onClick=function(v)
  AlertDialog.Builder(this)
  .setTitle("设置是否开启调试面板")
  .setIcon(android.R.drawable.ic_dialog_info)
  .setMessage("注意！开启调试面板会严重影响ZAndrolua的运行性能,而且设置需要重启后才能生效")
  .setPositiveButton("开启",{onClick=function(v)
      sped.putString("debugft","true")
      sped.commit()

  end})
  .setNegativeButton("关闭",{onClick=function(v)
      sped.putString("debugft","false")
      sped.commit()

  end})
  .setNeutralButton("取消",nil)
  .show()
end
