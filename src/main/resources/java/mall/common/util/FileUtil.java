package mall.common.util;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartFile;



public class FileUtil {
	
    /**
     *  파일 저장
     * "temp" 디렉토리에 저장  : ----------- 엑셀업로드시 사용
     */
    public static String saveFile(HttpServletRequest request, MultipartFile file) throws Exception
    {
    	// 년월일시분초밀리초 파일명 생성		
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssS"); 
		InputStream is = null;
		Date d = gc.getTime(); 
    	
		String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "temp" + File.separator;
		String saveFileName = savePath + sf.format(d) + file.getOriginalFilename();
		
		File path = new File(savePath);
		if (path.isDirectory() == false) {
			path.mkdirs();
		}
		if (!savePath.substring(savePath.length()-1,savePath.length()).equals("/")) {
			savePath += "/";
		}

		try {
			byte[] bytes = file.getBytes();
				
			DataOutputStream fw = new DataOutputStream(new FileOutputStream(saveFileName, false));
			fw.write(bytes);
			fw.flush();
			fw.close();
		} catch (IOException e){
			e.printStackTrace();
			return null;
		}
				
		return saveFileName;
	}
    
    /**
     * upload/{vewInf}/ 디렉토리에 저장 : ----------- 게시판등에 파일 업로드시 사용
     * 저장 디렉토리{vewInf}를 입력받아서 처리
     * 중복된 파일이름을 방지하기위해서 파일이름 변경
     * 파일 저장 후 저장파일명 반환
     */
    public static String saveFile2(HttpServletRequest request, MultipartFile file, String vewInf, Boolean bOriginalFilename) throws Exception
    {
    	// 년월일시분초밀리초 파일명 생성		
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssS"); 
		InputStream is = null;
		Date d = gc.getTime(); 

		String originalFileName = file.getOriginalFilename();
		String fileExtsn = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
		
		// 파일저장위치 및 이름 설정
		String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
		
		String saveFileName = savePath + sf.format(d) + fileExtsn;
		
		if(bOriginalFilename){
			saveFileName = savePath + originalFileName;
		}
		
		// 파일 저장
		File path = new File(savePath);
		if (path.isDirectory() == false) {
			path.mkdirs();
		}
		if (!savePath.substring(savePath.length()-1,savePath.length()).equals("/")) {
			savePath += "/";
		}

		try {
			byte[] bytes = file.getBytes();
				
			DataOutputStream fw = new DataOutputStream(new FileOutputStream(saveFileName, false));
			fw.write(bytes);
			fw.flush();
			fw.close();
		} catch (IOException e){
			e.printStackTrace();
			return null;
		}
				
		return sf.format(d) + fileExtsn;
		//return saveFileName;
	}
    
    /**
     * upload/{vewInf}/ 디렉토리에 저장 : ----------- 특정이름으로 저장하고자 할때 사용 
     * 저장 디렉토리{vewInf}를 입력받아서 처리
     * 파일 저장 후 저장파일명 반환
     */
    public static String saveFile3(HttpServletRequest request, MultipartFile file, String vewInf, String saveName) throws Exception
    {	
		// 파일저장위치 및 이름 설정
		String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
		String saveFileName = savePath + saveName;
		
		// 파일 저장
		File path = new File(savePath);
		if (path.isDirectory() == false) {
			path.mkdirs();
		}
		if (!savePath.substring(savePath.length()-1,savePath.length()).equals("/")) {
			savePath += "/";
		}

		try {
			byte[] bytes = file.getBytes();
				
			DataOutputStream fw = new DataOutputStream(new FileOutputStream(saveFileName, false));
			fw.write(bytes);
			fw.flush();
			fw.close();
		} catch (IOException e){
			e.printStackTrace();
			return null;
		}
				
		return saveName;
	}
    
    public static String saveFile4(HttpServletRequest request, MultipartFile file, String vewInf, String fileSeqNo, int fileOrdr) throws Exception
    {    	    	
		// 파일저장위치 및 이름 설정
		String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
		
		String originalFileName = file.getOriginalFilename();
		String fileExtsn = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
		String fileSize = Long.toString(file.getSize());
		String lpadTxt = "";
		
		// lpad 기능
		int max = 11 - fileSeqNo.length();
		if(max <= 11) {
			for(int i=0; i<max; i++) {
				lpadTxt = "0"+lpadTxt;
			}			
		}
		
		String virFileName = lpadTxt+fileSeqNo.trim();

		// 파일 저장
		File path = new File(savePath);
		if (path.isDirectory() == false) {
			path.mkdirs();
		}
		if (!savePath.substring(savePath.length()-1,savePath.length()).equals("/")) {
			savePath += "/";
		}

		try {
			byte[] bytes = file.getBytes();
				
			DataOutputStream fw = new DataOutputStream(new FileOutputStream(savePath+virFileName+"_"+fileOrdr+fileExtsn, false));
			fw.write(bytes);
			fw.flush();
			fw.close();
		} catch (IOException e){
			e.printStackTrace();
			return null;
		}
				
		return originalFileName+"/"+fileSize;		
	}

