package com.zajt;
import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.io.*;
class ZipIoTools
{
	public   static    String extractZipComment(String filename)
	{			String retStr = null;	
		try
		{ 
			File file = new File(filename);		
			int fileLen = (int)file.length();			          
			FileInputStream in = new FileInputStream(file);		

			/* The whole ZIP comment (including the magic byte sequence)			* MUST fit in the buffer			* otherwise, the comment will not be recognized correctly			*			* You can safely increase the buffer size if you like			*/		
			byte[] buffer = new byte[Math.min(fileLen, 8192)];	
			int len;
			in.skip(fileLen - buffer.length);	
			if ((len = in.read(buffer)) > 0)
			{
				retStr = getZipCommentFromBuffer(buffer, len);
			}		
			in.close();		
		}
		catch (Exception e)
		{
			e.printStackTrace();		

		}		

		return retStr;
	}

	private static String getZipCommentFromBuffer(byte[] buffer, int len)
	{   byte[] magicDirEnd = {0x50, 0x4b, 0x05, 0x06};			
		int buffLen = Math.min(buffer.length, len);		
		//Check the buffer from the end	
		for (int i = buffLen - magicDirEnd.length - 22; i >= 0; i--)
		{				
			boolean isMagicStart = true;		
			for (int k=0; k < magicDirEnd.length; k++)
			{	
				if (buffer[i + k] != magicDirEnd[k])
				{		
					isMagicStart = false;				
					break;				
				}		
			}				
			if (isMagicStart)
			{					//Magic Start found!		
				int commentLen = buffer[i + 20] + buffer[i + 22] * 256;				
				int realLen = buffLen - i - 22;			


				String comment = new String(buffer, i + 22, Math.min(commentLen, realLen));		
				System.gc();
				return comment;			
			}		
		}				

		return null;
	}
	public  static void addfile(String zipname, String files) throws java.io.IOException
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


