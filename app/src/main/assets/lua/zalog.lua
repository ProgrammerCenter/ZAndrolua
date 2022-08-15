zalog={}
zalog.f="/storage/emulated/0/AndroLua/logs/mlog"
zalog.strlog=function(str)
  file,err=io.open(zalog.f)
if err
   then
   io.open(zalog.f, 'w')
end
io.output(zalog.f)

-- 在文件最后一行添加 Lua 注释
io.write(str)
  end
