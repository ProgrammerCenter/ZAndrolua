require "import"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.net.*"
import "android.content.*"
import "autotheme"
ucmdoc=[===[
@注意事项(必看)@
@所有模组的json文件内容都必须包含在方框(数组)[]内，
game.atlas是重要的图标相关文件，因为UnCiv所使用游戏引擎限制，
所有图标都必须先通过设置.atlas文件文件来加载。
由于作者模组制作水平也有限,所以这还不是unciv模组制作的完整文档
@
@文件和文件目录含义@
@模组名称/Images/：图标存放目录
目录名称/Nations.json:模组定义文明的json文件目录
@
@文明模组json文件属性@
@
"name":"文明名称"
/*文明名称属性设置*/
"leaderName":"领袖名称", 
/*设置领袖名称*/
"adjective":["文明形容词"],
/*文明形容词*/
"startBias":["文明出生偏好地形"],
/*文明出生偏好地形，*/
"outerColor":[R,G,B],
/*文明选择界面，文明图标颜色(图标圆环除外)，
以RGB(红绿蓝3原色)形式表示，上述json数组中，R对应红、G
对应绿、B对应蓝*/
"innerColor":[R,G,B],
/*效果如以上所说的outerColor，只不过设置的是图标圆环的颜色*/
"startIntroPart1":"弹窗内容"
/*玩家选择文明进行游戏时，启动时，文明介绍弹窗内容。*/
"neutralHello":"内容",
/*玩家对其他文明中立时，其他文明的外交界面显示内容*/
"hateHello":"内容",
/*文明与其他文明的关系敌对时，其他文明的外交界面显示内容*/
"cities":["城市名称1","城市名称2"]
/*文明建立的城市名称，以上城市名称顺序和城市建成顺序一一对应*/
"defeated":"内容",
/*文明被其他文明打败时，其他文明的提示窗口显示内容*/
"declaringWar":"内容",
/*文明攻击其他文明时，其他文明的提示窗口显示内容*/
"uniqueName":"加成名称",
/*文明特殊加成名称*/
"uniques"["特殊加成(效果)1","特殊加成(效果)2"...]
/*文明特殊加成(效果)名称*/
@
]===]
activity.setTitle("帮助")
activity.setTheme(autotheme())


list={}
for t,c in ucmdoc:gmatch("(%b@@)\n*(%b@@)") do
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
ucmdoc_dlg.setTitle(s)
ucmdoc_tv.setText(c)
ucmdoc_dlg.show()
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

ucmdoc_dlg=Dialog(activity,autotheme())
ucmdoc_sv=ScrollView(activity)
ucmdoc_tv=TextView(activity)
ucmdoc_tv.setTextSize(20)
ucmdoc_tv.TextIsSelectable=true
ucmdoc_sv.addView(ucmdoc_tv)
ucmdoc_dlg.setContentView(ucmdoc_sv)

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




