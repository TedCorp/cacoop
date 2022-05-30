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
	private String OPTION_VALUE= "";			
	private String OPTION_NAME= "";			
	private String QUANTITY= "";			
	private String PRICE= "";
	
	private String SORT_ORDER= "";	
	private String UP_NAME= "";	
	private String UP_VALUE= "";	
	
	
	
	public String getSORT_ORDER() {
		return SORT_ORDER;
	}
	public void setSORT_ORDER(String sORT_ORDER) {
		SORT_ORDER = sORT_ORDER;
	}
	public String getUP_NAME() {
		return UP_NAME;
	}
	public void setUP_NAME(String uP_NAME) {
		UP_NAME = uP_NAME;
	}
	public String getUP_VALUE() {
		return UP_VALUE;
	}
	public void setUP_VALUE(String uP_VALUE) {
		UP_VALUE = uP_VALUE;
	}	
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getOPTION_VALUE() {
		return OPTION_VALUE;
	}
	public void setOPTION_VALUE(String oPTION_VALUE) {
		OPTION_VALUE = oPTION_VALUE;
	}
	public String getOPTION_NAME() {
		return OPTION_NAME;
	}
	public void setOPTION_NAME(String oPTION_NAME) {
		OPTION_NAME = oPTION_NAME;
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

	
	


}
