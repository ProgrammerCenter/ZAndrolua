---自动导入一些必要的库---
require "import"import "android.app.*"import "android.os.*"import "android.widget.*"import "android.view.*"import "android.content.*"import "java.io.*"import "java.util.*"import "http"
----------------------
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "java.io.File"
import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.net.Uri"
import "android.graphics.Paint"
import "android.text.format.Formatter"
import "android.text.format.DateUtils"
import "android.text.style.RelativeSizeSpan"
import "android.text.SpannableString"
import "android.text.Spanned"
import "android.view.*"
layout={
  LinearLayout;
  orientation="vertical";
  layout_height="fill";
  layout_width="fill";
  {
    PullingLayout;
    id="pl";
    layout_height=0;
    PullDownEnabled=true;
    layout_weight=1;
    {
      ListView;
      id="lv";
      layout_width="fill";
      layout_height="fill";
    };
  };
  {
    LinearLayout;
    layout_width="fill";
    {
      Button;
      id="CopyBtn";
      layout_width=0;
      layout_weight=1;
      Text="复制";
      textColor="#ffff0000";
      background="ann.png";
    };
    {
      Button;
      id="CutBtn";
      layout_width=0;
      layout_weight=1;
      Text="剪切";
      textColor="#ffff0000";
      background="ann.png";
    };
    {
      Button;
      id="PasteBtn";
      layout_width=0;
      layout_weight=1;
      Text="粘贴";
      textColor="#ffff0000";
      background="ann.png";
    };
    {
      Button;
      id="DeleteBtn";
      layout_width=0;
      layout_weight=1;
      Text="删除";
      textColor="#ffff0000";
      background="ann.png";
    };
    {
      Button;
      id="NewBtn";
      layout_width=0;
      layout_weight=1;
      Text="新建";
      textColor="#ffff0000";
      background="ann.png";
    };
  };
};
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置md主题
activity.setContentView(loadlayout(layout))

onCreateOptionsMenu=function(menu)
  menu.add(0,1,1,"排序").setShowAsActionFlags(2)
  CB=CheckBox()
  CB.Text="显示隐藏文件"
  CB.onClick=function(v)
    ShowHidden=v.isChecked()
    ReOpen()
  end
  menu.add(0,2,0,"显示隐藏文件").setActionView(CB).setShowAsActionFlags(2)
end
onOptionsItemSelected=function(item)
  if item.Title=="排序" then
    SortMethodItem={"名称（升序）","名称（降序）","时间（升序）","时间（降序）"}
    SortMethodDlg=AlertDialog.Builder(this)
    .setSingleChoiceItems(SortMethodItem,SortMethod-1,{onClick=function(v,p)
        SortMethod=p+1
        print(SortMethodItem[SortMethod])
        ReOpen()
      end
    })
    SortMethodDlg.show()
  end
end

datalist={}
adapter=ArrayAdapter(this,android.R.layout.simple_list_item_multiple_choice,datalist)
lv.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE_MODAL)

function getSelectedItem()
  SelectedItem={}
  CheckItemIds=luajava.astable(lv.getCheckItemIds())
  for k,v in pairs(CheckItemIds) do
    table.insert(SelectedItem,FileList[v+1])
  end
  CheckedItemCount=lv.getCheckedItemCount()
end

lv.setMultiChoiceModeListener(ListView.MultiChoiceModeListener{
  onItemCheckedStateChanged=function(mode,position,id,checked)
    getSelectedItem()
  end,

  onCreateActionMode=function(mode,menu)
    mActionMode=mode
    mode.setTitle("选择")
    menu.add(0,1,0,"全选").setShowAsActionFlags(2)
    menu.add(0,2,1,"反选").setShowAsActionFlags(2)
    return true
  end,

  onPrepareActionMode=function(mode,menu)
    return true
  end,

  onActionItemClicked=function(mode,item)
    func[item.Title]()
    return true
  end,

  onDestroyActionMode=function(mode)
    SelectedItem={}
  end
})
lv.setAdapter(adapter)
lv.onItemClick=function(l,v,p,i)
  if FileList[p+1].isDirectory() then
    OpenDir(FileList[p+1].toString())
   else
    OpenFile(FileList[p+1].toString())
  end
end
func={
  ["全选"]=function()
    for n=0,lv.getCount()-1 do
      lv.setItemChecked(n,true)
    end
  end,
  ["反选"]=function()
    for n=0,lv.getCount()-1 do
      lv.setItemChecked(n,not(lv.isItemChecked(n)))
    end
  end,
}

function SortFile(mFileList)
  SortFunctions={
    --名称（升序）
    function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
    end,
    --"名称（降序）
    function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name>b.Name)
    end,
    --时间（升序）
    function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.lastModified()<b.lastModified())
    end,
    --时间（降序）
    function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.lastModified()>b.lastModified())
    end,
  }
  table.sort(mFileList,SortFunctions[SortMethod])
end
SortMethod=1

