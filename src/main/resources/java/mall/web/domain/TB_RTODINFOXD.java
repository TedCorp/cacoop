package mall.web.domain;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문정보 마스터 DTO
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_rtodinfoxd")
@XmlRootElement(name="tb_rtodinfoxd")
public class TB_RTODINFOXD extends DefaultDomain{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8026263325769952488L;
	
	private String RETURN_DTNUM;
	private String RETURN_NUM;
	private String PD_CODE; 
	private String PD_NAME;
	private String PD_PRICE;
	private String PDDC_GUBN;
	private String PDDC_VAL;
	private String REAL_PRICE;
	private String RETURN_QTY;
	private String RETURN_AMT;
	private String ORDER_CON;
	private String CNCL_CON;
	private String RETURN_GBN;
	private String ORDER_DTNUM;
	
	
	private String[] RETURN_DTNUMS;
	private String[] PD_CODES;		//VARCHAR2(20)			제품코드
	private String[] PD_NAMES;		//VARCHAR2(30)			제품명
	private String[] PD_PRICES;		//NUMBER(15)			제품가격
	private String[] PDDC_GUBNS;	//VARCHAR2(35)			제품할인 구분
	private String[] PDDC_VALS;		//NUMBER(15)			제품할인 값
	private String[] RETURN_QTYS;	//NUMBER(5)				주문 수량
	private String[] RETURN_AMTS;	//NUMBER(15)			주문금액
	private String[] RETURN_GBNS;
	private String[] ORDER_DTNUMS;
	
	//판매단가
	private String ORDER_PRICE;
	private String ORDER_VAL;
	private String ORDER_REAL_PRICE;
	private String ORDER_QTY;
	public String getRETURN_DTNUM() {
		return RETURN_DTNUM;
	}
	public void setRETURN_DTNUM(String rETURN_DTNUM) {
		RETURN_DTNUM = rETURN_DTNUM;
	}
	public String getRETURN_NUM() {
		return RETURN_NUM;
	}
	public void setRETURN_NUM(String rETURN_NUM) {
		RETURN_NUM = rETURN_NUM;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public String getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}
	public String getPDDC_GUBN() {
		return PDDC_GUBN;
	}
	public void setPDDC_GUBN(String pDDC_GUBN) {
		PDDC_GUBN = pDDC_GUBN;
	}
	public String getPDDC_VAL() {
		return PDDC_VAL;
	}
	public void setPDDC_VAL(String pDDC_VAL) {
		PDDC_VAL = pDDC_VAL;
	}
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE;
	}
	public String getRETURN_QTY() {
		return RETURN_QTY;
	}
	public void setRETURN_QTY(String rETURN_QTY) {
		RETURN_QTY = rETURN_QTY;
	}
	public String getRETURN_AMT() {
		return RETURN_AMT;
	}
	public void setRETURN_AMT(String rETURN_AMT) {
		RETURN_AMT = rETURN_AMT;
	}
	public String getORDER_CON() {
		return ORDER_CON;
	}
	public void setORDER_CON(String oRDER_CON) {
		ORDER_CON = oRDER_CON;
	}
	public String getCNCL_CON() {
		return CNCL_CON;
	}
	public void setCNCL_CON(String cNCL_CON) {
		CNCL_CON = cNCL_CON;
	}
	public String getRETURN_GBN() {
		return RETURN_GBN;
	}
	public void setRETURN_GBN(String rETURN_GBN) {
		RETURN_GBN = rETURN_GBN;
	}
	public String getORDER_DTNUM() {
		return ORDER_DTNUM;
	}
	public void setORDER_DTNUM(String oRDER_DTNUM) {
		ORDER_DTNUM = oRDER_DTNUM;
	}
	public String[] getRETURN_DTNUMS() {
		return RETURN_DTNUMS;
	}
	public void setRETURN_DTNUMS(String[] rETURN_DTNUMS) {
		RETURN_DTNUMS = rETURN_DTNUMS;
	}
	public String[] getPD_CODES() {
		return PD_CODES;
	}
	public void setPD_CODES(String[] pD_CODES) {
		PD_CODES = pD_CODES;
	}
	public String[] getPD_NAMES() {
		return PD_NAMES;
	}
	public void setPD_NAMES(String[] pD_NAMES) {
		PD_NAMES = pD_NAMES;
	}
	public String[] getPD_PRICES() {
		return PD_PRICES;
	}
	public void setPD_PRICES(String[] pD_PRICES) {
		PD_PRICES = pD_PRICES;
	}
	public String[] getPDDC_GUBNS() {
		return PDDC_GUBNS;
	}
	public void setPDDC_GUBNS(String[] pDDC_GUBNS) {
		PDDC_GUBNS = pDDC_GUBNS;
	}
	public String[] getPDDC_VALS() {
		return PDDC_VALS;
	}
	public void setPDDC_VALS(String[] pDDC_VALS) {
		PDDC_VALS = pDDC_VALS;
	}
	public String[] getRETURN_QTYS() {
		return RETURN_QTYS;
	}
	public void setRETURN_QTYS(String[] rETURN_QTYS) {
		RETURN_QTYS = rETURN_QTYS;
	}
	public String[] getRETURN_AMTS() {
		return RETURN_AMTS;
	}
	public void setRETURN_AMTS(String[] rETURN_AMTS) {
		RETURN_AMTS = rETURN_AMTS;
	}
	public String[] getRETURN_GBNS() {
		return RETURN_GBNS;
	}
	public void setRETURN_GBNS(String[] rETURN_GBNS) {
		RETURN_GBNS = rETURN_GBNS;
	}
	public String[] getORDER_DTNUMS() {
		return ORDER_DTNUMS;
	}
	public void setORDER_DTNUMS(String[] oRDER_DTNUMS) {
		ORDER_DTNUMS = oRDER_DTNUMS;
	}
	public String getORDER_PRICE() {
		return ORDER_PRICE;
	}
	public void setORDER_PRICE(String oRDER_PRICE) {
		ORDER_PRICE = oRDER_PRICE;
	}
	public String getORDER_VAL() {
		return ORDER_VAL;
	}
	public void setORDER_VAL(String oRDER_VAL) {
		ORDER_VAL = oRDER_VAL;
	}
	public String getORDER_REAL_PRICE() {
		return ORDER_REAL_PRICE;
	}
	public void setORDER_REAL_PRICE(String oRDER_REAL_PRICE) {
		ORDER_REAL_PRICE = oRDER_REAL_PRICE;
	}
	public String getORDER_QTY() {
		return ORDER_QTY;
	}
	public void setORDER_QTY(String oRDER_QTY) {
		ORDER_QTY = oRDER_QTY;
	}
	
}
