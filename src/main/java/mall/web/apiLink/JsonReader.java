package mall.web.apiLink;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.xml.ws.http.HTTPException;

import org.json.JSONArray;
import org.json.JSONException;
//import org.json.JSONObject;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.apache.commons.lang.StringEscapeUtils;

import com.mysql.cj.x.json.JsonArray;


public class JsonReader {

  private static String readAll(Reader rd) throws IOException {
    StringBuilder sb = new StringBuilder();
    int cp;
    while ((cp = rd.read()) != -1) {
      sb.append((char) cp);
    }
    return sb.toString();
  }

/*  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
    InputStream is = new URL(url).openStream();
    try {
      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
      String jsonText = readAll(rd);
      JSONObject json = new JSONObject(jsonText);
      return json;
    } finally {
      is.close();
    }
  }*/
  
  // get json data
  /*public static JSONObject getJson(String url) {
	  
	JSONObject json = null;
	try {
		json = readJsonFromUrl(url);
	} catch (JSONException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}  
	  
	return json;
	  
  }*/
  
  // post 방식 json 전송
  public static String sendJsonPost(String _url, String msg) throws IOException, JSONException{
	  
	  JSONObject json = null;
	  	  
	  String inputLine = null;
	  StringBuffer outResult = new StringBuffer();
	  
	  try {
		  /*System.out.println("REST API Start");*/
		  URL url = new URL(_url);
		  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		  conn.setDoOutput(true);
		  conn.setRequestMethod("POST");
		  conn.setRequestProperty("Content-Type", "application/json");
		  conn.setRequestProperty("processData", "false");
		  conn.setRequestProperty("Accept-Charset", "UTF-8"); 
		  conn.setConnectTimeout(500000);		  
		  conn.setReadTimeout(500000);		  
		  
		  System.out.println(">>>>>>>>>>>>>>>>>>" + msg.toString().getBytes("UTF-8"));
		  OutputStream os = conn.getOutputStream();
		  os.write(msg.getBytes("UTF-8"));
		  os.flush();
		  		  
		  System.out.println(conn.getResponseCode());
		  System.out.println(conn.getResponseMessage());
		  System.out.println(conn.getErrorStream());
		    

		  InputStreamReader is = new InputStreamReader(conn.getInputStream(), "UTF-8");
		  BufferedReader in = new BufferedReader(is);		  

		  // 리턴된 결과 읽기		  
		  while ((inputLine = in.readLine()) != null) {
			  outResult.append(inputLine);
		  }
	    
		  conn.disconnect();
		  /*System.out.println("REST API END");*/
	  }
	  catch(Exception e){
		  System.out.println(" REST API error");		  
		  e.printStackTrace();
	  }
	  
	  return outResult.toString();
	  	  
  }
  
  public static JSONObject sendJsonPost_Ownerclan(String _url, String Token, String msg) throws IOException, JSONException, Exception{
	  
	  	  
	  String inputLine = null;
	  StringBuffer outResult = new StringBuffer();
	  
	  try {
		  URL url = new URL(_url);
		  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		  conn.setDoOutput(true);
		  conn.setRequestMethod("POST");
		  conn.setRequestProperty("Accept", "application/json");
		  conn.setRequestProperty("Content-Type", "application/json");
		  conn.setDoInput(true); 
		  conn.setRequestProperty("Authorization", "Bearer " + Token); 
		  conn.setConnectTimeout(999999);		  
		  conn.setReadTimeout(999999);	  
		  
		  System.out.println(">>>>>>>>>>>>>>>>>>" + msg.toString().getBytes("UTF-8"));
		  OutputStream os = conn.getOutputStream();
		  os.write(msg.getBytes("UTF-8"));
		  os.flush();
		  		  
		  System.out.println(conn.getResponseCode());
		  System.out.println(conn.getResponseMessage());
		    

		  InputStreamReader is;
		  //정상응답시
		  if(conn.getResponseCode() == 200){
			  //is = new InputStreamReader(conn.getInputStream(), "UTF-8");		  		  
			  is = new InputStreamReader(conn.getInputStream(), "UTF-8");
		  }
		  else{
			  is = new InputStreamReader(conn.getErrorStream(), "UTF-8"); 
		  }
		  
		  BufferedReader in = new BufferedReader(is);
		  
		  //리턴 msg 읽기
		  while ((inputLine = in.readLine()) != null) {
			  outResult.append(inputLine);
		  }		  
		 
		  System.out.println("result>>" + outResult.toString());
	    
		  conn.disconnect();
	  }
	  catch(Exception e){
		  System.out.println(" REST API error");		  
		  e.printStackTrace();
	  }
	  
	  org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();	  
	  JSONObject jobj = (JSONObject) jparser.parse(new StringReader(outResult.toString()));
	  
	  return jobj;
	  	  
  }
  
