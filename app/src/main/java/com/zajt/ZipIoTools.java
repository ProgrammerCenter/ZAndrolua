package com.zajt;
import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import java.io.*;
class ZipIoTools
{
	private String zipbpath="";
    
public ZipIoTools(String paths){
	
	this.zipbpath=paths;
	
	
	
}
	 
	static   public void addfile(String zipname, String files) throws java.io.IOException
	{



		File file = new File(files);
		File zipFile = new File(zipname);
		//读取相关的文件
		InputStream input = new FileInputStream(file);
		//设置输出流
		ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(
														 zipFile));

		zipOut.putNextEntry(new ZipEntry(file.getName()));
		// 设置注释
		zipOut.setComment("hello");
		int temp = 0;
		//读取相关的文件
		while ((temp = input.read()) != -1)
		{
			//写入输出流中
			zipOut.write(temp);
		}
		//关闭流
		input.close();
		zipOut.close();
	}
	   public void addfile(String files) throws java.io.IOException
	{



		File file = new File(files);
		File zipFile = new File(this.zipbpath);
		//读取相关的文件
		InputStream input = new FileInputStream(file);
		//设置输出流
		ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(
														 zipFile));

		zipOut.putNextEntry(new ZipEntry(file.getName()));
		// 设置注释
		zipOut.setComment("hello");
		int temp = 0;
		//读取相关的文件
		while ((temp = input.read()) != -1)
		{
			//写入输出流中
			zipOut.write(temp);
		}
		//关闭流
		input.close();
		zipOut.close();
	}
	

}


