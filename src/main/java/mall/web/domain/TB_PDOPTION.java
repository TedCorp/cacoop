package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 상품옵션
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdoption")
@XmlRootElement(name="tb_pdoption")
public class TB_PDOPTION extends DefaultDomain{
	
	private static final long serialVersionUID = 1L;
	
	private String PD_CODE= "";			
	private String OPTION1_VALUE= "";			
	private String OPTION1_NAME= "";			
	private String QUANTITY= "";			
	private String PRICE= "";
	private String MGR_CODE="";

	
	private String SORT_ORDER= "";	
	private String OPTION2_NAME= "";	
	private String OPTION2_VALUE= "";	
	private String OPTION3_NAME = "";
	private String OPTION3_VALUE = "";
	private String SELL_YN = "";
	private String DEL_YN ="";

	private String OPTION_NAME = "";
	private String OPTION_VALUE = "";
	private String UP_VALUE = "";
	private String UP_NAME = "";
	
	private String OPTION_ORIG_PRICE="";
	
	
	
	public String getOPTION_ORIG_PRICE() {
		return OPTION_ORIG_PRICE;
	}
	public void setOPTION_ORIG_PRICE(String oPTION_ORIG_PRICE) {
		OPTION_ORIG_PRICE = oPTION_ORIG_PRICE;
	}
	public String getSORT_ORDER() {
		return SORT_ORDER;
	}
	public void setSORT_ORDER(String sORT_ORDER) {
		SORT_ORDER = sORT_ORDER;
	}
	
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	
	public String getQUANTITY() {
		return QUANTITY;
	}
	public void setQUANTITY(String qUANTITY) {
		QUANTITY = qUANTITY;
	}	
	public String getPRICE() {
		return PRICE;
	}
	public void setPRICE(String pRICE) {
		PRICE = pRICE;
	}
	public String getOPTION3_NAME() {
		return OPTION3_NAME;
	}
	public void setOPTION3_NAME(String oPTION3_NAME) {
		OPTION3_NAME = oPTION3_NAME;
	}
	public String getOPTION3_VALUE() {
		return OPTION3_VALUE;
	}
	public void setOPTION3_VALUE(String oPTION3_VALUE) {
		OPTION3_VALUE = oPTION3_VALUE;
	}
	public String getOPTION1_VALUE() {
		return OPTION1_VALUE;
	}
	public void setOPTION1_VALUE(String oPTION1_VALUE) {
		OPTION1_VALUE = oPTION1_VALUE;
	}
	public String getOPTION1_NAME() {
		return OPTION1_NAME;
	}
	public void setOPTION1_NAME(String oPTION1_NAME) {
		OPTION1_NAME = oPTION1_NAME;
	}
	public String getOPTION2_NAME() {
		return OPTION2_NAME;
	}
	public void setOPTION2_NAME(String oPTION2_NAME) {
		OPTION2_NAME = oPTION2_NAME;
	}
	public String getOPTION2_VALUE() {
		return OPTION2_VALUE;
	}
	public void setOPTION2_VALUE(String oPTION2_VALUE) {
		OPTION2_VALUE = oPTION2_VALUE;
	}
	public String getSELL_YN() {
		return SELL_YN;
	}
	public void setSELL_YN(String sELL_YN) {
		SELL_YN = sELL_YN;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getOPTION_NAME() {
		return OPTION_NAME;
	}
	public void setOPTION_NAME(String oPTION_NAME) {
		OPTION_NAME = oPTION_NAME;
	}
	public String getOPTION_VALUE() {
		return OPTION_VALUE;
	}
	public void setOPTION_VALUE(String oPTION_VALUE) {
		OPTION_VALUE = oPTION_VALUE;
	}
	public String getUP_VALUE() {
		return UP_VALUE;
	}
	public void setUP_VALUE(String uP_VALUE) {
		UP_VALUE = uP_VALUE;
	}
	public String getUP_NAME() {
		return UP_NAME;
	}
	public void setUP_NAME(String uP_NAME) {
		UP_NAME = uP_NAME;
	}
	public String getMGR_CODE() {
		return MGR_CODE;
	}
	public void setMGR_CODE(String mGR_CODE) {
		MGR_CODE = mGR_CODE;
	}
		

	
	


}
