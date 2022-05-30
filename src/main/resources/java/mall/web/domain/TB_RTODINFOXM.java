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
@Alias("tb_rtodinfoxm")
@XmlRootElement(name="tb_rtodinfoxm")
public class TB_RTODINFOXM extends DefaultDomain{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8710793220161037382L;
	
	private String RETURN_NUM;
	private String RETURN_DATE;
	private String MEMB_ID;
	private String MEMB_NM;
	private String COM_NAME;
	private String RETURN_AMT;
	private String ORDER_CON;
	private String CNCL_CON;
	private String CNCL_REQDTM;
	private String ORDER_NUM;
	private String DLVY_AMT;
	private String PAY_METD;
	private String PAY_METD_NM;
	
	private String PD_NAME;
	
	private String RETURN_NUM_LIST;
	
	private String schNum;
	
	
	public String getRETURN_NUM() {
		return RETURN_NUM;
	}
	public void setRETURN_NUM(String rETURN_NUM) {
		RETURN_NUM = rETURN_NUM;
	}
	public String getRETURN_DATE() {
		return RETURN_DATE;
	}
	public void setRETURN_DATE(String rETURN_DATE) {
		RETURN_DATE = rETURN_DATE;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getMEMB_NM() {
		return MEMB_NM;
	}
	public void setMEMB_NM(String mEMB_NM) {
		MEMB_NM = mEMB_NM;
	}
	public String getCOM_NAME() {
		return COM_NAME;
	}
	public void setCOM_NAME(String cOM_NAME) {
		COM_NAME = cOM_NAME;
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
	public String getCNCL_REQDTM() {
		return CNCL_REQDTM;
	}
	public void setCNCL_REQDTM(String cNCL_REQDTM) {
		CNCL_REQDTM = cNCL_REQDTM;
	}
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	
	public String getPAY_METD() {
		return PAY_METD;
	}
	public void setPAY_METD(String pAY_METD) {
		PAY_METD = pAY_METD;
	}
	public String getPAY_METD_NM() {
		return PAY_METD_NM;
	}
	public void setPAY_METD_NM(String pAY_METD_NM) {
		PAY_METD_NM = pAY_METD_NM;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public String getRETURN_NUM_LIST() {
		return RETURN_NUM_LIST;
	}
	public void setRETURN_NUM_LIST(String rETURN_NUM_LIST) {
		RETURN_NUM_LIST = rETURN_NUM_LIST;
	}
	public String getSchNum() {
		return schNum;
	}
	public void setSchNum(String schNum) {
		this.schNum = schNum;
	}
	
}
