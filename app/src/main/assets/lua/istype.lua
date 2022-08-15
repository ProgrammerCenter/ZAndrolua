istype={}
istype.erro=error
istype.isnumber=function(v)
  if type(v)~="number"
    istype.erro("isType:isnumber:Exception:no number")
    return
  end
  return v
end
istype.isnil=function(v)
  if type(v)~=nil
    istype.erro("isType:isnil:Exception:no  nil")
    return
  end
  return v
end
istype.seterro=function(f)
  if type(f)~="function"
    istype.erro("isType:seterro:Exception:no  function")
    return
  end
  istype.erro=f
end
istype.istable=function(v)
  if type(v)~="table"
    istype.erro("isType:istable:Exception:no table")
    return
  end
  return v
end
istype.isfunction=function(v)
  if type(v)~="function"
    istype.erro("isType:isfunction:Exception:no function")
    return
  end
  return v
end
istype.isboolean=function(v)
  if type(v)~="boolean"
    istype.erro("isType:isboolean:Exception:no boolean")
    return
  end
  return v
end
istype.isstring=function(v)
  if type(v)~="string"
    istype.erro("isType:isstring:Exception:no string")
    return
  end
  return v
end
istype.isuserdata=function(v)
  if type(v)~="userdata"
    istype.erro("isType:isuserdata:Exception:no userdata")
    return
  end
  return v
end
istype.isthread=function(v)
  if type(v)~="thread"
    istype.erro("isType:isthread:Exception:no thread")
    return
  end
  return v
end
istype.isint=function(v)
  local a,b
  if type(v)=="number"
    a,b= math.modf(v)
    if b~=0.0
      istype.erro("isType:isint:Exception:no int number")
      return
    end
   else
    istype.erro("isType:isint:Exception:no number")
    return
  end
  return v
end



