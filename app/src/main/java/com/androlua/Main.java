package com.androlua;
import com.zajt.*;
import android.content.Intent;
import android.os.Bundle;
import  java.io.*;
import java.io.File;
import android.content.*;
import android.net.*;
import android.widget.*;
public class Main extends LuaActivity
{
	private Uri MopenFile=null;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		if(getIntent().getData()!=null){
		MopenFile=getIntent().getData();
		}
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
