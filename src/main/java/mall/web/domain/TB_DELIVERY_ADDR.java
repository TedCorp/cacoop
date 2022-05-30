package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;
import org.apache.ibatis.type.Alias;
/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주소상제정보 DTO
 * @Company	: TED
 * @Author	: jangBora
 * @Date	: 2022-01-04
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_delivery_addr")
@XmlRootElement(name="tb_delivery_addr")
public class TB_DELIVERY_ADDR extends DefaultDomain{
	
	private static final long serialVersionUID = -1471161809434513649L;
	
	private String ADD_NUM   ="";
	private String SUPR_ID   =""; //공급업체ID
	private String ADDR_GUBN   =""; //주소구분 (1:사업장 2:출고지 3:반품지)
	private String COM_PN   =""; //우편번호
	private String COM_BADR   =""; //주소
	private String COM_DADR   =""; //상세주소
	private String COM_FAX   =""; //팩스번호
	private String COM_TELN   =""; //전화번호
	private String COM_MOBILE   =""; //휴대전화
	private String USE_YN   =""; //사용여부

   //TB_SPINFOXM
	private String SUPR_NAME ="";//공급업체이름
	
	
	
	public String getSUPR_NAME() {
		return SUPR_NAME;
	}
	public void setSUPR_NAME(String sUPR_NAME) {
		SUPR_NAME = sUPR_NAME;
	}
	public String getADD_NUM() {
		return ADD_NUM;
	}
	public void setADD_NUM(String aDD_NUM) {
		ADD_NUM = aDD_NUM;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getADDR_GUBN() {
		return ADDR_GUBN;
	}
	public void setADDR_GUBN(String aDDR_GUBN) {
		ADDR_GUBN = aDDR_GUBN;
	}
	public String getCOM_PN() {
		return COM_PN;
	}
	public void setCOM_PN(String cOM_PN) {
		COM_PN = cOM_PN;
	}
	public String getCOM_BADR() {
		return COM_BADR;
	}
	public void setCOM_BADR(String cOM_BADR) {
		COM_BADR = cOM_BADR;
	}
	public String getCOM_DADR() {
		return COM_DADR;
	}
	public void setCOM_DADR(String cOM_DADR) {
		COM_DADR = cOM_DADR;
	}
	public String getCOM_FAX() {
		return COM_FAX;
	}
	public void setCOM_FAX(String cOM_FAX) {
		COM_FAX = cOM_FAX;
	}
	public String getCOM_TELN() {
		return COM_TELN;
	}
	public void setCOM_TELN(String cOM_TELN) {
		COM_TELN = cOM_TELN;
	}
	public String getCOM_MOBILE() {
		return COM_MOBILE;
	}
	public void setCOM_MOBILE(String cOM_MOBILE) {
		COM_MOBILE = cOM_MOBILE;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}

	
	



}





















































