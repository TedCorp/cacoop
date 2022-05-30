package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 다날 로그 DTO
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_oddnlgxm")
@XmlRootElement(name="tb_oddnlgxm")
public class TB_ODDNLGXM extends DefaultDomain{

	private static final long serialVersionUID = 6909202410826056042L;
	
	private String SEQ;
	private String TID;
	private String ORDER_NUM;
	private String GUBUN;
	private String RETURNCODE;
	private String RETURNMSG;
	private String AMOUNT;
	private String TRANDATE;
	private String TRANTIME;
	private String CARDCODE;
	private String CARDNAME;
	private String CARDAUTHNO;
	private String BYPASSVALUE;
	public String getSEQ() {
		return SEQ;
	}
	public void setSEQ(String sEQ) {
		SEQ = sEQ;
	}
	public String getTID() {
		return TID;
	}
	public void setTID(String tID) {
		TID = tID;
	}
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getGUBUN() {
		return GUBUN;
	}
	public void setGUBUN(String gUBUN) {
		GUBUN = gUBUN;
	}
	public String getRETURNCODE() {
		return RETURNCODE;
	}
	public void setRETURNCODE(String rETURNCODE) {
		RETURNCODE = rETURNCODE;
	}
	public String getRETURNMSG() {
		return RETURNMSG;
	}
	public void setRETURNMSG(String rETURNMSG) {
		RETURNMSG = rETURNMSG;
	}
	public String getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(String aMOUNT) {
		AMOUNT = aMOUNT;
	}
	public String getTRANDATE() {
		return TRANDATE;
	}
	public void setTRANDATE(String tRANDATE) {
		TRANDATE = tRANDATE;
	}
	public String getTRANTIME() {
		return TRANTIME;
	}
	public void setTRANTIME(String tRANTIME) {
		TRANTIME = tRANTIME;
	}
	public String getCARDCODE() {
		return CARDCODE;
	}
	public void setCARDCODE(String cARDCODE) {
		CARDCODE = cARDCODE;
	}
	public String getCARDNAME() {
		return CARDNAME;
	}
	public void setCARDNAME(String cARDNAME) {
		CARDNAME = cARDNAME;
	}
	public String getCARDAUTHNO() {
		return CARDAUTHNO;
	}
	public void setCARDAUTHNO(String cARDAUTHNO) {
		CARDAUTHNO = cARDAUTHNO;
	}
	public String getBYPASSVALUE() {
		return BYPASSVALUE;
	}
	public void setBYPASSVALUE(String bYPASSVALUE) {
		BYPASSVALUE = bYPASSVALUE;
	}
	
	
	
}
