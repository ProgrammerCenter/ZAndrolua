package com.androlua;
import com.zajt.*;
import android.content.Intent;
import android.os.Bundle;
import  java.io.*;
import java.io.File;
import android.content.*;
import android.net.*;
public class Main extends LuaActivity
{
	private Uri MopenFile=null;
public  void traverseByListFiles(File srcFile,File desFile) throws IOException
{
    if(srcFile.isDirectory())
		
    {
		
        File[] files = srcFile.listFiles();
        assert files != null;
        for(File file : files)
        {
            File desFileOrDir = new File(desFile.getAbsolutePath() + File.separator + file.getName());
            if(file.isDirectory())
            {
                if(desFileOrDir.exists())
                    desFileOrDir.delete();
                desFileOrDir.mkdirs();
            }
            traverseByListFiles(file, desFileOrDir);
        }
    }
    else 
    {
        copyFile(srcFile, desFile);
    }
}

	
public   void copyFile(File fromFile, File toFile) throws FileNotFoundException {
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            inputStream = new BufferedInputStream(new FileInputStream(fromFile));
            outputStream = new BufferedOutputStream(new FileOutputStream(toFile));
            byte[] bytes = new byte[1024];
            int i;
            //读取到输入流数据，然后写入到输出流中去，实现复制
            while ((i = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null)
                    inputStream.close();
                if (outputStream != null)
                    outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
	@Override
	public void onCreate(Bundle savedInstanceState) {
		if(getIntent().getData()!=null){
			
		MopenFile=getIntent().getData();}
		
		super.onCreate(savedInstanceState);
		if(savedInstanceState==null && getIntent().getData()!=null)
			runFunc("onNewIntent", getIntent());
			
		if(getIntent().getBooleanExtra("isVersionChanged",false) && (savedInstanceState==null)){
			onVersionChanged(getIntent().getStringExtra("newVersionName"),getIntent().getStringExtra("oldVersionName"));
		}
	}

	@Override
	protected void onNewIntent(Intent intent)
	{
	
		// TODO: Implement this method
		runFunc("onNewIntent", intent);
		super.onNewIntent(intent);
	}
	
	@Override
	public String getLuaDir()
	{
		// TODO: Implement this method
		return getLocalDir();
	}

	@Override
	public String getLuaPath()
	{
		// TODO: Implement this method
		initMain();
		return getLocalDir()+"/main.lua";
	}

	private void onVersionChanged(String newVersionName, String oldVersionName) {
		// TODO: Implement this method
		runFunc("onVersionChanged", newVersionName, oldVersionName);

	}



}
