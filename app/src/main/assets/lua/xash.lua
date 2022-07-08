require "import"
import "http"
import "android.os.*"
import "android.content.Context"
import "android.net.Uri"
import "android.app.DownloadManager"
import "java.net.InetAddress"
xash={}
xash.clstra="@2022 MGSIDE  @nirenr COPYRIGHT @Blogs on the Internet\n"
xash.clstrb="@for luajava @for java @for AndroidOS @for Androlua "
xash.clstrc="Command line for xash..\n"
xash.CopyInfo=xash.clstra..xash.clstrb..xash.clstrc
---CopyrightInformation
function xash.Mobilephoneinformation()
  Mobphoneinfotable={}
  Mobphoneinfotable[1]="设备基板名称/BOARD:"..Build.BOARD --获取设备基板名称
  Mobphoneinfotable[2]="设备引导启动程序版本号/BOOTLOADER:"..Build.BOOTLOADER --获取设备引导程序版本号
  Mobphoneinfotable[3]="设备品牌/BRAND:"..Build.BRAND--获取设备品牌
  Mobphoneinfotable[4]="设备第一指令集/CPU_ABI:"..Build.CPU_ABI --获取设备指令集名称（CPU的类型）
  Mobphoneinfotable[5]="设备第二指令集/CPU_ABI2:"..Build.CPU_ABI2 --获取第二个指令集名称
  Mobphoneinfotable[6]="设备驱动名称:"..Build.DEVICE --获取设备驱动名称
  Mobphoneinfotable[7]=Build.DISPLAY--获取设备显示的版本包（在系统设置中显示为版本号）和ID一样
  Mobphoneinfotable[8]=Build.FINGERPRINT --设备的唯一标识。由设备的多个信息拼接合成
  Mobphoneinfotable[9]=Build.HARDWARE--设备硬件名称，一般和基板名称一样（BOARD）
  Mobphoneinfotable[10]=Build.HOST--设备主机地址
  Mobphoneinfotable[11]=Build.ID--设备版本号
  Mobphoneinfotable[12]="手机型号(设备名称)/MODEL:"..Build.MODEL--获取手机的型号 设备名称。如 Mobphoneinfotable[12]--SM-N9100（三星Note4）
  Mobphoneinfotable[13]=Build.MANUFACTURER --获取设备制造商。如 Mobphoneinfotable[13]--samsun
  Mobphoneinfotable[14]=Build.PRODUCT --产品的名称
  Mobphoneinfotable[15]=Build.RADIO --无线电固件版本号，通常是不可用的 显示
  Mobphoneinfotable[16]="设备标签/TAGS:".."不可用/Not available"--
  Mobphoneinfotable[17]="时间(毫秒)/times(Millisecond):"..Build.TIME --时间
  Mobphoneinfotable[18]=Build.TYPE --设版本类型主要为”user” 或”eng”
  Mobphoneinfotable[19]="device of User name/设备用户名:"..Build.USER --设备用户名 基本上都为android-build
  Mobphoneinfotable[20]=Build.VERSION.RELEASE --获取系统版本字符串
  Mobphoneinfotable[21]=Build.VERSION.CODENAME --设备当前的系统开发代号，一般使用REL代替
  Mobphoneinfotable[22]=Build.VERSION.INCREMENTAL --系统源代码控制值，一个数字或者git哈希值
  Mobphoneinfotable[23]=Build.VERSION.SDK --系统的API级别，推荐使用下面的SDK_INT来查看
  Mobphoneinfotable[24]=Build.VERSION.SDK_INT --系统的API级别，int数值类型
  return table.concat(Mobphoneinfotable,"\n")
end
function xash.AOSdownload(Downloadlink,FileSaveDirectory,FileSaveName)
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(Downloadlink);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(FileSaveDirectory,FileSaveName);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end
function xash.Openapps(packageName)
  import "android.content.Intent"
  import "android.content.pm.PackageManager"
  manager = activity.getPackageManager()
  open = manager.getLaunchIntentForPackage(packageName)
  this.startActivity(open)

