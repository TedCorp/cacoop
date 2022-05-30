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
@Alias("xtb_odinfoxm")
@XmlRootElement(name="xtb_odinfoxm")
public class XTB_ODINFOXM extends DefaultDomain{

	private static final long serialVersionUID = 6909202410826056042L;
	

	private String ORDER_NUM;			//주문번호
	private String ORDER_DATE;			//주문일자
	private String PHONE_NO;			//휴대폰번호
	private String ORDER_PW = "";		//주문 비밀번호
	private String COM_NAME;			//업체명
	private String BIZR_NUM = "";		//사업자번호
	private String CEO_NAME;			//대표자 명
	private String COM_TEL;				//회사전화번호
	private String POST_NUM;			//우편번호
	private String BASC_ADDR;			//기본주소
	private String DTL_ADDR;			//상세주소
	private String EXTRA_ADDR;			//추가주소
	private String STAFF_NAME;			//담당자 명
	private String STAFF_CPON;			//담당자휴대전화
	private String STAFF_MAIL;			//담당자EMAIL
	private String ORDER_AMT;			//주문금액
	private String ORDER_CON;			//주문상태
	private String ORDER_CON_NM;		//주문상태명
	private String PAY_METD;			//결제수단
	private String PAY_METD_NM;			//결제수단명
	private String ATFL_ID = "";		//첨부파일ID-사업자 등록증
	private String DLVY_ATFL = "";		//첨부파일ID-개별 배송지
	private String CARD_ATFL = "";		//첨부파일ID-신용카드 추가서류
	private String ARRIVAL_DATE;		//상품도착요청일
	
	private String PD_CODE;				//제품코드
	private String PD_NAME;				//TB_ODINFOXD 주문정보 상세    VARCHAR2(30)			제품명
	private String RECV_PERS;			//TB_ODDLAIXM 주문배송지정보  VARCHAR2(30)			수령인
	private String PD_PRICE;			//제품가격

	private String ORDER_MSG = "";		//주문 메세지
	private String ORDER_QTY;			//주문수량
	
	private String PD_CODE_LIST;		//선택 상품
	private String ORDER_GUBUN;			//주문일 or 주문자명 정렬 구분
	private String DATE_ORDER; 			//주문일 정렬 
	private String COM_NAME_ORDER; 		//주문자명 정렬 
	private String STAFF_NAME_ORDER; 	//주문자명 정렬
	
