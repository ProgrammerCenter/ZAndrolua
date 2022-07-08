require "import"
import "android.widget.*"
import "android.view.*"
import "android.widget.TextView"
import "android.widget.LinearLayout"
import "android.widget.EditText"
import "java.net.InetAddress"
require "lua/xash"
import "autotheme"
activity.setTitle('xash')
activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView(loadlayout("xagui/aucmdaly"))
function onCreateOptionsMenu(menu)
  menu.add("xash文档(xash for docs)").onMenuItemClick=function(a)
    activity.newActivity("xashdoc")
  end
  menu.add("清除输出(Clear output)").onMenuItemClick=function(a)
    cmdlogtxt.text=xash.CopyInfo
  end
end
loguis=xash.CopyInfo
language="cn"
LocationDirectory="/sdcard"
cmdlogtxt.setText(xash.CopyInfo)
xashcmdbtn.addTextChangedListener{
  onTextChanged=function(s)
    --事件

    if(string.match(xashcmdbtn.text,".\n")~=nil)
      then
      loguis=loguis..xashcmdbtn.text.."\n"..xash.astpa(xashcmdbtn.text,language).."\n"
      cmdlogtxt.text=loguis
      xashcmdbtn.text=""
    end
  end
}

