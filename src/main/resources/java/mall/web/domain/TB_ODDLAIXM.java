package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문배송지정보 DTO
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_oddlaixm")
@XmlRootElement(name="tb_oddlaixm")
public class TB_ODDLAIXM extends DefaultDomain{
	
	private static final long serialVersionUID = -6215499596814261517L;
	
	private String ORDER_NUM;	//VARCHAR2(50)			주문번호
	private String DLAR_GUBN;	//VARCHAR2(35)			배송지구분
	private String DLAR_GUBN_NM;	//VARCHAR2(35)			배송지명
	private String RECV_PERS = "";	//VARCHAR2(30)			수령인
	private String POST_NUM;	//VARCHAR2(6)			우편번호
	private String BASC_ADDR;	//VARCHAR2(200)			기본주소
	private String DTL_ADDR;	//VARCHAR2(200)			상세주소
	private String RECV_TELN;	//VARCHAR2(20)	Y		수령인 전화번호
	private String RECV_CPON;	//VARCHAR2(20)			수령인 휴대전화
	private String DLVY_MSG;	//VARCHAR2(500)	Y		배송메세지
	
	private String ADM_REF;
	
	private String DLAR_DATE;		//배송시간/출고시간
	private String DLAR_TIME;		//출고일
	
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getDLAR_GUBN() {
		return DLAR_GUBN;
	}
	public void setDLAR_GUBN(String dLAR_GUBN) {
		DLAR_GUBN = dLAR_GUBN;
	}
	public String getRECV_PERS() {
		return RECV_PERS;
	}
	public void setRECV_PERS(String rECV_PERS) {
		RECV_PERS = rECV_PERS;
	}
	public String getPOST_NUM() {
		return POST_NUM;
	}
	public void setPOST_NUM(String pOST_NUM) {
		POST_NUM = pOST_NUM;
	}
	public String getBASC_ADDR() {
		return BASC_ADDR;
	}
	public void setBASC_ADDR(String bASC_ADDR) {
		BASC_ADDR = bASC_ADDR;
	}
	public String getDTL_ADDR() {
		return DTL_ADDR;
	}
	public void setDTL_ADDR(String dTL_ADDR) {
		DTL_ADDR = dTL_ADDR;
	}
	public String getRECV_TELN() {
		return RECV_TELN;
	}
	public void setRECV_TELN(String rECV_TELN) {
		RECV_TELN = rECV_TELN;
	}
	public String getRECV_CPON() {
		return RECV_CPON;
	}
	public void setRECV_CPON(String rECV_CPON) {
		RECV_CPON = rECV_CPON;
	}
	public String getDLVY_MSG() {
		return DLVY_MSG;
	}
	public void setDLVY_MSG(String dLVY_MSG) {
		DLVY_MSG = dLVY_MSG;
	}
	public String getDLAR_GUBN_NM() {
		return DLAR_GUBN_NM;
	}
	public void setDLAR_GUBN_NM(String dLAR_GUBN_NM) {
		DLAR_GUBN_NM = dLAR_GUBN_NM;
	}
	public String getADM_REF() {
		return ADM_REF;
	}
	public void setADM_REF(String aDM_REF) {
		ADM_REF = aDM_REF;
	}
	public String getDLAR_DATE() {
		return DLAR_DATE;
	}
	public void setDLAR_DATE(String dLAR_DATE) {
		DLAR_DATE = dLAR_DATE;
	}
	public String getDLAR_TIME() {
		return DLAR_TIME;
	}
	public void setDLAR_TIME(String dLAR_TIME) {
		DLAR_TIME = dLAR_TIME;
	}
	
}
