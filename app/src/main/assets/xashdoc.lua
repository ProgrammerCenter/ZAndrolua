require "import"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.net.*"
import "android.content.*"
import "autotheme"
xashdoc=[===[
@命令大全@
@
批量创建文件:
批量删除文件:
创建单个文件:
创建多个文件:
   下载文件:
   
@
@注意事项@
@xash命令中 a,b,c..这样形式的被称为操作参数，
xash并不会限制多余的操作参数输入。
但是xash将会忽略多余的操作参数。
xash并不会告诉您，您输入的参数的错误详细类型，
只会大概的告诉，对于网络类命令，错误的返回信息依照soket网络协议标准。
命令与上一个命令的结尾也就是;符号，之间不能有空格。@
]===]
activity.setTitle("AndroidAPI")
activity.setTheme(autotheme())


list={}
for t,c in xashdoc:gmatch("(%b@@)\n*(%b@@)") do
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
xashdoc_dlg.setTitle(s)
xashdoc_tv.setText(c)
xashdoc_dlg.show()
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

xashdoc_dlg=Dialog(activity,autotheme())
xashdoc_sv=ScrollView(activity)
xashdoc_tv=TextView(activity)
xashdoc_tv.setTextSize(20)
xashdoc_tv.TextIsSelectable=true
xashdoc_sv.addView(xashdoc_tv)
xashdoc_dlg.setContentView(xashdoc_sv)

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

items={"捐赠原软件作者(nirenr)","返回"}
function onCreateOptionsMenu(menu)
for k,v in ipairs(items) do
m=menu.add(v)
m.setShowAsActionFlags(1)
end
end

function onMenuItemSelected(id,item)
func[item.getTitle()]()
end




