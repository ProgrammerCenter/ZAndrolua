require "import"
import "android.widget.*"
import "android.view.*"
function table2strxml(t,defu)
 local xmls=[[<?xml version="1.0" encoding="utf-8"?>
<resources>]].."\n"
if defu
  xmls=xmls..defu
  end
local castr1
  for k,v pairs(t)
    if type(k)=="string"
      if type(v)=="table"
        castr1="\n<string-array "
        castr1=castr1..[[name="]]..k..[[">]].."\n"
       for k2,v2 ipairs(v)
         castr1=castr1.."<item>"..v2.."</item>\n"
         end
       castr1=castr1.."</string-array>"
       xmls=xmls..castr1
       castr1=nil
      else
      xmls=xmls.."\n"..[[<string name="]]..k..[[">]]..v.."</string>"
      end
    else
    error("",0)
    end
  end
xmls=xmls.."\n</resources>"
return xmls
end
