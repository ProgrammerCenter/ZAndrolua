File=luajava.bindClass("java.io.File")
LuaUtil=luajava.bindClass("com.androlua.LuaUtil")
zajargen={}
function zajargen.LuaTable2jarMFA(luatble)
  local retstr=""

  for k,v pairs(luatble)
    if type(k)=="number"
      if type(v)=="table"
        retstr=retstr..k..": "..table.concat(v," ")
       else
        retstr=retstr..k..": "..v
      end
    end
  end

end
function zajargen.zajargens(IputDir,
  Outputs,
  jarname,
  dirlete,
  Filters,
  Manifest_Version,
  Created_By,
  usermfa,
  ClassPath)
  local Relativeoutputpath
  local Startstr
  local Terminate
  local Manifest_Version=Manifest_Version
  local Created_By=Created_By
  local dirlete=dirlete
  local Filters=Filters
  local castr1
  local tmps
  local funret
  local tmpobj
  local Manifeststr
  local isconFilecopy
  if Created_By==nil
    Created_By="authors"
  end
  if Manifest_Version==nil
    Manifest_Version="1.0"
  end
  if ClassPath==nil
    ClassPath=""
   else
    ClassPath="Class-Path: "..table.concat(ClassPath," ")

  end
  if dirlete==nil
    dirlete=function()
      return true
    end
  end
  if usermfa==nil
    usermfa=""
  end
  if Filters==nil
    Filters=function()
      return true
    end
  end

  tmps="/storage/emulated/0/tmps"
  tmpobj=File(tmps)
  if tmpobj.exists()
    LuaUtil.rmDir(tmpobj)

  end
  File(tmps.."/META-INF/").mkdirs()
  castr1=tmps.."/META-INF/MANIFEST.MF"
  if File(Outputs).exists()==false
    os.execute("mkdir "..Outputs)
  end
  function nocopy()
    isconFilecopy=false
  end
  File(castr1).createNewFile()
  function getFiles(file,Filters,dirlete)

    files=file.listFiles();

    for k,f in ipairs(luajava.astable(files))
      isconFilecopy=true
      if(f.isDirectory())

        funret= dirlete(f)

        if f.exists() and funret

          getFiles(f,Filters,dirlete);

        end

       else

        funret=Filters(f)

        if f.exists() and funret
          Startstr,Terminate=string.find(f.getPath(),IputDir)

          Relativeoutputpath=string.sub(f.getPath(),Terminate,-1)
          LuaUtil.copyDir(f.getPath(),tmps..Relativeoutputpath)
        end

      end
    end
  end
  getFiles(File(IputDir),Filters,dirlete)
  Manifeststr=[[Manifest-Version: ]]..Manifest_Version..
  "\n"..[[Created-By: ]]..Created_By
  ..ClassPath
  .."\n"..usermfa
  io.open(castr1,"w"):write(Manifeststr):close();
  LuaUtil.zip(tmps,Outputs,jarname)
end