  public static JSONObject sendJsonGet_Ownerclan(String _url, String Token) throws Exception{
	  
	  String inputLine = null;
	  StringBuffer outResult = new StringBuffer();
	  
	  try {
		  /*System.out.println("REST API Start");*/
		  URL url = new URL(_url);
		  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		  conn.setDoOutput(true);
		  conn.setRequestMethod("GET");
		  conn.setRequestProperty("Accept", "application/json");
		  conn.setRequestProperty("Content-Type", "application/json");
		  conn.setDoInput(true); 
		  conn.setRequestProperty("Authorization", "Bearer " + Token); 
		  conn.setConnectTimeout(999999);		  
		  conn.setReadTimeout(999999);
		  		  
		  System.out.println(conn.getResponseCode());
		  System.out.println(conn.getResponseMessage());
		  
		  InputStreamReader is;
		  //정상응답시
		  if(conn.getResponseCode() == 200){
			  //is = new InputStreamReader(conn.getInputStream(), "UTF-8");		  		  
			  is = new InputStreamReader(conn.getInputStream(), "UTF-8");
		  }
		  else{
			  is = new InputStreamReader(conn.getErrorStream(), "UTF-8"); 
		  }
		  
		  BufferedReader in = new BufferedReader(is);
		  
		  //리턴 msg 읽기
		  while ((inputLine = in.readLine()) != null) {
			  outResult.append(inputLine);
		  }
		  
		  System.out.println("result>>" + outResult.toString());
		
		  conn.disconnect();
		  System.out.println("REST API END");
	  }
	  catch(Exception e){		  
		  System.out.println(" REST API error");
		  e.printStackTrace();
	  }
	  
	  org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();	  
	  JSONObject jobj = (JSONObject) jparser.parse(new StringReader(outResult.toString()));
	  
	  /*return outResult.toString();*/
	  
	  
	  return jobj;
	  
  }
  
  
  /* *************************** 모 든 오 피 스 ************************* */
  
