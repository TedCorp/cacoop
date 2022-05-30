package mall.common.util;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelDownload {


	/*****************************************************************
	 * excelDownload 목록 엑셀 다운로드
	 * @param excelDataList
	 * @param headerName
	 * @param columnName
	 * @param sheetName
	*******************************************************************/
	public static void excelDownload(HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[] headerName, String[] columnName, String sheetName){

		// Workbook 및 Helper 생성
		
		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} 
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		BufferedOutputStream fileOut = null;
		try {
			fileOut = new BufferedOutputStream(response.getOutputStream());
	
			int rowIndex = 0;
			int cellIndex = 0;
			
			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)420);
			
			for(int i = 0; i < headerName.length; i++){
				cell = row.createCell(cellIndex++);
				cell.setCellValue(headerName[i]);
				cell.setCellStyle(styles.get("default_header_style"));
				hssfSheet.setColumnWidth(i, 6000);
			}
			
			
			for(int i=0; i<excelDataList.size(); i++){
			
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					String key = columnName[j].toString().toUpperCase();
					Object objData = excelDataList.get(i).get(key);
					String strData = StringUtil.nullCheck(String.valueOf(excelDataList.get(i).get(key)));
					
					int nDataType = 0;
					String strStyle = "default_content_style";

					cell = row.createCell(cellIndex++);
					if(objData != null){
						String strObjType = objData.getClass().getName();
						//strObjType 타입확인 후 추가
						//System.out.println("strObjType : " + strObjType);
						if(strObjType.indexOf("Decimal") >= 0){
							strStyle = "number_content_style";
							
							double dData = Double.parseDouble(strData);
							cell.setCellValue(dData);
							cell.setCellType(Cell.CELL_TYPE_NUMERIC);
						}else{
							cell.setCellValue(strData);
						}
					}else{
						cell.setCellValue(strData);
					}
					
					cell.setCellStyle(styles.get(strStyle));
				}
				
			}
			
			wb.write(fileOut);
			
		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}finally{
			if(fileOut != null){
				try {
					fileOut.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/*****************************************************************
	 * excelTypeDownload 목록 엑셀 다운로드 - 주문내역용
	 * @param excelDataList
	 * @param headerName
	 * @param columnName
	 * @param sheetName
	*******************************************************************/
	public static void excelDownloadOrder(HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[] headerName, String[] columnName, String sheetName){

		// Workbook 및 Helper 생성
		
		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} 
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		BufferedOutputStream fileOut = null;
		try {
			fileOut = new BufferedOutputStream(response.getOutputStream());
	
			int rowIndex = 0;
			int cellIndex = 0;
			
			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)420);
			
			for(int i = 0; i < headerName.length; i++){
				cell = row.createCell(cellIndex++);
				cell.setCellValue(headerName[i]);
				cell.setCellStyle(styles.get("default_header_style"));
				
				if(headerName[i].equals("배송주소")){
					hssfSheet.setColumnWidth(i, 15000);
				}else{
					hssfSheet.setColumnWidth(i, 6000);
				}
			}
			
			String strPreOrder = "";
			boolean bChk= true;
			for(int i=0; i<excelDataList.size(); i++){
			
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					String key = columnName[j].toString().toUpperCase();
					Object objData = excelDataList.get(i).get(key);
					String strData = StringUtil.nullCheck(String.valueOf(excelDataList.get(i).get(key)));

					String strStyle = "default_content_style";

					cell = row.createCell(cellIndex++);
					if(objData != null){
						String strObjType = objData.getClass().getName();
						//strObjType 타입확인 후 추가
						//System.out.println("strObjType : " + strObjType);
						if(strObjType.indexOf("Decimal") >= 0){
							strStyle = "number_content_style";
							
							double dData = Double.parseDouble(strData);
							cell.setCellValue(dData);
							cell.setCellType(Cell.CELL_TYPE_NUMERIC);
						}else{
							cell.setCellValue(strData);
						}
					}else{
						cell.setCellValue(strData);
					}
					
					if(j == 0 && !strPreOrder.equals( StringUtil.nullCheck(String.valueOf(excelDataList.get(i).get("ORDER_NUM"))) )){
						bChk = !bChk;
					}

					if(bChk){
						strStyle = strStyle + "1";
					}
					
					CellStyle style = styles.get(strStyle);
					cell.setCellStyle(style);
				}
				
				strPreOrder = StringUtil.nullCheck(String.valueOf(excelDataList.get(i).get("ORDER_NUM")));
				
			}
			
			wb.write(fileOut);
			
		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}finally{
			if(fileOut != null){
				try {
					fileOut.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	// 엑셀 스타일
	private static Map<String, CellStyle> createStyles(Workbook wb) {
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		DataFormat df = wb.createDataFormat();

		CellStyle style;
		Font headerFont = wb.createFont();
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);

		Font font1 = wb.createFont();
		font1.setBoldweight(Font.BOLDWEIGHT_BOLD);

		Font font2 = wb.createFont();
		font2.setBoldweight(Font.BOLDWEIGHT_NORMAL);

		// 현재 사용하고 있는 스타일
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font1);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setFillBackgroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
		style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());    
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		styles.put("default_header_style", style);

		// 현재 사용하고 있는 스타일
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font2);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		styles.put("default_content_style", style);


		// 숫자형
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font2);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN); 
		style.setDataFormat(df.getFormat("#,###,##0"));
		styles.put("number_content_style", style);
		

		// 현재 사용하고 있는 스타일
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font2);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setFillBackgroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());    
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		styles.put("default_content_style1", style);


		// 숫자형
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font2);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN); 
		style.setFillBackgroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());    
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setDataFormat(df.getFormat("#,###,##0"));
		styles.put("number_content_style1", style);
		
		return styles;
	}

	// 셀의 Border스타일을 정의한다.
	private static CellStyle createBorderedStyle(Workbook wb) {
		CellStyle style = wb.createCellStyle();
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		return style;
	}
}
