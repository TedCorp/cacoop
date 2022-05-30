package mall.common.util;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartFile;

/** 
* @author Ji-won Chang (Chjw@youngthink.co.kr)
* 전단 Util
*/
public class JunDanUtil {
	
    /*
     * 전단 디렉토리 파일 리스트 -------- 사용안함
     */
    public static String jundanDirList(HttpServletRequest request, String vewInf) throws Exception
    {
    	// 파일 객체 생성
    	String listPath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;
		File dir = new File(listPath); 

		// 디렉토리가 없다면 디렉토리 생성
		if(dir.isDirectory() == false){			
			dir.mkdirs();
		}
		
		// 1. check if the file exists or not
        boolean isExists = dir.exists();
        
        if(!isExists) {
            System.out.println("There is nothing.");
        }
        
        // 2. check if the object is directory or not.
        if(dir.isDirectory()) {
            File[] fileList = dir.listFiles();
            for(File tFile : fileList) {
                System.out.print(tFile.getName());             
                if(tFile.isDirectory()) {
                    System.out.print(" is ");
                    System.out.println("a directory.");
                } else {
                    System.out.print(" is ");
                    System.out.println("a file.");
                }
            }          
        } else {
            System.out.println("It is not a directory.");
        }

		/*
		try{
				if(dir.isFile()){
					// 파일이 있다면 파일 이름 출력
					System.out.println("\t 파일 이름 = " + dir.getName());
				}else if(dir.isDirectory()){
					System.out.println("디렉토리 이름 = " + dir.getName());

					// 서브디렉토리가 존재하면 재귀적 방법으로 다시 탐색
					jundanDirList(request, dir.getName());
				}else{
					System.out.println("경로가 존재하지 않습니다");
				}
		}catch(IOException e){
			
		}
		*/
		return dir.getCanonicalPath().toString();
	}
    
    /*
     * 전단 디렉토리 파일 Count
     */
    public static int jundanFileCnt(HttpServletRequest request, String vewInf) throws Exception
    {    	
    	int result = 0;
    	String listPath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf;
    
    	// 파일 객체 생성
		File dir = new File(listPath);
		File[] fileList = dir.listFiles();

		// 디렉토리 여부 체크
        boolean isExists = dir.exists();
        
        // 디렉토리가 없다면 디렉토리 생성
        if(!isExists) {	//dir.isDirectory() == false	
            System.out.println("There is nothing."+dir.exists());
            dir.mkdirs();
        }        
		
        // 파일 Count
        if(fileList != null){
        	for(File tempFile : fileList) {
				if(tempFile.isFile()) {
					//System.out.println("Path="+tempFile.getParent()+" || FileName="+tempFile.getName());
					
					result ++;
				}
        	}
        }        
        
		return result;
	}

    /**
     * 전단 기존파일 이동
     * upload/{vewInf}/YYYYMMDD 디렉토리로 이동 : ----------- 현재날짜 폴더로 이동하고자 할때 사용 
     * 이동 디렉토리 MovefolerName를 입력받아서 처리
     * 파일 이동 후 파일이동경로 반환
     */
    public static String jundanFileMove(String currentPath, String MovefolerName, String originalFileName) throws Exception
    {
		String MovefolderName = MovefolerName;								// 폴더 생성할 이름
    	String beforeFilePath = currentPath + originalFileName;			// 옮길 대상 경로
    	String afterFilePath = currentPath + MovefolderName;				// 옮겨질 경로
    	String fileExtsn = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());	//확장자
    	
		//System.out.println( MovefolderName );		
		//System.out.println( beforeFilePath );
		//System.out.println( afterFilePath );
		
    	// 파일 객체 생성
		File dir = new File(afterFilePath); 
				
		// 옮겨질 디렉토리 존재여부 확인
		if (dir.isDirectory() == false) {
			dir.mkdirs();	// 없다면 폴더생성
		}
		if (!afterFilePath.substring(afterFilePath.length()-1,afterFilePath.length()).equals("/")) {
			afterFilePath += "/";
		}
		
        try{
        	// 생성된 폴더에 이미지 옮기기
            Path file = Paths.get(beforeFilePath);
            Path move = Paths.get(afterFilePath);
            Files.move(file , move.resolve(file.getFileName()));
            
            //System.out.println("File moved to: " + file);
            //System.out.println("File moved exits: " + Files.exists(move));
            //System.out.println("File to move exits: " + Files.exists(file));
            
        }catch(Exception e){
            e.printStackTrace();
            return null;				//에러날 경우 null 반환 
        }
        
