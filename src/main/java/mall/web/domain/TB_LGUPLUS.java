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
@Alias("tb_lguplus")
@XmlRootElement(name="tb_lguplus")
public class TB_LGUPLUS extends DefaultDomain{
	
	private static final long serialVersionUID = -339735115425726190L;
	
	private String SEQ;						//순번
	private String LGD_TID;					//거래번호
	private String LGD_OID;					//주문번호
	private String GUBUN;					//구분
	private String LGD_RESPCODE;			//응답코드
	private String LGD_RESPMSG;				//응답메세지
	private String LGD_AMOUNT;				//결제금액
	private String LGD_PAYTYPE;				//결제수단
	private String LGD_PAYDATE;				//결제일시
	private String LGD_FINANCECODE;			//결제기관코드 (은행코드)
	private String LGD_FINANCENAME;			//결제기관명 (은행명)
	private String LGD_CARDNUM;				//신용카드번호
	private String LGD_FINANCEAUTHNUM;		//걀제기관승인번호
	private String LGD_ACCOUNTNUM;			//계좌번호 (무통장)
	private String LGD_CASTAMOUNT;			//입금총액 (무통장)
	private String LGD_CASCAMOUNT;			//현입금총액 (무통장)
	private String LGD_CASFLAG;				//무통장입금 플래그
	private String LGD_CASSEQNO;			//입금순서
	private String LGD_CLOSEDATE;			//입금마감기간
	private String LGD_CASHRECEIPTNUM;		//현금영수증번호
	private String LGD_CASHRECEIPTKIND;		//현금영수증종류
	private String STATE;					//결과메세지(성공시 OK)
	
	public String getSEQ() {
		return SEQ;
	}
	public void setSEQ(String sEQ) {
		SEQ = sEQ;
	}
	public String getLGD_TID() {
		return LGD_TID;
	}
	public void setLGD_TID(String lGD_TID) {
		LGD_TID = lGD_TID;
	}
	public String getLGD_OID() {
		return LGD_OID;
	}
	public void setLGD_OID(String lGD_OID) {
		LGD_OID = lGD_OID;
	}
	public String getGUBUN() {
		return GUBUN;
	}
	public void setGUBUN(String gUBUN) {
		GUBUN = gUBUN;
	}
	public String getLGD_RESPCODE() {
		return LGD_RESPCODE;
	}
	public void setLGD_RESPCODE(String lGD_RESPCODE) {
		LGD_RESPCODE = lGD_RESPCODE;
	}
	public String getLGD_RESPMSG() {
		return LGD_RESPMSG;
	}
	public void setLGD_RESPMSG(String lGD_RESPMSG) {
		LGD_RESPMSG = lGD_RESPMSG;
	}
	public String getLGD_AMOUNT() {
		return LGD_AMOUNT;
	}
	public void setLGD_AMOUNT(String lGD_AMOUNT) {
		LGD_AMOUNT = lGD_AMOUNT;
	}
	public String getLGD_PAYTYPE() {
		return LGD_PAYTYPE;
	}
	public void setLGD_PAYTYPE(String lGD_PAYTYPE) {
		LGD_PAYTYPE = lGD_PAYTYPE;
	}
	public String getLGD_PAYDATE() {
		return LGD_PAYDATE;
	}
	public void setLGD_PAYDATE(String lGD_PAYDATE) {
		LGD_PAYDATE = lGD_PAYDATE;
	}
	public String getLGD_FINANCECODE() {
		return LGD_FINANCECODE;
	}
	public void setLGD_FINANCECODE(String lGD_FINANCECODE) {
		LGD_FINANCECODE = lGD_FINANCECODE;
	}
	public String getLGD_FINANCENAME() {
		return LGD_FINANCENAME;
	}
	public void setLGD_FINANCENAME(String lGD_FINANCENAME) {
		LGD_FINANCENAME = lGD_FINANCENAME;
	}
	public String getLGD_CARDNUM() {
		return LGD_CARDNUM;
	}
	public void setLGD_CARDNUM(String lGD_CARDNUM) {
		LGD_CARDNUM = lGD_CARDNUM;
	}
	public String getLGD_FINANCEAUTHNUM() {
		return LGD_FINANCEAUTHNUM;
	}
	public void setLGD_FINANCEAUTHNUM(String lGD_FINANCEAUTHNUM) {
		LGD_FINANCEAUTHNUM = lGD_FINANCEAUTHNUM;
	}
	public String getLGD_ACCOUNTNUM() {
		return LGD_ACCOUNTNUM;
	}
	public void setLGD_ACCOUNTNUM(String lGD_ACCOUNTNUM) {
		LGD_ACCOUNTNUM = lGD_ACCOUNTNUM;
	}
	public String getLGD_CASTAMOUNT() {
		return LGD_CASTAMOUNT;
	}
	public void setLGD_CASTAMOUNT(String lGD_CASTAMOUNT) {
		LGD_CASTAMOUNT = lGD_CASTAMOUNT;
	}
	public String getLGD_CASCAMOUNT() {
		return LGD_CASCAMOUNT;
	}
	public void setLGD_CASCAMOUNT(String lGD_CASCAMOUNT) {
		LGD_CASCAMOUNT = lGD_CASCAMOUNT;
	}
	public String getLGD_CASFLAG() {
		return LGD_CASFLAG;
	}
	public void setLGD_CASFLAG(String lGD_CASFLAG) {
		LGD_CASFLAG = lGD_CASFLAG;
	}
	public String getLGD_CASSEQNO() {
		return LGD_CASSEQNO;
	}
	public void setLGD_CASSEQNO(String lGD_CASSEQNO) {
		LGD_CASSEQNO = lGD_CASSEQNO;
	}
	public String getLGD_CASHRECEIPTNUM() {
		return LGD_CASHRECEIPTNUM;
	}
	public void setLGD_CASHRECEIPTNUM(String lGD_CASHRECEIPTNUM) {
		LGD_CASHRECEIPTNUM = lGD_CASHRECEIPTNUM;
	}
	public String getLGD_CASHRECEIPTKIND() {
		return LGD_CASHRECEIPTKIND;
	}
	public void setLGD_CASHRECEIPTKIND(String lGD_CASHRECEIPTKIND) {
		LGD_CASHRECEIPTKIND = lGD_CASHRECEIPTKIND;
	}
	public String getSTATE() {
		return STATE;
	}
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	public String getLGD_CLOSEDATE() {
		return LGD_CLOSEDATE;
	}
	public void setLGD_CLOSEDATE(String lGD_CLOSEDATE) {
		LGD_CLOSEDATE = lGD_CLOSEDATE;
	}
	
}
