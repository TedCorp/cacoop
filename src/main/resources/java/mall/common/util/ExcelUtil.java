package mall.common.util;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

/**
 * 문자열 처리 유틸리티
 */
public class ExcelUtil
{
	public static Map ConverObjectToMap(Object obj){
		try { 
				//Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음. 
				Field[] fields = obj.getClass().getDeclaredFields(); 
				Map resultMap = new HashMap(); 
				for(int i=0; i<=fields.length-1;i++){
					fields[i].setAccessible(true); 
					resultMap.put(fields[i].getName(), fields[i].get(obj)); 
				} 
				return resultMap; 
			} catch (IllegalArgumentException e) { 
				e.printStackTrace(); 
			} catch (IllegalAccessException e) { 
				e.printStackTrace(); 
			} 
			return null; 
		
	}
	
}
