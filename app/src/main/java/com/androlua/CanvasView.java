package com.androlua;

import android.graphics.*;
import android.content.*;
import android.util.*;
import android.view.*;
import com.luajava.*;
import com.androlua.*;
import android.widget.*;
import java.util.*;
import java.util.regex.*;
import android.widget.AutoCompleteTextView.*;
import java.io.*;
public class CanvasView extends View{
private int ViewHeight;
private int ViewWidth;
private Paint mpaints;
private Class dracls;
private LuaFunction draws;

private boolean islua=false;
public Object Canvasbackground=0;

public CanvasView(Context context,AttributeSet attrs){
  //Attribute属性，布局文件里设置的自定义属性
  //attrs必须传给父类，好让父类知道具体要绘制的参数
  
  super(context,attrs);
int Canvasbackground_number= attrs.getAttributeIntValue(null,"CanvasBackground",0);
//String Canvab_img_name= attrs.getAttributeIntValue(null,"CanvasBackgroundImage",);
   
	
	Canvasbackground=Canvasbackground_number;
	
}
      

public CanvasView(Context context)
{
	
	super(context);
	
}
public void setCanvasbackground(int Canvasbackgrounds)
{
	
	Canvasbackground=Canvasbackgrounds;
	
}
@Override
public void onDraw(Canvas canvas){
  if (Canvasbackground==0){
	  
	  canvas.drawColor(0xFFFFFFFF);
  }
  else{
	if (Canvasbackground instanceof Bitmap
	)
	{
		
		
		
	}
	else
	{
		
	  canvas.drawColor(Canvasbackground);
	  }
	}
if(islua){
		try
		{
	        draws.getLuaState().pushJavaObject(this);
			draws.getLuaState().setGlobal("CanvasSelf");
			draws.call(canvas,mpaints);
       
		}
		catch (LuaException e)
		{
			draws.getLuaState().getContext().sendError("Draw", e);
		}
		
	}
	
}
public void setBackground(LuaFunction func)
{
	
	this.Draw(func);
	
}
public void setCanvasbackground(Bitmap Canvasbackgrounds) 
{
	
	
	Canvasbackground=Canvasbackgrounds;
    
}
public void Draw(LuaFunction func)
{
draws=func;
islua=true;
}

@Override
protected void onSizeChanged(int w,int h,int oldw,int oldh){
  //当界面改变时，即切屏时当前的宽度与高度
 ViewHeight=h;
 ViewWidth=w;
 
 
}
public int getCanvasHeight()
{
	
	return ViewHeight;
}
public int getCanvasWidth(){
	
	
	return ViewWidth;
}
}
