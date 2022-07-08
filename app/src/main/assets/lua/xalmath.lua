require "import"
import "android.widget.*"
import "android.view.*"
xalmath={}
function xalmath.Bitsplit(num)
  --此函数原名称math.split()
 local tab = {}
 for i = 0, math.log(num, 10) do
  table.insert(tab, 1, math.ceil((num // (10 ^ i)) % 10))
 end
return tab
end
function xalmath.ancos(angles)
 local Radians=angles*math.pi/180
 return math.cos(Radians)
  end
function xalmath.ansin(angles)
 local Radians=angles*math.pi/180
 return math.sin(Radians)
  end
function xalmath.rotate(x, y, z, xz, zy)
  --坐标x, y, z; 旋转角 绕y,绕x (弧度)
  local x2 = x*math.cos(xz) - z*math.sin(xz)
  local z1 = x*math.sin(xz) + z*math.cos(xz)

  local z2 = z1*math.cos(zy) - y*math.sin(zy)
  local y2 = z1*math.sin(zy) + y*math.cos(zy)

  return x2, y2, z2
end
function xalmath.antan(angles)
 local Radians=angles*math.pi/180
 return math.tan(Radians)
  end
function xalmath.vector_Two_dimensional(Odeiy,Tdeiy,operate)
  --[[调用例子：
  假设有两个向量分别为a,b
  设b为[0,5]，a为[5,1]
  则B通过表的形式写为b={0,5},a写为{5,1}。
  其实{}可以换成[]
  如要利用此函数进行对以上a,b向量进行向量加法计算，
  那么就vector_Two_dimensional(a,b,"+")，
  存储此函数进行以上所述计算的返回值方法形式为：
  变量=vector_Two_dimensional(a,b,"+")。
  以上所述变量接收函数返回值后，已经实际成为一张表，
  作为表，其的第1个值（变量[1]）即为向量a第一方向与向量B第一方向进行加法计算的值
  ，第二方向值如上]]
  if(operate=="+")
    then
   consequence_1=Odeiy[1]+Tdeiy[1]
   consequence_2=Odeiy[2]+Tdeiy[2]
   return {consequence_1,consequence_2}
    end
   if(operate=="-")
    then
    consequence_1=Odeiy[1]-Tdeiy[1]
   consequence_2=Odeiy[2]-Tdeiy[2]
   return {consequence_1,consequence_2}
    end
   if(operate=="×")
    then
    consequence_1=Odeiy[1]*Tdeiy[1]
   consequence_2=Odeiy[2]*Tdeiy[2]
   return {consequence_1,consequence_2}
    end
   if(operate=="÷")
    then
    print("error:向量与向量之间无法相除！")
    end
  end
function xalmath.vector_three_dimensional(Odeiy,Tdeiy,operate)
  --[[调用方法请参考vector_Two_dimensional函数]]
  if(operate=="+")
    then
   consequence_1=Odeiy[1]+Tdeiy[1]
   consequence_2=Odeiy[2]+Tdeiy[2]
   consequence_3=Odeiy[3]+Tdeiy[3]
   return {consequence_1,consequence_2,consequence_3}
    end
   if(operate=="-")
    then
    consequence_1=Odeiy[1]-Tdeiy[1]
   consequence_2=Odeiy[2]-Tdeiy[2]
   consequence_3=Odeiy[3]-Tdeiy[3]
   return {consequence_1,consequence_2,consequence_3}
    end
   if(operate=="×")
    then
    consequence_1=Odeiy[1]*Tdeiy[1]
   consequence_2=Odeiy[2]*Tdeiy[2]
   consequence_3=Odeiy[3]*Tdeiy[3]
   return {consequence_1,consequence_2,consequence_3}
    end
   if(operate=="÷")
    then
    print("error:向量与向量之间无法相除！")
    end
  end
function xalmath.Cartesian_product(t1,t2)
local th1
local th2
local function DeleteTheSameElement(tables)
        local exist = {}
        --把相同的元素进行覆盖掉
        for v, value in pairs(tables) do
            exist[value] =true  --value进行保存 当成一个key
        end
        --重新排序表
        local newTable = {}
        for v, k in pairs(exist) do
            table.insert(newTable, v)--这里的v就相当于上面的value
        end
        return newTable --返回已经去重的表
end
  if(#t2>#t1)
    then
     th1=DeleteTheSameElement(t1)
    th2=DeleteTheSameElement(t2)
   else
     th1=DeleteTheSameElement(t2)
     th2=DeleteTheSameElement(t1)
  end
local   t={}
local   z=1
  local ks
  for i=1,#th1,1
    do
    ks=i
    for i=1,#th2,1
      do
      t[z]={th1[ks],th2[i]}
      z=z+1
    end
  end
  return t
end
--求两个表元素之间的笛卡尔乘积。
function xalmath.Qmbv_two_dimensional(Quantity,Odeiy,operate)
   if(operate=="×")
    then
    consequence_1=Odeiy[1]*Quantity
   consequence_2=Odeiy[2]*Quantity
   return {consequence_1,consequence_2}
    end
   if(operate=="-")
    then
    consequence_1=Odeiy[1]-Quantity
   consequence_2=Odeiy[2]-Quantity
   return {consequence_1,consequence_2}
    end
  if(operate=="+")
    then
    consequence_1=Odeiy[1]+Quantity
   consequence_2=Odeiy[2]+Quantity
   return {consequence_1,consequence_2}
    end
  if(operate=="÷")
    then
    consequence_1=Odeiy[1]/Quantity
   consequence_2=Odeiy[2]/Quantity
   return {consequence_1,consequence_2}
    end
  
  end
function xalmath.Qmbv_Four_dimensional(Quantity,Odeiy,operate)
   if(operate=="×")
    then
    consequence_1=Odeiy[1]*Quantity
   consequence_2=Odeiy[2]*Quantity
   consequence_3=Odeiy[3]*Quantity
   consequence_4=Odeiy[4]*Quantity
   return {consequence_1,consequence_2,consequence_3,consequence_4}
    end
  if(operate=="-")
    then
    consequence_1=Odeiy[1]-Quantity
   consequence_2=Odeiy[2]-Quantity
   consequence_3=Odeiy[3]-Quantity
   consequence_4=Odeiy[4]-Quantity
   return {consequence_1,consequence_2,consequence_3,consequence_4}
   end
    if(operate=="+")
    then
    consequence_1=Odeiy[1]+Quantity
   consequence_2=Odeiy[2]+Quantity
   consequence_3=Odeiy[3]+Quantity
   consequence_4=Odeiy[4]+Quantity
   return {consequence_1,consequence_2,consequence_3,consequence_4}
   end
  if(operate=="/")
    then
    consequence_1=Odeiy[1]/Quantity
   consequence_2=Odeiy[2]/Quantity
   consequence_3=Odeiy[3]/Quantity
   consequence_4=Odeiy[4]/Quantity
   return {consequence_1,consequence_2,consequence_3,consequence_4}
    end
  end
function xalmath.Qmbv_therr_dimensional(Quantity,Odeiy,operate)
   if(operate=="×")
    then
    consequence_1=Odeiy[1]*Quantity
   consequence_2=Odeiy[2]*Quantity
   consequence_3=Odeiy[3]*Quantity
   return {consequence_1,consequence_2,consequence_3}
    end
   if(operate=="-")
    then
    consequence_1=Odeiy[1]-Quantity
   consequence_2=Odeiy[2]-Quantity
   consequence_3=Odeiy[3]-Quantity
   return {consequence_1,consequence_2,consequence_3}
    end
  if(operate=="+")
    then
    consequence_1=Odeiy[1]+Quantity
   consequence_2=Odeiy[2]+Quantity
   consequence_3=Odeiy[3]+Quantity
   return {consequence_1,consequence_2,consequence_3}
    end
  if(operate=="÷")
    then
    consequence_1=Odeiy[1]/Quantity
   consequence_2=Odeiy[2]/Quantity
   consequence_3=Odeiy[3]/Quantity
   return {consequence_1,consequence_2,consequence_3}
    end
  
  end
function xalmath.Matrix_ffr_Quantity(Quantity,Matrixs,operate)
 if(operate=="-")
then 
for k,Matrixffr in  pairs(Matrixs) do
Matrixffr=Matrixffr-Quantity

end
return Matrixs
end
if(operate=="+")
  then
  for k,Matrixffr in  pairs(table) do
 Matrixffr=Matrixffr+Quantity
 end
return table
  end
if(operate=="×")
  then
  for k,Matrixffr in  pairs(table) do
Matrixffr=Matrixffr*Quantity
end
return table
  end
if(operate=="÷")
  then
  for k,Matrixffr in  pairs(table) do
Matrixffr=Matrixffr/Quantity
end
return table
  end
end