end
--文件批量操作函数
function xash.Batchfileoperations(FileTable,operate)
  local tablelength=#FileTable
  if(operate=="delete")
    then
    while(tablelength>0)
      do
      Wtaof=(os.remove(FileTable[tablelength]))
      tablelength=tablelength-1
      if(Wtaof==nil)
        then
        break
      end
    end

    return Wtaof
  end
  if(operate=="create")
    then
    while(tablelength>0)
      do
      Wtaof=((io.open(FileTable[tablelength], 'w')))
      tablelength=tablelength-1
      if(Wtaof==nil)
        then
        break
      end
    end
    return Wtaof
  end
end
---第1个返回值是文件操作列表中的文件的操作过程中是否有文件操作失败。
function xash.split(str,delimiter)
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
--以上代码来自菜鸟教程用户道言空
function xash.Stringlookup_reserve(InputString,Startstring,Terminatingstring)
  local stra=xash.split(InputString,Terminatingstring)
  --ab|c
  local strb=xash.split(stra[1],Startstring)
  --a|b
  return Startstring..strb[2]..Terminatingstring
  --b
end
function xash.Stringlookup(InputString,Startstring,Terminatingstring)
  local stra=xash.split(InputString,Terminatingstring)
  local strb=xash.split(stra[1],Startstring)
  return strb[2]
end
function xash.strStringRemove(InputString,Startstring,Terminatingstring)
  local stra=xash.split(InputString,Terminatingstring)
  --ab|c
  local strb=xash.split(stra[1],Startstring)
  --a|b
  return strb[1]..Startstring..Terminatingstring..stra[2]
  --b
end
--[[以上函数对有两个相同并夹在在其他字符的多个或单个字符的字符串进行操作会出问题
除非这个字符串同时是起始符和终止符，因为在此情况下必须有两个同样的字符串夹杂在输入字符串中。]]
function xash.Fileoperation(Inputstring,lags)
  -- 假设输入字符为file-BulkDeletion a,b;
  local aststr1=xash.split(Inputstring,";")
  local --此处字符串转变为 file-BulkDeletion a,b|;
  aststr2=xash.split(aststr1[1]," ")
  --此处字符串转变为file-BulkDeletion|a,b
  local aststr3=aststr2[1]
  --此处字符串转变为file-BulkDeletion
  local aststr4=xash.split(aststr2[2],",")
  --此处字符串转变为a|b
  if(aststr3=="file-BulkDeletion")
    then
    local foft=xash.Batchfileoperations(aststr4,"delete")
    if(foft==nil)
      then
      return xash.Fileoperation_erro(true,lags,true)
     else
      ---  print(foft)
      return "true"
    end
   elseif (aststr3=="web-GetIPAddr-Localmachine")
    then
    local address=InetAddress.getLocalHost();
    return address
   elseif (aststr3=="web-GetIPAddr-Website")
    then
    local address=InetAddress.getByName(aststr2[2]);
    return address
   elseif (aststr3=="TogglePrompt-language")
    then
    return aststr2[2]
    elseif (aststr3=="OriginalAndroidsheell")
    then
    return os.execute(aststr2[2])
   elseif (aststr3=="web-DownloadFile-AOSD")
    then
    xash.AOSdownload(aststr4[1],aststr4[2],aststr4[3])
    if(lags=="en")

      return "This command returns whether there was an error in the download."
     elseif(lags=="cn")
      then
      return "此命令不会返回，是否下载过程中出错。"
    end
   elseif(aststr3=="openapp-packageName")
    then
    if pcall(function() activity.getPackageManager().getPackageInfo(aststr2[2],0) end) then
      local opft=xash.Openapps(aststr2[2])
     else
      if(lags=="en")

        return "App does not exist!"
       elseif(lags=="cn")
        then
        return "应用不存在！"
      end
    end
   elseif (aststr3=="Mobile_phone_information")
    then
    return xash.Mobilephoneinformation()
   elseif (aststr3=="web-DownloadFile-HTPD")
    then
    local dft=http.download(aststr4[1],aststr4[2])
    return dft
   elseif (aststr3=="file-Deletion")
    then
    local foft=(os.remove(aststr2[2]))
    if(foft==nil)
      then
      return xash.Fileoperation_erro(true,lags,true)
     else
      return "true"
    end
   elseif (aststr3=="file-open")
    then
    if(aststr4[2]==nil)
      then
      local file = io.open(aststr2[2], "r")
      local rets=file:read("*a")
      file:close(file)
      return rets
     else
      return xash.Fileoperation_erro(false,lags,true)
    end
   elseif (aststr3=="file-create")
    then
    if(aststr4[2]==nil)
      then
      local foft=(io.open(aststr2[2], 'w'))
      if(foft==nil)
        then
        return xash.Fileoperation_erro(true,lags,true)
       else
        return "true"
      end
     else
      return xash.Fileoperation_erro(false,lags,true)
    end
   elseif(aststr3=="file-Bulkcreate")
    then
    local foft=xash.Batchfileoperations(aststr4,"create")
    if(foft==nil)
      then
      return xash.Fileoperation_erro(true,lags,true)
     else
      return "true"
    end
   else
    return xash.Fileoperation_erro(false,lags,true)
  end
  --- return aststr1[1].."|",aststr2[2].."|",aststr3.."|",aststr4[1].."|",aststr4[2].."|"
  --测试脚本语法分析代码