    /**
     * 파일 삭제 : "temp" 디렉토리에 저장된 파일삭제 - 엑셀업로드시 임시파일삭제에 사용
     */
    public static void deleteFile(String fileName) throws Exception
    {
    	File fileDel = new File(fileName);
		fileDel.delete();    	
	}
 
    
    /**
     * 파일 삭제 : upload/{vewInf}/ 디렉토리에 저장된 파일삭제 
     */
    public static void deleteFile2(HttpServletRequest request, String vewInf, String saveFileName) throws Exception
    {	
    	String path = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
 
		try {
			File fileDel = new File(path+saveFileName);
			fileDel.delete();			
		} catch (Exception e) {
			System.out.println("파일삭제 실패");
		}
    	
	}
    
    
    /*
     * 엑셀파일 다운로드 
     */   
    public static void downExcelFile(HttpServletRequest request,HttpServletResponse response, String fileName ) throws UnsupportedEncodingException{
    response.reset();
	response.setContentType("application/vnd.ms-excel; charset=UTF-8");

	//사용자 브라우저 타입 얻어오기
	String userCharset = request.getCharacterEncoding();
	String strAgent = request.getHeader("User-Agent");
	String value = "";

	//IE 일 경우
	if (strAgent.indexOf("MSIE") > -1) {
		// IE 5.5 일 경우
		if (strAgent.indexOf("MSIE 5.5") > -1) {
			value = "filename=" + fileName;
		}
		//그밖에
		else {
			if (userCharset.equalsIgnoreCase("UTF-8")) {
				String filename = URLEncoder.encode(fileName, userCharset);
				value = "attachment; filename=\"" + filename + "\"";
			}
			else
			{
				value = "attachment; filename=" + new String(fileName.getBytes(userCharset), "ISO-8859-1");
			}
		}
	} else {
		//IE 를 제외한 브라우저
		value = "attachment; filename=" + new String(fileName.getBytes(), "ISO-8859-1");
	}

	response.setHeader("Content-Disposition", value);
    }
 
    
    /*
     * 일반파일 다운로드  : 파일명을 입력 받는다. 
     */       
    public static void downFile(HttpServletRequest request, HttpServletResponse response, String fileName) throws ServletException, IOException{

    	// 경로 가져오기
    	String savePath = request.getSession().getServletContext().getRealPath("/upload/");
    	
    	File file = new File(savePath + "/" +  fileName);
    	
    	System.out.println("파일명 : " + fileName) ;
    	
    	// MINETYPE 설정하기
    	String mimeType = request.getSession().getServletContext().getMimeType(file.toString());
    	if(mimeType == null){
    		response.setContentType("application/octet-stream");    		
    	}
    	
    	// 다우로드용 파일 명을 설정
    	String downName = null;
    	if(request.getHeader("user-agent").indexOf("MSIE")== -1){
    		downName = new String(fileName.getBytes("UTF-8"), "8859_1");
    	}
    	else
    	{
    		downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
    	}
    	
    	// 무조건 다운로드 하도록 설정
    	response.setHeader("Content-Disposition", "attachment;filename=\"" + downName + "\";");
    	
    	// 요청된 파일으 ㄹ읽어서 클라이언트쪽으로 저장한다.
    	FileInputStream fis = new FileInputStream(file);
    	ServletOutputStream sos = response.getOutputStream();
    	
    	byte b[] = new byte[1024];
    	
    	int data=0;
    	
    	while((data=(fis.read(b,0, b.length))) != -1){
    		sos.write(b,0,data);
    	}
    	
    	
    	sos.flush();
    	sos.close();
    	fis.close();
    }
    
    /*
     * 원본파일과 저장파일명이 다를때 다운로드  : 저장파일명과 원본파일명을 입력 받는다. 
     */       
    public static void downFile2(HttpServletRequest request, HttpServletResponse response, String vewInf, String fileSaveName, String fileName) throws ServletException, IOException{

    	// 경로 가져오기
    	String savePath = request.getSession().getServletContext().getRealPath("/upload/"+ vewInf + "/");
    	
    	File file = new File(savePath+fileSaveName);
    	
    	System.out.println("다운로드파일 : " + savePath+fileSaveName) ;
    	
    	// MINETYPE 설정하기
    	String mimeType = request.getSession().getServletContext().getMimeType(file.toString());
    	if(mimeType == null){
    		response.setContentType("application/octet-stream");    		
    	}
    	
    	// 다우로드용 파일 명을 설정
    	String downName = null;
    	if(request.getHeader("user-agent").indexOf("MSIE")== -1){
    		downName = new String(fileName.getBytes("UTF-8"), "8859_1");
    	}
    	else
    	{
    		downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
    	}
    	
    	// 무조건 다운로드 하도록 설정
    	response.setHeader("Content-Disposition", "attachment;filename=\"" + downName + "\";");
    	
    	// 요청된 파일으 ㄹ읽어서 클라이언트쪽으로 저장한다.
    	FileInputStream fis = new FileInputStream(file);
    	ServletOutputStream sos = response.getOutputStream();
    	
    	byte b[] = new byte[1024];
    	
    	int data=0;
    	
    	while((data=(fis.read(b,0, b.length))) != -1){
    		sos.write(b,0,data);
    	}
    	
    	
    	sos.flush();
    	sos.close();
    	fis.close();
    }
}
