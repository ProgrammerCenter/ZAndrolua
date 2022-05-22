require "import"
import "android.widget.*"
import "android.content.Context"
import "android.view.*"
import "android.view.WindowManager"
import "android.R$id"
import "java.io.File"
import "android.widget.TextView"
import "android.content.Context"
import "android.view.Gravity"
import "android.widget.LinearLayout"
import "android.app.AlertDialog"

xaplugControls={}
text_Inputs_xaplugControls=function(Filedirectory)
  local file = io.open(Filedirectory, "r")
  local Filetext = file:read("*a")
  file:close(file)
  return Filetext
end

xaplugControls.xaplugControl=function()
  xapluglist=luajava.astable(File("/storage/emulated/0/AndroLua/xaplug").list())
  xapluglist_b={}
  xapluglist_c={}
  for i,v in ipairs(xapluglist) do
    if(File("/storage/emulated/0/AndroLua/xaplug/"..tostring(xapluglist[i])).isDirectory()==true)

      if(File("/storage/emulated/0/AndroLua/xaplug/"..xapluglist[i].."/info.lua").isFile()==true)
        then
        infos=load(text_Inputs_xaplugControls("/storage/emulated/0/AndroLua/xaplug/"..tostring(xapluglist[i]).."/info.lua"))
        infos()
        xapluglist_b[i]=app_infos
        xapluglist_c[i]=xapluglist[i]
       else
        xapluglist_b[i]=tostring(xapluglist[i])
        xapluglist_c[i]=xapluglist[i]
      end
    end
  end
  local idsx={}
  local wm=activity.getSystemService(Context.WINDOW_SERVICE)
  local wp=WindowManager.LayoutParams()
  wp.width=150
  wp.height=150
  wp.x=1800
  wp.y=-150
  wp.gravity=Gravity.RIGHT| Gravity.CENTER
  wp.flags=WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE

  idsx.btn={}
  local btn=loadlayout({
    TextView;
    id='title';
    layout_height='40sp';
    layout_width='40sp';
    text="xa专属插件管理";
    textSize="12sp";
    textColor="0xFF009688";
    backgroundColor="#FFFFFF";
    gravity='center';
  },idsx.btn)

  idsx.btn.title.getPaint().setFakeBoldText(true)
  wm.addView(btn,wp)
  idsx.btn.title.getPaint().setFakeBoldText(true)
  idsx.btn.title.onClick=function ()
    单选列表=xapluglist_b
    function xaplugmenu_fun(MenuNames,MenuonClicks)
      
   xpalugmenu[MenuNames]=true
   if(MenuonClicks)
     menuobjs.add(MenuNames).onMenuItemClick=
     MenuonClicks
     else
     menuobjs.add(MenuNames)
     end
      end
    
    local 单选对话框=AlertDialog.Builder(this)
    .setTitle("xa专属类型插件列表")
    .setSingleChoiceItems(单选列表,-1,{onClick=function(v,p)
        function getdebugis()
          if(debugisvar==true)
            then
            return true
          end
          return false
        end
        function getpluglist()
          return xapluglist_b,xapluglist
        end
        Toast.makeText(activity,"启动"..xapluglist_b[p+1],1).show();
        Plug_inloading.pelf.plugfilename="/storage/emulated/0/AndroLua/xaplug/"..xapluglist_c[p+1]..
        "/mains.lua"
        plugExecutable=loadstring(text_Inputs_xaplugControls(Plug_inloading.pelf.plugfilename))
    
      plugExecutable()

    end})
    单选对话框.show();
  end
end
