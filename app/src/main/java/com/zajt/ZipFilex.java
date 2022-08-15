package com.zajt;
import java.util.zip.ZipFile;
import java.nio.file.*;
import java.io.*;
public class ZipFilex extends ZipFile
{
	
	public  ZipFilex(File zipPath) throws IOException 
	
	{
	     super(zipPath);
	}
	public ZipFilex(File file, int mode) throws IOException{
		super(file,mode);
		
	}
	
	
	
}
