require "import"
import "android.widget.*"
import "android.view.*"
LMX={}
function IsOuNumber(num)
  local unm1,num2=math.modf((num+1)/2)

  if num2==0
    return false
   else
    return true
  end
end
function nnot(nums)
  if nums<0
    return math.abs(nums)
    else
  return tonumber("-"..nums)
  end
end
function splitx(str,delimiter,Escachar)
  if str..delimiter==""
    return {}
   elseif(delimiter=="")
    return {}
   elseif(str=="")
    return {}
  end
if Escachar
  local Escachars=Escachar
  end
local connectchar=""
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
      
      if Escachars
   if string.sub(string.sub(str,1,locaStart-1),-#Escpchars)==Escpchars
        else
        arr[n] = string.sub(str,1,locaStart-1)..connectchar
        end
      else
      arr[n] = string.sub(str,1,locaStart-1)..connectchar
      end
      
--print(string.sub(string.sub(str,1,locaStart-1),-1))
   
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
function Intercept(tables,StartPoint,EndPoint)
  Table_of_results={}
  for contss=StartPoint,EndPoint,1

    table.insert(Table_of_results,tables[contss])
  end
  return Table_of_results
end
function CheckValue(tables,Values,Terminate,iffuncs)
  local CheckValue_cpnt=0
  if iffuncs
    iffunc=iffuncs
   else
    function iffunc()
      return true
    end
  end
  for ki in pairs(tables)

    if tables[ki]==Values and iffunc(tables[ki])
      return true,CheckValue_cpnt+1
    end
    CheckValue_cpnt=CheckValue_cpnt+1
    if CheckValue_cpnt==Terminate
      break
    end
  end
  return false
end
maros_boolen_is=function(varlist,maro_list,maro_boolen_list)
  if string.match(maro_boolen_list,"#isdef%s([^%s]*)")
  if  maro_list[string.match(maro_boolen_list,"#isdef%s([^%s]*)")]~=nil
    return true
    else
    return false
    end
    end
  end
LMX.maros=function(macrosx,texts,luascript)
  local text_list=splitx(texts,[[\]])
  local str_var={}
  local macro_val_list={}
  local drfva,val
  if luascript
    load(luascript)()
  end
  local macoro_list=splitx(macrosx,[[;]])
  if #text_list~=0
    if IsOuNumber(#text_list)

      error("转义符匹配错误",0)
    end
  end
  local ifis=false
  local ms
  local definlist={}
  local msx=1
  while(msx<=#macoro_list)
    errorLineinfo=msx
    if ifis
     else
      if string.match(macoro_list[msx],"#define%s*([^%s]*)%s*([^%s]*.*)")

        local defs,can=string.match(macoro_list[msx],"#define%s*([^%s]*)%s*([^%s]*.*)")
        if string.sub(can,1,1)=="$"
          can=string.sub(can,2,-1)

         else
          can=str_var[can]
        end
      
        for cont2=1,#text_list,1
          if IsOuNumber(cont2)==false

            text_list[cont2]=string.gsub(text_list[cont2],defs,can)
          end
        end
       elseif string.match(macoro_list[msx],"#dolua%s*<(.*)>")
        load(string.match(macoro_list[msx],"#dolua%s*<(.*)>"))()
       elseif string.match(macoro_list[msx],[[#defvar%s*([^%s]*)%s*'(.*)']])
        drfva,val=string.match(macoro_list[msx],[[#defvar%s*([^%s]*)%s*'(.*)']])
        str_var[drfva]=val
          elseif string.match(macoro_list[msx],[[#goto%s([^%s]*)]])
        msx=tonumber(string.match(macoro_list[msx],[[#goto%s([^%s]*)]]))
       if msx<0
         if math.abs(msx)>#macoro_list
           error('\n'..errorLineinfo..":错误！超过宏定义指令条数的goto语句(负数)\nMistake! Goto statements exceeding the number of macrodefined instructions (negative number)",4)
           else
           msx=#macoro_list-math.abs(msx)
           if msx==0
             msx=1
             end
           end
         end
        if msx>#macoro_list
            error('\n'..errorLineinfo..":错误！超过宏定义指令条数的goto语句(正数)\nMistake! A goto statement that exceeds the number of macrodefined instructions (positive number)",4)
          end
      end
    end
msx=msx+1
  end

  return table.concat(text_list)
end
