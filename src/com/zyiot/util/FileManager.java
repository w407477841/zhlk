package com.zyiot.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传
 * 
 * @param 获取到的文件对象
 * @param 路径
 * */
public class FileManager {
	public static int upFile(MultipartFile file, String target) {
		try {
			File path = new File(target);
			if (!path.exists() && !path.isDirectory()) {
				path.mkdirs();
			}
			FileOutputStream out = new FileOutputStream(target + "\\"
					+ file.getOriginalFilename());
			InputStream in = file.getInputStream();
			byte buffer[] = new byte[1024];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
			in.close();
			out.close();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	public static int upFile(MultipartFile file, String target,String fileName) {
		try {
			File path = new File(target);
			if (!path.exists() && !path.isDirectory()) {
				path.mkdirs();
			}
			
			
			FileOutputStream out = new FileOutputStream(target + "\\"
					+ fileName);
			InputStream in = file.getInputStream();
			byte buffer[] = new byte[1024];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
			in.close();
			out.close();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public static int download(String path,String filename,HttpServletResponse response) throws UnsupportedEncodingException {
		FileInputStream in = null;
		OutputStream out = null;
		response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
		try {
			File file = new File(path + "\\" + filename);
			if(!file.exists()){
				return 0;
			}
			 in = new FileInputStream(path + "\\" + filename);
			 out = response.getOutputStream();
			byte buffer[] = new byte[1024];
			int len = 0;
			while((len=in.read(buffer))>0){
				out.write(buffer, 0, len);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				in.close();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return 1;
	}
	public static void main(String[] args) {
		try {
			String target="D:/upload/upload";
			File path = new File(target);
			if (!path.exists() && !path.isDirectory()) {
				path.mkdir();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