end
--print(xash.Fileoperation("file-BulkDeletion a,b;"))
--测试脚本语法分析代码
function xash.Fileoperation_erro(cmdetf,lag,asteft)
  local Errormessage="error:"
  if (lag=="en")
    then
    if(asteft==true)
      then
      Errormessage=Errormessage.."Syntax, please check if there is any error"
    end
    if(cmdetf==true)
      then
      Errormessage=Errormessage.."Command error. Check your command for errors or check your user rights to execute this command.Notice! Files that can be operated on in the list of files you want to operate on have already been operated on\n"
    end
    return Errormessage
   elseif (lag=="cn")
    then
    if(asteft==true)
      then
      Errormessage=Errormessage.."语法有错误，请检查。"
    end
    if(cmdetf==true)
      then
      Errormessage=Errormessage.."命令执行错误，请检查您的命令是否错误或者，检查您的用户权限是否能执行此命令,注意！已对您要操作的文件列表中可以操作的文件已经进行操作！\n"
    end
    return Errormessage
   else

    return "iputerrors"
  end

end
function xash.xaioiput(filiputs,moduls)
  local file = io.open(iputs, moduls)
  local xaiofilret=file:read("*a")
  file:close(file)
  return xaiofilret
end
function xash.xaioout(outs,fileout,modules)
  local files = io.open(fileout, modules)
  files:write(outs)
  files:close(files)
end
function xash.astpa(Inputcharacter,Lags)
  local astpara=xash.split(Inputcharacter,";")
  local Lengthoftable=#astpara
  local Counters=1
  local logs="xashLog:\n"
  
  while(Counters<Lengthoftable)
    do
   
     if(string.match(astpara[Counters],". .")~=nil)
      local astparb=astpara[Counters]..";"
      logs=logs..xash.Fileoperation(astparb,Lags)
      Counters=Counters+1
      else
      logs=logs.."Syntax error！/语法错误！"
      Counters=Counters+1
    end
  end
  if(logs=="xashLog:\n")
    then
  return logs.."Syntax error！/语法错误！"
  else
  return logs
  end
end
--print(xash.Fileoperation("web-DownloadFile-AOSD http://m.downza.cn/soft/140704.htmlx,tfl/,test2.html;","cn"))