package mall.common.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;

public class DanalFunction2 {

	/*****************************************************
	 * 다날 계좌이체 결제
	 *****************************************************/

	/*****************************************************
	 * 연동에 필요한 Function 및 변수값 설정
	 *
	 * 연동에 대한 문의사항 있으시면 아래 메일주소로 연락 주십시오.
	 * DANAL Commerce Division Technique supporting Team 
	 * EMail : trans_tech@danal.co.kr	 
	 ******************************************************/

	/******************************************************
	 *  DN_TX_URL	: 결제 서버 정의
	 ******************************************************/
	//private static final String DN_TX_URL = "https://tx-wiretransfer.danalpay.com/bank/";
	private String DN_BANK_URL = "https://tx-wiretransfer.danalpay.com/bank/";

	/******************************************************
	 *  Set Timeout
	 ******************************************************/
	private static final int DN_CONNECT_TIMEOUT = 5000;
	private static final int DN_TIMEOUT = 30000; //SO_Timeout setting

	private static final String ERC_NETWORK_ERROR = "-1";
	private static final String ERM_NETWORK = "Network Error";

	/******************************************************
	 * CPID		: 다날에서 제공해 드린 CPID
	 * CRYPTOKEY	: 다날에서 제공해 드린 암복호화 PW
	******************************************************/
	private String CPID = "XXXXX"; //영업담당자에게 문의
	private String CRYPTOKEY = "XXXXX"; //영업담당자에게 문의
	private String IV = "31363032313523404542616e6b456e63"; // 고정값. 수정하지 마시오.
	
	public String CHARSET = "EUC-KR";
	//public String TEST_AMOUNT = "1004";
	
	public DanalFunction2(String strMode, String strDN_CREDIT_URL, String strCPID, String strCRYPTOKEY){
		this.DN_BANK_URL = strDN_CREDIT_URL;
		this.CPID = strCPID;
		this.CRYPTOKEY = strCRYPTOKEY;
		
		if(strMode.equals("test")){
			this.CPID = "A010002002";//this.CPID = "9810030929";//this.CPID = "9810030929";
			this.CRYPTOKEY = "20ad459ab1ad2f6e541929d50d24765abb05850094a9629041bebb726814625d";
		}
	}

//	public Map CallDanalBank(Map REQ_DATA, boolean Debug) {
//
//		String REQ_STR = toEncrypt(data2str(REQ_DATA));
//		REQ_STR = "CPID=" + CPID + "&DATA=" + REQ_STR;
//
//		HttpClient hc = new HttpClient();
//		hc.setConnectionTimeout(DN_CONNECT_TIMEOUT);
//		hc.setTimeout(DN_TIMEOUT);
//
//		int Result = hc.retrieve("POST", DN_BANK_URL, REQ_STR, CHARSET, CHARSET);
//
//		String RES_STR = "";
//		if (Result == HttpClient.EOK && hc.getResponseCode() == 200) {
//			RES_STR = hc.getResponseBody();
//		} else {
//			RES_STR = "RETURNCODE=" + ERC_NETWORK_ERROR + "&RETURNMSG="
//					+ ERM_NETWORK + "( " + Result + "/" + hc.getResponseCode()
//					+ " )";
//		}
//
//		if (Debug) {
//			System.out.println("ReqData[" + data2str(REQ_DATA) + "]");
//			System.out.println("Req[" + REQ_STR + "]");
//			System.out.println("Ret[" + Result + "/" + hc.getResponseCode() + "]");
//			System.out.println("Res[" + RES_STR + "]");
//		}
//
//		Map resMap = str2data(RES_STR);
//		RES_STR = toDecrypt((String) resMap.get("DATA"));
//		return str2data(RES_STR);
//	}

	public Map str2data(String str) {
		Map map = new HashMap();
		String[] st = str.split("&");

		for (int i = 0; i < st.length; i++) {
			int index = st[i].indexOf('=');
			if (index > 0)
				map.put(st[i].substring(0, index), urlDecode(st[i].substring(index + 1)));
		}

		return map;
	}

	public String data2str(Map data) {
		Iterator i = data.keySet().iterator();
		StringBuffer sb = new StringBuffer();
		while (i.hasNext()) {
			Object key = i.next();
			Object value = data.get(key);

			sb.append(key.toString());
			sb.append('=');
			sb.append(urlEncode(value.toString()));
			sb.append('&');
		}

		if (sb.length() > 0) {
			return sb.substring(0, sb.length() - 1);
		} else {
			return "";
		}
	}
	
	public Map getReqMap(HttpServletRequest req) {
		Map reqMap = req.getParameterMap();
		Map retMap = new HashMap();

		Set entSet = reqMap.entrySet();
		Iterator it = entSet.iterator();
		while (it.hasNext()) {
			Map.Entry et = (Map.Entry) it.next();
			Object v = et.getValue();
			if (v instanceof String) {
				String tt = (String) v;
				retMap.put(et.getKey(), tt);
			} else if (v instanceof String[]) {
				String[] tt = (String[]) v;
				retMap.put(et.getKey(), tt[0]);
			} else {
				retMap.put(et.getKey(), v.toString());
			}
		}
		return retMap;
	}

	/*
	 *  urlEncode
	 */
	public String urlEncode(Object obj) {
		if (obj == null) {
			return null;
		}

		try {
			return URLEncoder.encode(obj.toString(), "EUC-KR");
		} catch (Exception e) {
			e.printStackTrace();
			return obj.toString();
		}
	}

	/*
	 *  urlDecode
	 */
	public String urlDecode(Object obj) {
		if (obj == null) {
			return null;
		}

		try {
			return URLDecoder.decode(obj.toString(), "EUC-KR");
		} catch (Exception e) {
			return obj.toString();
		}
	}

	public String toEncrypt(String originalMsg) {		
		String AESMode = "AES/CBC/PKCS5Padding";
		String SecetKeyAlgorithmString = "AES";

		IvParameterSpec ivspec = new IvParameterSpec(
				hexToByteArray(IV));
		SecretKey keySpec = new SecretKeySpec(hexToByteArray(CRYPTOKEY),
				SecetKeyAlgorithmString);
		try {
			Cipher cipher = Cipher.getInstance(AESMode);
			cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivspec);
			byte[] encrypted = cipher.doFinal(originalMsg.getBytes());
			return new String(Base64.encodeBase64(encrypted));
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public String toDecrypt(String originalMsg) {
		
		String AESMode = "AES/CBC/PKCS5Padding";
		String SecetKeyAlgorithmString = "AES";

		IvParameterSpec ivspec = new IvParameterSpec(hexToByteArray(IV));
		SecretKey keySpec = new SecretKeySpec(hexToByteArray(CRYPTOKEY),SecetKeyAlgorithmString);
		try {
			Cipher cipher = Cipher.getInstance(AESMode);
			cipher.init(Cipher.DECRYPT_MODE, keySpec, ivspec);
			byte[] decrypted = cipher.doFinal(Base64.decodeBase64(originalMsg.getBytes()));
			String retValue = new String(decrypted);
			return retValue;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	private byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() == 0) {
			return null;
		}

		byte[] ba = new byte[hex.length() / 2];
		for (int i = 0; i < ba.length; i++) {
			ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return ba;
	}
	
	
}
