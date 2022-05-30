package mall.web.domain;

import javax.xml.bind.annotation.XmlElement;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 배송전표
 * @Company	: YT Corp.
 * @Author	: CHJW (treedoo@naver.com)
 * @Date	: 2020-03-16 (오후 15:24:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public class Deliverys extends DefaultDomain {
	
	private static final long serialVersionUID = 1L;

	private String ORDER_NUM;
	private String RECV_PERS;
	private String RECV_TELN;
	private String RECV_CPON;
	private String MEMB_MAIL;
	private String COM_NAME;
	private String COM_BUNB;
	private String COM_TELN;
	private String RECV_ADDR;
	private String PD_CODE;
	private String PD_BARCD;
	private String PD_NAME;
	private String PD_STD;
	private String STD_UNIT;
	private String KEEP_GUBN;
	private String PACKING_GUBN;
	private String PD_PRICE;
	private String REAL_PRICE;
	private String ORDER_QTY;
	private String ORDER_AMT;
	private String CPON_YN;
	private String DLVY_AMT;
	private String KEEP_LOCATION;
	private String DLVY_MSG;
	private String ADM_REF;
	private String DLAR_DATE;
	private String DLAR_TIME;
	private String ORDER_TOT;
	private String CUT_UNIT;
	private String OPTION_NAME;
	private String DLVY_NAME;
	private String DLVY_TDN;
	private String DLVY_COM;
	private String BIZR_NUM;
	private String SUPR_NAME;
	private String RPRS_NAME;
	private String BIZR_ADDR;
	private String TEL_NUM;
	private String SUPR_ID;
	private String BSKT_REGNO;
	
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getRECV_PERS() {
		return RECV_PERS;
	}
	public void setRECV_PERS(String rECV_PERS) {
		RECV_PERS = rECV_PERS;
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
	public String getMEMB_MAIL() {
		return MEMB_MAIL;
	}
	public void setMEMB_MAIL(String mEMB_MAIL) {
		MEMB_MAIL = mEMB_MAIL;
	}
	public String getCOM_NAME() {
		return COM_NAME;
	}
	public void setCOM_NAME(String cOM_NAME) {
		COM_NAME = cOM_NAME;
	}
	public String getCOM_BUNB() {
		return COM_BUNB;
	}
	public void setCOM_BUNB(String cOM_BUNB) {
		COM_BUNB = cOM_BUNB;
	}
	public String getCOM_TELN() {
		return COM_TELN;
	}
	public void setCOM_TELN(String cOM_TELN) {
		COM_TELN = cOM_TELN;
	}
	public String getRECV_ADDR() {
		return RECV_ADDR;
	}
	public void setRECV_ADDR(String rECV_ADDR) {
		RECV_ADDR = rECV_ADDR;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public String getPD_STD() {
		return PD_STD;
	}
	public void setPD_STD(String pD_STD) {
		PD_STD = pD_STD;
	}
	public String getSTD_UNIT() {
		return STD_UNIT;
	}
	public void setSTD_UNIT(String sTD_UNIT) {
		STD_UNIT = sTD_UNIT;
	}
	public String getKEEP_GUBN() {
		return KEEP_GUBN;
	}
	public void setKEEP_GUBN(String kEEP_GUBN) {
		KEEP_GUBN = kEEP_GUBN;
	}
	public String getPACKING_GUBN() {
		return PACKING_GUBN;
	}
	public void setPACKING_GUBN(String pACKING_GUBN) {
		PACKING_GUBN = pACKING_GUBN;
	}
	public String getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE;
	}
	public String getORDER_QTY() {
		return ORDER_QTY;
	}
	public void setORDER_QTY(String oRDER_QTY) {
		ORDER_QTY = oRDER_QTY;
	}
	public String getORDER_AMT() {
		return ORDER_AMT;
	}
	public void setORDER_AMT(String oRDER_AMT) {
		ORDER_AMT = oRDER_AMT;
	}
	public String getCPON_YN() {
		return CPON_YN;
	}
	public void setCPON_YN(String cPON_YN) {
		CPON_YN = cPON_YN;
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT;
	}
	public String getKEEP_LOCATION() {
		return KEEP_LOCATION;
	}
	public void setKEEP_LOCATION(String kEEP_LOCATION) {
		KEEP_LOCATION = kEEP_LOCATION;
	}
	public String getDLVY_MSG() {
		return DLVY_MSG;
	}
	public void setDLVY_MSG(String dLVY_MSG) {
		DLVY_MSG = dLVY_MSG;
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
	public String getORDER_TOT() {
		return ORDER_TOT;
	}
	public void setORDER_TOT(String oRDER_TOT) {
		ORDER_TOT = oRDER_TOT;
	}
	public String getCUT_UNIT() {
		return CUT_UNIT;
	}
	public void setCUT_UNIT(String cUT_UNIT) {
		CUT_UNIT = cUT_UNIT;
	}
	public String getOPTION_NAME() {
		return OPTION_NAME;
	}
	public void setOPTION_NAME(String oPTION_NAME) {
		OPTION_NAME = oPTION_NAME;
	}
	public String getDLVY_NAME() {
		return DLVY_NAME;
	}
	public void setDLVY_NAME(String dLVY_NAME) {
		DLVY_NAME = dLVY_NAME;
	}
	public String getDLVY_TDN() {
		return DLVY_TDN;
	}
	public void setDLVY_TDN(String dLVY_TDN) {
		DLVY_TDN = dLVY_TDN;
	}
	public String getDLVY_COM() {
		return DLVY_COM;
	}
	public void setDLVY_COM(String dLVY_COM) {
		DLVY_COM = dLVY_COM;
	}
	public String getBIZR_NUM() {
		return BIZR_NUM;
	}
	public void setBIZR_NUM(String bIZR_NUM) {
		BIZR_NUM = bIZR_NUM;
	}
	public String getSUPR_NAME() {
		return SUPR_NAME;
	}
	public void setSUPR_NAME(String sUPR_NAME) {
		SUPR_NAME = sUPR_NAME;
	}
	public String getRPRS_NAME() {
		return RPRS_NAME;
	}
	public void setRPRS_NAME(String rPRS_NAME) {
		RPRS_NAME = rPRS_NAME;
	}
	public String getBIZR_ADDR() {
		return BIZR_ADDR;
	}
	public void setBIZR_ADDR(String bIZR_ADDR) {
		BIZR_ADDR = bIZR_ADDR;
	}
	public String getTEL_NUM() {
		return TEL_NUM;
	}
	public void setTEL_NUM(String tEL_NUM) {
		TEL_NUM = tEL_NUM;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getBSKT_REGNO() {
		return BSKT_REGNO;
	}
	public void setBSKT_REGNO(String bSKT_REGNO) {
		BSKT_REGNO = bSKT_REGNO;
	}
	
}
