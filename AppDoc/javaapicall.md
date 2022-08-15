##### 导入java类 #####
第1种方法:   
使用import "类的包名+类名"。   
注意！import函数要先用require "import"导入之后才能使用。
举例:  
```Lua
import "android.widget.TextView"
print(TextView)
```
以上代码会输出class    android.widget.TextView这个字符串。    
第2种方法:  
使用luajava.bindclass("类的包名+类名")。   
举例:    
```Lua
tv=lua.bindClass("android.widget.TextView")
print(tv)
```
以上代码也会输出class android.widget.TextView这个字符串。

##### 创建Java对象 #####
第1种:
使用import函数导入java类之后，使用类名(构造函数参数)创建对象     
举例:
```Lua
import "android.widget.TextView"
tv=TextView(activity)
```
第2种:
使用luajava.bindClass来获得类的引用，然后使用引用来创建对象。   
举例: 
```Lua
tc=luajava.bindClass "android.widget.TextView"
tv=tc(activity)
```
注意！以上所述的activity即指当前activity对象，ZAndrolua会自动根据传入的参数选择构造方法。

##### 调用java类和对象方法与属性 ##### 
     
      
调用类的静态属性(static权限符修饰的属性):   
类名/类的引用.属性名称    
举例:
```Lua
import  "com.zajt.MainjavaTools"
print(MainjavaTools.CopyrightOwner)

```
也可改成
```Lua
mt=luajava.bindClass  "com.zajt.MainjavaTools"
print(mt.CopyrightOwner)
```

以上代码会输出ZAndrolua作者著佐权所有，MainjavaTools是ZAndrolua中的软件版本和版权标识类。  
      
     
     
调用java类的静态方法:    
类名/类的引用.静态方法名(参数)   
举例:   
```Lua
import "java.lang.String"
print(String.valueOf(5))
```
也可改成
```Lua
sc=luajava.bindClass "java.lang.String"
print(sc.valueOf(5))
```
以上代码会输出5.0(lua中所有的数字都是双精度浮点数，所以才会这样)这个字符串。  
         
valueOf是java String类的其他类型数据转换字符串类型数据的静态方法。   
         
在有多个同名方法时ZAndrolua使用的基础库luajava会自动根据传入参数的类型和参数个数来选择使用哪个方法。    
       
      
      
调用java类对象的方法(即没有static权限修饰符修饰的方法):   
对象.方法名称(参数)    
举例:   
```Lua
import "java.io.File"
files=File("/sdcard")
print(files.getName())
```
以上代码也可改成    
```Lua
fc=luajava.bindClass "java.io.File"
files=fc("/sdcard")
print(files.getName())
```
以上代码会输出sdcard。    
File是java的文件对象类，用于处理文件路径和文件名称，getName是获取File对象所代表的文件夹或者文件的名称的方法。
跟调用类的静态方法一样，在有多个同名方法时ZAndrolua使用的基础库luajava会自动根据传入参数的类型和参数个数来选择使用哪个方法。
             
               
 调用java类对象的属性(即没有static权限修饰符修饰的属性):       
           对象.属性名称     
 这里就不举例了，至于如何使用就是相当于把上面的对象方法调用去掉()和参数。     
 #####   创建Java数组  #####
 对于基本类型的java数组，可以通过基本类型名称[数组长度]的方式创建.    
 举例:     
```Lua
a=int[3]
```
以上代码创建了一个长度为3，类型为int的java数组，并放进了a变量。      
对于对象类型的Java数组使用对象/对象引用[数组长度]的方式创建。      
举例:     
```Lua
import "android.widget.TextView"
a=TextView[5]
```
以上代码创建了一个长度为5的TextView对象数组放进了a变量。    
当然以上代码可以改写为:
```Lua
tv=luajava.bindClass "android.widget.TextView"
a=tv[5]
```
##### 转换java Map、list、array为lua表 #####
luajava.astable(javaMap/javaArray/javaList)返回一个lua table。   
举例:    
```
vt=luajava.astable(int[5])
```
##### 销毁java对象 #####
使用luajava.clear来销毁对象。   
举例:    
```Lua
--至于前面的import/luajava.bindClass就省略了。
o=TextView(activity)
print(luajava.clear(o))
print(o)
```
以上代码会打印出null。