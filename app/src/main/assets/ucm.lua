require "import"
  import "android.widget.*"
  import "android.view.*"
  import "cjson"
activity.setTitle('UCMIDE')
activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView("xagui/ucmaly")
sadrt={
TextView;
layout_height="200sp";
layout_width="fill";
textSize="18sp";
};

function main(...)
--...是newActivity传递过来的参数。
--[[因为使用了这个函数，所以在此页面，
  所有进入页面时会执行的代码都要放在此函数内]]
paths=...
file = io.open(paths, "r")
LEdit1.text = file:read("*a")
file:close(file)
arr={"Rain","Rain1","Rain2"};
arrayAdapter=LuaArrayAdapter(activity,sadrt, String(arr))
LEdit1.setAdapter(arrayAdapter)
LEdit1.Threshold=1--设置输入几个字符后才能出现提示
end
function onCreateOptionsMenu(menu)
menu.add("保存").onMenuItemClick=function(a)
local files = io.open(paths, "w")
files:write(LEdit1.text)
files:close(files)
print("文件已保存")
end
menu.add("统计文本信息").onMenuItemClick=function(a)

end
menu.add("图形化添加").onMenuItemClick=function(a)
print("功能开发中")
end
menu.add("unciv模组开发文档").onMenuItemClick=function(a)
activity.newActivity("ucmdoc")
end
end
--local file = io.open(path, "w")
-- file:write(LEdit1.text)
---  file:close(file)
