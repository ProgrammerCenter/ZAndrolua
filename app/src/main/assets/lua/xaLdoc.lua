require "import"
import "android.widget.*"
import "android.view.*"
xaLdoc={}
function xaLdoc.替换文件字符串(路径,要替换的字符串,替换成的字符串)
  if 路径 then
    路径=tostring(路径)
    内容=io.open(路径):read("*a")
    io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
   else
    return false
  end
end
function xaLdoc.xaLdocs(Filenames)
  local Fileinformation={}
  Fileinformation[1]="author(文件作者):"..xaLdoc.lua_file_author(Filenames)
  Fileinformation[2]="File_Version(文件版本):"..xaLdoc.lua_file_edition(Filenames)
  Fileinformation[3]="Last Modified Time(文件最后修改时间):"..xaLdoc.lua_file_LMT(Filenames)
 Fileinformation[4]="XaLdoc Inserted Text Link(xaLdoc插入文本链接):\n"..xaLdoc.lua_file_links(Filenames)
 Fileinformation[5]="Open Source License(开源许可证):\n"..xaLdoc.lua_file_fleOSL(Filenames)
 Fileinformation[6]="Function variable name interpretation(函数变量名解释)"..xaLdoc.函数变量名解释(Filenames)
  return table.concat(Fileinformation,"\n")
end

function xaLdoc.lua_file_fleOSL(Filenames)
  local Filecontents=xaLdoc.text_Inputs(Filenames)
local consequence=string.match(Filecontents,"%-%-@FileOSL (.-)>")
if(consequence==nil)
  then
  return "nils"
  else
  return consequence
  end
  end
function xaLdoc.FindFiles(ftxt,name)
  if(string.match(ftxt,"function "..name.."("))
    return true
    elseif(string.match(ftxt,name.."="))
    return true
    elseif(string.match(ftxt,name.."=".."{"))
   return true
   else
   return false
    end
  end
function xaLdoc.函数变量名解释(Filenames)
  local Steprecording=1
  local Listofresults={}
local  ftxt=xaLdoc.text_Inputs(Filenames)
     for w,i ,i2,i3 in string.gmatch(ftxt, "%-%-@interpret <(.-)><(.-)><(.-)><(.-)>") do
       Listofresults[Steprecording]="\n此函数/表/变量不存在:"..i.."\n"
       if(xaLdoc.FindFiles(ftxt,i))
      Listofresults[Steprecording]=i.."("..w..")"..":\n"..i2.."\n author(作者):"..i3.."\n"
      end
    Steprecording=Steprecording+1
     end
   return table.concat(Listofresults,"\n")
  end
function xaLdoc.lua_file_links(Filenames)
  local Steprecording=1
  local Listofresults={}
local  ftxt=xaLdoc.text_Inputs(Filenames)
     for w in string.gmatch(ftxt, "%-%-@FileLinks (.-)>") do
      Listofresults[Steprecording]=w
      Steprecording=Steprecording+1
     end
   return table.concat(Listofresults,"\n")
  end
function xaLdoc.lua_file_LMT(Filenames)
  local Filecontents=xaLdoc.text_Inputs(Filenames)
  local AuthorInformation=string.match(Filecontents,"(-%-%@Last_Modified_Time .*>)")
  if(AuthorInformation==nil)
    then
    return "nils"
   else
    local stra=xaLdoc.split(AuthorInformation," ")
    local Author=xaLdoc.split(stra[2],">")
    return Author[1]
  end
end
function xaLdoc.lua_file_OEn(Filenames)
  local Filecontents=xaLdoc.text_Inputs(Filenames)
  local AuthorInformation=string.match(Filecontents,"(%-%-@Operating_Envi .*>)")
  if(AuthorInformation==nil)
    then
    return "nils"
   else
    local stra=xaLdoc.split(AuthorInformation," ")
    local Author=xaLdoc.split(stra[2],">")
    return Author[1]
  end
end
function xaLdoc.lua_file_edition(Filenames)
  local Filecontents=xaLdoc.text_Inputs(Filenames)
  local AuthorInformation=string.match(Filecontents,"(%-%-@Software_version .*>)")
  if(AuthorInformation==nil)
    then
    return "nils"
   else
    local stra=xaLdoc.split(AuthorInformation," ")
    local Author=xaLdoc.split(stra[2],">")
    return Author[1]
  end
end
function xaLdoc.lua_file_author(Filenames)
  local Filecontents=xaLdoc.text_Inputs(Filenames)
  local AuthorInformation=string.match(Filecontents,"(%-%-@author .*>)")
  if(AuthorInformation==nil)
    then
    return "nils"
   else
    local stra=xaLdoc.split(AuthorInformation," ")
    local Author=xaLdoc.split(stra[2],">")
    return Author[1]
  end
end
function xaLdoc.split(str,delimiter)
  local dLen = string.len(delimiter)
  local newDeli = ''
  for i=1,dLen,1 do
    newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
  end

  local locaStart,locaEnd = string.find(str,newDeli)
  local arr = {}
  local n = 1
  while locaStart ~= nil
    do
    if locaStart>0 then
      arr[n] = string.sub(str,1,locaStart-1)
      n = n + 1
    end

    str = string.sub(str,locaEnd+1,string.len(str))
    locaStart,locaEnd = string.find(str,newDeli)
  end
  if str ~= nil then
    arr[n] = str
  end
  return arr
end
xaLdoc.text_Inputs=function(Filedirectory)
  local file = io.open(Filedirectory, "r")
  local Filetext = file:read("*a")
  file:close(file)
  return Filetext
end
--print(xaLdoc.xaLdocs("/storage/emulated/0/Ldoctest",true))