  // 모든오피스 json 전송
  public static JSONObject sendJsonPost_ModenOffice(String _url, String msg) throws IOException, JSONException, Exception{
	  
  	  
	  String inputLine = null;
	  StringBuffer outResult = new StringBuffer();
	  msg = "json=" + msg;
	  System.out.println(msg.getBytes());
	  
	  try {
		  URL url = new URL(_url);
		  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		  conn.setDoOutput(true);
		  conn.setRequestMethod("POST");
		  //conn.setRequestProperty("Accept", "application/json");
		  //conn.setRequestProperty("Content-Type", "application/json");
		  conn.setRequestProperty("content-type", "application/x-www-form-urlencoded");		// ※ 서버에게 웹에서 <Form>으로 값이 넘어온 것과 같은 방식으로 처리하라는 걸 알려준다 
		  conn.setDoInput(true); 
		  conn.setConnectTimeout(999999);		  
		  conn.setReadTimeout(999999);	  
		  
		  System.out.println(">>>>>>>>>>>>>>>>>>" + msg.toString()/*.getBytes("UTF-8")*/);
		  OutputStream os = conn.getOutputStream();
		  //os.write(msg.getBytes("UTF-8"));
		  os.write(msg.getBytes("UTF-8"));
		  os.flush();
		  		  
		  System.out.println(conn.getResponseCode());
		  System.out.println(conn.getResponseMessage());
		  System.out.println(conn.getContent());
		    

		  InputStreamReader is;
		  //정상응답시
		  if(conn.getResponseCode() == 200){
			  //is = new InputStreamReader(conn.getInputStream(), "UTF-8");		  		  
			  is = new InputStreamReader(conn.getInputStream(), "UTF-8");
		  }
		  else{
			  is = new InputStreamReader(conn.getErrorStream(), "UTF-8"); 
		  }
		  
		  BufferedReader in = new BufferedReader(is);
		  
		  //리턴 msg 읽기
		  while ((inputLine = in.readLine()) != null) {
			  outResult.append(inputLine);
		  }		  
		 
		  System.out.println("result>>" + outResult.toString());
	    
		  conn.disconnect();
	  }
	  catch(Exception e){
		  System.out.println(" REST API error");		  
		  e.printStackTrace();
	  }
	  
	  org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();	  
	  JSONObject jobj = (JSONObject) jparser.parse(new StringReader(outResult.toString()));
	  
	  return jobj;
	  	  
  }
  
  
  public static JSONObject sendJsonGet_ModenOffice(String _url) throws Exception{
	  
	  String inputLine = null;
	  StringBuffer outResult = new StringBuffer();
	  
	  try {
		  /*System.out.println("REST API Start");*/
		  URL url = new URL(_url);
		  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		  conn.setDoOutput(true);
		  conn.setRequestMethod("GET");
		  conn.setRequestProperty("Accept", "application/json");
		  conn.setRequestProperty("Content-Type", "application/json");
		  conn.setDoInput(true); 
		  //conn.setRequestProperty("Authorization", "Bearer " + Token); 
		  conn.setConnectTimeout(999999);		  
		  conn.setReadTimeout(999999);
		  		  
		  System.out.println(conn.getResponseCode());
		  System.out.println(conn.getResponseMessage());
		  
		  InputStreamReader is;
		  //정상응답시
		  if(conn.getResponseCode() == 200){
			  //is = new InputStreamReader(conn.getInputStream(), "UTF-8");		  		  
			  is = new InputStreamReader(conn.getInputStream(), "UTF-8");
		  }
		  else{
			  is = new InputStreamReader(conn.getErrorStream(), "UTF-8"); 
		  }
		  
		  BufferedReader in = new BufferedReader(is);
		  
		  //리턴 msg 읽기
		  while ((inputLine = in.readLine()) != null) {
			  outResult.append(inputLine);
		  }
		  System.out.println("ModenOffice result>>" + outResult.toString());
		
		  conn.disconnect();
		  System.out.println("ModenOffice REST API END");
	  }
	  catch(Exception e){		  
		  System.out.println("ModenOffice REST API error");
		  e.printStackTrace();
	  }
	  
	  System.out.println("1111>>"+ java.net.URLDecoder.decode(outResult.toString(), "UTF-8") );
	  
	  org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();	  
	  JSONObject jobj = (JSONObject) jparser.parse(new StringReader( outResult.toString() ));
	  
	  //System.out.println("asdasd>>"+jobj.toString());
	  
	  /*return outResult.toString();*/
	  
	  
	  return jobj;
	  
  }
  
  
  
  
  
  
  
  
  /* *************************************************************** */

	//URI형식 인코딩
	public static String encodeURIComponent(String s)
	{
	  String result = null;
	
	  try
	  {
	    result = URLEncoder.encode(s, "UTF-8")
	                       .replaceAll("\\+", "%20")
	                       .replaceAll("\\%21", "!")
	                       .replaceAll("\\%27", "'")
	                       .replaceAll("\\%28", "(")
	                       .replaceAll("\\%29", ")")
	                       .replaceAll("\\%7E", "~");
	  }
	
	  // This exception should never occur.
	  catch (UnsupportedEncodingException e)
	  {
	    result = s;
	  }
	
	  return result;
	}

  public static void main(String[] args) throws IOException, JSONException {    
  }
}