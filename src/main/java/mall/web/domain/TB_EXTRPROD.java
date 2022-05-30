package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 추가 상품 정보 
 * @Company	: YT Corp.
 * @Author	: minu
 * @Date	: 2022-01-03 (오후 4:34:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_extrprod")
@XmlRootElement(name="tb_extrprod")
public class TB_EXTRPROD extends DefaultDomain{

	private static final long serialVersionUID = 1L;
	
	private String PD_CODE;					//  상품코드 
	private String EXTRA_PD_CODE;			// 추가상품 코드 
	private String USE_YN; 					// 사용여부 
	private String REG_DATE;				// 생성일 
	
	private String PD_NAME;
	private String PD_PRICE;
	private String SUPR_ID; 
	
	
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getEXTRA_PD_CODE() {
		return EXTRA_PD_CODE;
	}
	public void setEXTRA_PD_CODE(String eXTRA_PD_CODE) {
		EXTRA_PD_CODE = eXTRA_PD_CODE;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
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
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setPSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}	
	
	
	

	
	
}