function OpenFile(path)
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match(".+%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName) or "*/*"
  print("打开",FileName.."\n".."文件类型="..Mime)
  if Mime then
    intent = Intent()
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    intent.setAction(Intent.ACTION_VIEW);
    intent.setDataAndType(Uri.fromFile(File(path)), Mime);
    activity.startActivity(intent)
    return true
   else
    return false
  end
end

function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale)
end
mPaint=Paint()
mPaint.setTextSize(dp2px(18))

function DealName(v)
  local name=v.Name
  local sizes=Formatter.formatFileSize(activity,v.length())
  local time=v.lastModified()
  time=DateUtils.getRelativeTimeSpanString(time,
  System.currentTimeMillis(),
  DateUtils.MINUTE_IN_MILLIS,
  DateUtils.FORMAT_SHOW_TIME|DateUtils.FORMAT_SHOW_DATE|DateUtils.FORMAT_ABBREV_ALL)
  local l=mPaint.breakText(name,0,utf8.len(name),true,0.75*activity.getWidth(),nil)
  if utf8.len(name)>l then
    name=utf8.sub(name,1,l//2).."..."..utf8.sub(name,-l//2,-1)
  end
  local s1=name.."\n"
  local s2=time
  if v.isFile() then
    s2=s2.."  | "..sizes
  end
  s=s1..s2
  local a,b=utf8.find(s,s2)
  --(a,b,utf8.len(s))
  spannableString=SpannableString(s)
  sizeSpan=RelativeSizeSpan(0.8)
  spannableString.setSpan(sizeSpan,a-1,b,Spanned.SPAN_INCLUSIVE_EXCLUSIVE)
  return spannableString
end

function OpenDir(dir)
  Dir=dir
  adapter.clear()
  FileList=luajava.astable(File(dir).listFiles())
  SortFile(FileList)
  mFileList={}
  for k,v in pairs(FileList) do
    if not(v.isHidden()) or ShowHidden then
      table.insert(mFileList,v)
    end
  end
  FileList=mFileList
  if #FileList==0 then
    print("空")
    CheckedItemCount=0
    SelectedItem={}
  end
  --print(CheckedItemCount)
  for k,v in pairs(FileList) do
    adapter.add(DealName(v))
  end
end

function ReOpen()
  if mActionMode then
    mActionMode.finish()
  end
  OpenDir(Dir)
end

pl.onRefresh=function(v)
  ReOpen()
  v.refreshFinish(0)
end

function onKeyDown(code,event)
  if code==4 then
    if Dir~=SDPath then
      OpenDir(File(Dir).getParent())
     else
      activity.finish()
    end
    return true
  end
end

function CopyTable(table1)
  local table2={}
  for k,v in pairs(table1) do
    table2[k]=v
  end
  return table2
end
TaskFileList={}
function getTaskFileListContent()
  local s=""
  for k,v in pairs(TaskFileList) do
    s=s.."\n"..v.toString()
  end
  return s
end

CopyBtn.onClick=function()
  if #SelectedItem~=0 then
    TaskFileList=CopyTable(SelectedItem)
    mActionMode.finish()
    TaskType="Copy"
    print("选择了"..getTaskFileListContent())
  end
end

CutBtn.onClick=function()
  if #SelectedItem~=0 then
    TaskFileList=CopyTable(SelectedItem)
    mActionMode.finish()
    TaskType="Cut"
    print("选择了"..getTaskFileListContent())
  end
end

PasteBtn.onClick=function()
  if TaskFileList and TaskType then
    if TaskType=="Copy" then
      for k,v in pairs(TaskFileList) do
        LuaUtil.copyDir(v,File(Dir,v.Name))
      end
      print("复制了"..getTaskFileListContent().."\n到"..Dir)
     elseif TaskType=="Cut"
      for k,v in pairs(TaskFileList) do
        os.execute("mv "..v.toString().." "..Dir.."/"..v.Name)
      end
      print("移动了"..getTaskFileListContent().."\n到"..Dir)
    end
    ReOpen()
    TaskFileList=nil
    TaskType=nil
  end
end

DeleteBtn.onClick=function()

  if #SelectedItem~=0 then
    TaskFileList=CopyTable(SelectedItem)
    mActionMode.finish()
    for k,v in pairs(TaskFileList) do
      LuaUtil.rmDir(v)
    end
    print("删除了"..getTaskFileListContent())
    TaskFileList=nil
    ReOpen()
  end
end

NewBtn.onClick=function()
  NewET=EditText(this)
  AlertDialog.Builder(this)
  .setTitle("新建")
  .setView(NewET)
  .setPositiveButton("文件",{onClick=function(v)
      if #(NewET.Text)~=0 then
        File(Dir,NewET.Text).createNewFile()
        print("新建文件",NewET.Text)
        ReOpen()
      end
    end
  })
  .setNeutralButton("文件夹",{onClick=function(v)
      if #(NewET.Text)~=0 then
        File(Dir,NewET.Text).mkdir()
        print("新建文件夹",NewET.Text)
        ReOpen()
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end

ShowHidden=false--true
SDPath=Environment.getExternalStorageDirectory().toString()
OpenDir(SDPath)