	private String PW_PASS = ""; 		//패스워드 체크 여부
	
		
	public String getORDER_NUM() {
		return ORDER_NUM;
	}

	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}

	public String getORDER_DATE() {
		return ORDER_DATE;
	}



	public String getDLVY_ATFL() {
		return DLVY_ATFL;
	}

	public void setDLVY_ATFL(String dLVY_ATFL) {
		DLVY_ATFL = dLVY_ATFL;
	}

	public void setORDER_DATE(String oRDER_DATE) {
		ORDER_DATE = oRDER_DATE;
	}

	public String getPHONE_NO() {
		return PHONE_NO;
	}

	public void setPHONE_NO(String pHONE_NO) {
		PHONE_NO = pHONE_NO;
	}

	public String getORDER_PW() {
		return ORDER_PW;
	}

	public void setORDER_PW(String oRDER_PW) {
		ORDER_PW = oRDER_PW;
	}

	public String getCOM_NAME() {
		return COM_NAME;
	}

	public void setCOM_NAME(String cOM_NAME) {
		COM_NAME = cOM_NAME;
	}

	public String getCEO_NAME() {
		return CEO_NAME;
	}

	public void setCEO_NAME(String cEO_NAME) {
		CEO_NAME = cEO_NAME;
	}

	public String getCOM_TEL() {
		return COM_TEL;
	}

	public void setCOM_TEL(String cOM_TEL) {
		COM_TEL = cOM_TEL;
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

	public String getSTAFF_NAME() {
		return STAFF_NAME;
	}

	public void setSTAFF_NAME(String sTAFF_NAME) {
		STAFF_NAME = sTAFF_NAME;
	}

	public String getSTAFF_CPON() {
		return STAFF_CPON;
	}

	public void setSTAFF_CPON(String sTAFF_CPON) {
		STAFF_CPON = sTAFF_CPON;
	}

	public String getSTAFF_MAIL() {
		return STAFF_MAIL;
	}

	public void setSTAFF_MAIL(String sTAFF_MAIL) {
		STAFF_MAIL = sTAFF_MAIL;
	}

	public String getORDER_AMT() {
		return ORDER_AMT;
	}

	public void setORDER_AMT(String oRDER_AMT) {
		ORDER_AMT = oRDER_AMT;
	}

	public String getORDER_CON() {
		return ORDER_CON;
	}

	public void setORDER_CON(String oRDER_CON) {
		ORDER_CON = oRDER_CON;
	}

	public String getPAY_METD() {
		return PAY_METD;
	}

	public void setPAY_METD(String pAY_METD) {
		PAY_METD = pAY_METD;
	}

	public String getPD_CODE_LIST() {
		return PD_CODE_LIST;
	}

	public void setPD_CODE_LIST(String pD_CODE_LIST) {
		PD_CODE_LIST = pD_CODE_LIST;
	}

	public String getBIZR_NUM() {
		return BIZR_NUM;
	}

	public void setBIZR_NUM(String bIZR_NUM) {
		BIZR_NUM = bIZR_NUM;
	}

	public String getPD_CODE() {
		return PD_CODE;
	}

	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}

	public String getPD_NAME() {
		return PD_NAME;
	}

	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}

	public String getRECV_PERS() {
		return RECV_PERS;
	}

	public void setRECV_PERS(String rECV_PERS) {
		RECV_PERS = rECV_PERS;
	}

	public String getPD_PRICE() {
		return PD_PRICE;
	}

	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}

	public String getORDER_MSG() {
		return ORDER_MSG;
	}

	public void setORDER_MSG(String oRDER_MSG) {
		ORDER_MSG = oRDER_MSG;
	}

	public String getEXTRA_ADDR() {
		return EXTRA_ADDR;
	}

	public void setEXTRA_ADDR(String eXTRA_ADDR) {
		EXTRA_ADDR = eXTRA_ADDR;
	}

	public String getATFL_ID() {
		return ATFL_ID;
	}

	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}

	public String getORDER_QTY() {
		return ORDER_QTY;
	}

	public void setORDER_QTY(String oRDER_QTY) {
		ORDER_QTY = oRDER_QTY;
	}

	public String getORDER_GUBUN() {
		return ORDER_GUBUN;
	}

	public void setORDER_GUBUN(String oRDER_GUBUN) {
		ORDER_GUBUN = oRDER_GUBUN;
	}

	public String getDATE_ORDER() {
		return DATE_ORDER;
	}

	public void setDATE_ORDER(String dATE_ORDER) {
		DATE_ORDER = dATE_ORDER;
	}

	public String getCOM_NAME_ORDER() {
		return COM_NAME_ORDER;
	}

	public void setCOM_NAME_ORDER(String cOM_NAME_ORDER) {
		COM_NAME_ORDER = cOM_NAME_ORDER;
	}

	public String getSTAFF_NAME_ORDER() {
		return STAFF_NAME_ORDER;
	}

	public void setSTAFF_NAME_ORDER(String sTAFF_NAME_ORDER) {
		STAFF_NAME_ORDER = sTAFF_NAME_ORDER;
	}

	public String getARRIVAL_DATE() {
		return ARRIVAL_DATE;
	}

	public void setARRIVAL_DATE(String aRRIVAL_DATE) {
		ARRIVAL_DATE = aRRIVAL_DATE;
	}

	public String getORDER_CON_NM() {
		return ORDER_CON_NM;
	}

	public void setORDER_CON_NM(String oRDER_CON_NM) {
		ORDER_CON_NM = oRDER_CON_NM;
	}

	public String getPW_PASS() {
		return PW_PASS;
	}

	public void setPW_PASS(String pW_PASS) {
		PW_PASS = pW_PASS;
	}

	public String getCARD_ATFL() {
		return CARD_ATFL;
	}

	public void setCARD_ATFL(String cARD_ATFL) {
		CARD_ATFL = cARD_ATFL;
	}

	public String getPAY_METD_NM() {
		return PAY_METD_NM;
	}

	public void setPAY_METD_NM(String pAY_METD_NM) {
		PAY_METD_NM = pAY_METD_NM;
	}
	
}
