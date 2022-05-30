package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 기업정보(공급사) DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_spinfoxm")
@XmlRootElement(name="tb_spinfoxm")
public class TB_SPINFOXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String BIZR_NUM;	//사업자번호
	private String RPRS_NAME;	//대표자 명
	private String TEL_NUM;		//전화번호
	private String FAX_NUM;		//FAX 번호
	private String RPR_MAIL;	//대표 이메일
	private String POST_NUM;	//우편번호
	private String BASC_ADDR;	//기본주소
	private String DTL_ADDR;	//상세주소
	private String DLVY_AMT;	//배송비
	private String DLVA_FCON;	//배송비 무료조건
	private String PS_COM;		//택배사
	private String APR_PROD;	//자동 상품수령 기간
	private String APD_PROD;	//자동 구매확정 기간
	private String SBK_PROD;	//장바구니 보관 기간
	private String SVMN_USCON;	//적립금 사용조건
	private String DLVREF_CONT;	//배송/환불 내용
	private String SCSS_YN;		//탈퇴여부
	private String BIZR_STYLE;			//업태
	private String BIZR_EVENT;			//종목
	
	private String AUTH_MAIL;			//발신자 이메일
	private String RPR_PASS;				//발신자 이메일 비밀번호
	private String MAIL_GUBN;			//이메일 구분
	
	public String getBIZR_NUM() {
		return BIZR_NUM;
	}
	public void setBIZR_NUM(String bIZR_NUM) {
		BIZR_NUM = bIZR_NUM;
	}
	public String getRPRS_NAME() {
		return RPRS_NAME;
	}
	public void setRPRS_NAME(String rPRS_NAME) {
		RPRS_NAME = rPRS_NAME;
	}
	public String getTEL_NUM() {
		return TEL_NUM;
	}
	public void setTEL_NUM(String tEL_NUM) {
		TEL_NUM = tEL_NUM;
	}
	public String getFAX_NUM() {
		return FAX_NUM;
	}
	public void setFAX_NUM(String fAX_NUM) {
		FAX_NUM = fAX_NUM;
	}
	public String getRPR_MAIL() {
		return RPR_MAIL;
	}
	public void setRPR_MAIL(String rPR_MAIL) {
		RPR_MAIL = rPR_MAIL;
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
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT.replaceAll("\\,", "");
	}
	public String getDLVA_FCON() {
		return DLVA_FCON;
	}
	public void setDLVA_FCON(String dLVA_FCON) {
		DLVA_FCON = dLVA_FCON.replaceAll("\\,", "");
	}
	public String getPS_COM() {
		return PS_COM;
	}
	public void setPS_COM(String pS_COM) {
		PS_COM = pS_COM;
	}
	public String getAPR_PROD() {
		return APR_PROD;
	}
	public void setAPR_PROD(String aPR_PROD) {
		APR_PROD = aPR_PROD;
	}
	public String getAPD_PROD() {
		return APD_PROD;
	}
	public void setAPD_PROD(String aPD_PROD) {
		APD_PROD = aPD_PROD;
	}
	public String getSBK_PROD() {
		return SBK_PROD;
	}
	public void setSBK_PROD(String sBK_PROD) {
		SBK_PROD = sBK_PROD;
	}
	public String getSVMN_USCON() {
		return SVMN_USCON;
	}
	public void setSVMN_USCON(String sVMN_USCON) {
		SVMN_USCON = sVMN_USCON;
	}
	public String getDLVREF_CONT() {
		return DLVREF_CONT;
	}
	public void setDLVREF_CONT(String dLVREF_CONT) {
		DLVREF_CONT = dLVREF_CONT;
	}
	public String getSCSS_YN() {
		return SCSS_YN;
	}
	public void setSCSS_YN(String sCSS_YN) {
		SCSS_YN = sCSS_YN;
	}
	public String getBIZR_STYLE() {
		return BIZR_STYLE;
	}
	public void setBIZR_STYLE(String bIZR_STYLE) {
		BIZR_STYLE = bIZR_STYLE;
	}
	public String getBIZR_EVENT() {
		return BIZR_EVENT;
	}
	public void setBIZR_EVENT(String bIZR_EVENT) {
		BIZR_EVENT = bIZR_EVENT;
	}	
	public String getAUTH_MAIL() {
		return AUTH_MAIL;
	}
	public void setAUTH_MAIL(String aUTH_MAIL) {
		AUTH_MAIL = aUTH_MAIL;
	}
	public String getRPR_PASS() {
		return RPR_PASS;
	}
	public void setRPR_PASS(String rPR_PASS) {
		RPR_PASS = rPR_PASS;
	}
	public String getMAIL_GUBN() {
		return MAIL_GUBN;
	}
	public void setMAIL_GUBN(String mAIL_GUBN) {
		MAIL_GUBN = mAIL_GUBN;
	}
	
}