        return afterFilePath;		//성공시 성공 파일 경로 return
	}

    /**
     * 전단파일 업로드
     * upload/{vewInf}/ 디렉토리에 저장 : ----------- 특정이름으로 저장하고자 할때 사용 
     * 저장 디렉토리{vewInf}를 입력받아서 처리
     * 파일 저장 후 저장파일명 반환
     */
    public static String jundanFileUpload(HttpServletRequest request, MultipartFile file, String vewInf, String saveName) throws Exception
    {	
    	// 년월일시분초밀리초 파일명 생성
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssS"); 
		InputStream is = null;
		Date d = gc.getTime(); 
		
		// 기존파일명
		String originalFileName = file.getOriginalFilename();
		String fileExtsn = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());		//확장자
		
		// 파일저장위치 및 이름 설정
		String savePath = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
		String saveFileName = savePath + saveName + sf.format(d) + fileExtsn;
		
		// 파일 객체생성
		File path = new File(savePath);
		// 디렉토리 체크
		if (path.isDirectory() == false) {
			path.mkdirs();		//디렉토리 생성
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
     * 파일 삭제 : upload/{vewInf}/ 디렉토리에 저장된 파일삭제 test ---------- 사용안함
     */
    public static boolean deleteTest2(HttpServletRequest request, String vewInf, String saveName) throws Exception
    {
    	String path = "E:/";
    	saveName = "123.txt";
    	boolean result = false;
    	
    	File file = new File(path+saveName);
        
        if( file.exists() ){
            if(file.delete()){
                System.out.println("파일삭제 성공");
                result =  true;
            }else{
                System.out.println("파일삭제 실패");
                result =  false;
            }
        }else{
            System.out.println("파일이 존재하지 않습니다.");
            result =  false;
        }
        
        return result;
    }

    /**
     * 파일 삭제 : upload/{vewInf}/ 디렉토리에 저장된 파일삭제 
     */
    public static boolean deleteFile2(HttpServletRequest request, String vewInf, String saveName) throws Exception
    {	
    	boolean result = false;
    	String path = (request.getSession().getServletContext().getRealPath("/")).replace("\\", "/") + "upload/" + vewInf + File.separator;
    	
    	if (!path.substring(path.length()-1,path.length()).equals("/")) {
    		path += "/";
		}
    	
		try {
			File file = new File(path+saveName);
			
			while(file.exists()) {
				if(file.isDirectory()){
					File[] folder_list = file.listFiles(); 	//파일리스트 얻어오기
					// 파일 또는 디렉토리 내 파일 삭제		
					for (int j = 0; j < folder_list.length; j++) {
						result = folder_list[j].delete(); //파일 삭제 
						System.out.println(folder_list[j].getName()+" 파일이 삭제되었습니다.");
					}
					// 비워진 폴더 삭제
					if(folder_list.length == 0 && file.isDirectory()){ 
						result = file.delete(); 
						System.out.println(file.getName()+" 폴더가 삭제되었습니다.");
					}
				}else if(file.isFile()){
					result = file.delete(); 
					System.out.println(file.getName()+" 파일이 삭제되었습니다.");
				}
			}
			
			/*
			 * 파일만 삭제됨 폴더삭제X------ 사용안함
			 * 
			if(file.exists()){
				if(file.isDirectory()){
					//파일리스트 가져오기
					File[] fileDel = file.listFiles();
					
					for(int i=0; i<fileDel.length; i++){
						//파일 여부 확인
						if(fileDel[i].isFile()){
							result = fileDel[i].delete();
							System.out.println(fileDel[i].getName()+" 파일삭제 성공");
							
						//디렉토리 여부 확인
						}else if(fileDel[i].isDirectory()){
							String dirInf = fileDel[i].getParent().substring(fileDel[i].getParent().indexOf("upload/"), fileDel[i].getParent().lastIndexOf("/"));
							System.out.println(dirInf);
							deleteFile2(request, dirInf, fileDel[i].getName());	//재귀함수호출
							System.out.println(fileDel[i].getName()+"폴더");
						}
					}
				}else if(file.isFile()){
					//파일 삭제
					result = file.delete();
					System.out.println(file.length());
				}
			}
			*/
		} catch (Exception e) {
			System.out.println("error : 파일삭제 실패");
		}
		
		return result;    	
	}
    
}
