require "import"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.net.*"
import "android.content.*"
import "autotheme"
XAAPLIB=[===[

]===]
activity.setTitle("AndroidAPI")
activity.setTheme(autotheme())


list={}
for t,c in XAAPLIB:gmatch("(%b@@)\n*(%b@@)") do
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
XAAPLIB_dlg.setTitle(s)
XAAPLIB_tv.setText(c)
XAAPLIB_dlg.show()
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

XAAPLIB_dlg=Dialog(activity,autotheme())
XAAPLIB_sv=ScrollView(activity)
XAAPLIB_tv=TextView(activity)
XAAPLIB_tv.setTextSize(20)
XAAPLIB_tv.TextIsSelectable=true
XAAPLIB_sv.addView(XAAPLIB_tv)
XAAPLIB_dlg.setContentView(XAAPLIB_sv)

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




