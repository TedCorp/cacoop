package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 집계정보
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-09-16 (오후 14:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_totinfoxm")
@XmlRootElement(name="tb_totinfoxm")
public class TB_TOTINFOXM extends DateDomain {

	private static final long serialVersionUID = 1L;
	
	/* TB_MBINFOXM */
	private String MEMB_ID = "";				//회원(가입) 아이디
	private String MEMB_GUBN = "";			//회원구분
	private String MEMB_GUBN_NM = "";		//회원구분명
	private String SUPR_ID = "";				//공급업체 ID
	private String MEMB_NAME = "";			//회원명
	private String MEMB_PW = "";				//회원(가입) 비밀번호
	private String MEMB_MAIL = "";			//회원 이메일
	private String MEMB_IRA = "";				//회원 이메일정보수신동의
	private String MEMB_PN = "";				//회원 우편번호
	private String MEMB_BADR = "";			//회원 기본주소
	private String MEMB_DADR = "";			//회원 상세주소
	private String MEMB_CPON = "";			//회원 핸드폰
	private String MEMB_CSRA = "";			//회원 핸드폰문자수신동의
	private String MEMB_TELN = "";			//회원 전화번호
	private String COM_NAME = "";				//회사명 
	private String COM_BUNB = "";				//회사 사업자번호
	private String COM_TELN = "";				//회사 전화번호
	private String COM_PN = "";					//회사 우편번호
	private String COM_BADR = "";				//회사 기본주소
	private String COM_DADR = "";				//회사 상세주소
	private String SCSS_YN = "";				//탈퇴여부
	
	private String AREA_GUBN;					//지역구분 (쇼핑몰 로직없음)
	private String TAXCAL_YN;					//세금계산서 발행여부
	private String BANK_NAME = "";			//은행명
	private String BANK_BUNB = "";			//계좌번호

	private String KEEP_LOCATION = "";		//상품보관장소
	private String CAR_NUM;						//차량번호
	private String ADM_REF;						//관리자 참조설명기능
		
	private String STOP_YN = "";				//회원활동상태 (활동/일시중지)
	private String STOP_DTM = "";				//회원정지일자
	private String DLVY_CPON = "";			//배송비쿠폰(갯수)	
	private String MBDC_RATE = "";			//VIP할인율(%)
	private String MONTH_YN = "";				//월간결제여부
	
	private String COM_OPEN = "";				//개점
	private String COM_CLOSE = "";			//폐점
	private String COM_OPEN_HH;				//개점 시간
	private String COM_OPEN_MM;				//개점 분
	private String COM_CLOSE_HH;				//폐점 시간
	private String COM_CLOSE_MM;			//폐점 분
	
	/* 정렬구분 */
	private String MEMB_ORD_GUBUN;		//주문일 or 주문자명 정렬 구분
	private String DATE_ORDER;			 		//주문일 정렬 
	private String MEMB_NM_ORDER; 			//주문자명 정렬 
	private String MEMB_ID_ORDER;			//주문자명 정렬 
	private String COM_NM_ORDER;			//사업자상호 정렬
	
	
	/* 집계 */
	private String ORDER_CNT;
	
	private String TOTAL_AMT_SUM;								// 누적 총 합계 (주문금액 + 반품금액)
	private String TOTAL_PROD_SUM;								// 누적 상품 합계
	private String TOTAL_DLVY_SUM;								// 누적 배송비 합계 (주문배송비 + 반품배송비)
	private String TOTAL_TAX_GUBN_01_SUM;					// 누적 과세 합계
	private String TOTAL_TAX_GUBN_02_SUM;					// 누적 면세 합계
		
	private String ORDER_AMT_SUM;								// 확정 총 합계
	private String ORDER_PROD_SUM;								// 확정 상품 합계
	private String ORDER_DLVY_SUM;								// 확정 배송비 합계
	private String ORDER_TAX_GUBN_01_SUM;					// 확정 과세 합계
	private String ORDER_TAX_GUBN_02_SUM;					// 확정 면세 합계
	private String PAY_METD_01_TAX_GUBN_01_SUM;		// 확정 신용카드 (과세) 합계
	private String PAY_METD_01_TAX_GUBN_02_SUM;		// 확정 신용카드 (면세) 합계
	private String PAY_METD_02_TAX_GUBN_01_SUM;		// 확정 무통장 (과세) 합계
	private String PAY_METD_02_TAX_GUBN_02_SUM;		// 확정 무통장 (면세) 합계
	private String TAX_GUBN;										// 과세구분
	private String PAY_GUBN;										// 결제구분
	
	private String RETURN_AMT_SUM;								// 환불 총 합계
	private String RETURN_PROD_SUM;							// 환불 상품 합계
	private String RETURN_DLVY_SUM;							// 환불 배송비 합계
	private String RETURN_TAX_GUBN_01_SUM;				// 환불 (과세) 합계
	private String RETURN_TAX_GUBN_02_SUM;				// 환불 (면세) 합계
	
	
	public String getTOTAL_PROD_SUM() {
		return TOTAL_PROD_SUM;
	}
	public void setTOTAL_PROD_SUM(String tOTAL_PROD_SUM) {
		TOTAL_PROD_SUM = tOTAL_PROD_SUM;
	}
	public String getORDER_PROD_SUM() {
		return ORDER_PROD_SUM;
	}
	public void setORDER_PROD_SUM(String oRDER_PROD_SUM) {
		ORDER_PROD_SUM = oRDER_PROD_SUM;
	}
	public String getRETURN_PROD_SUM() {
		return RETURN_PROD_SUM;
	}
	public void setRETURN_PROD_SUM(String rETURN_PROD_SUM) {
		RETURN_PROD_SUM = rETURN_PROD_SUM;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getMEMB_GUBN() {
		return MEMB_GUBN;
	}
	public void setMEMB_GUBN(String mEMB_GUBN) {
		MEMB_GUBN = mEMB_GUBN;
	}
	public String getMEMB_GUBN_NM() {
		return MEMB_GUBN_NM;
	}
	public void setMEMB_GUBN_NM(String mEMB_GUBN_NM) {
		MEMB_GUBN_NM = mEMB_GUBN_NM;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getMEMB_NAME() {
		return MEMB_NAME;
	}
	public void setMEMB_NAME(String mEMB_NAME) {
		MEMB_NAME = mEMB_NAME;
	}
	public String getMEMB_PW() {
		return MEMB_PW;
	}
	public void setMEMB_PW(String mEMB_PW) {
		MEMB_PW = mEMB_PW;
	}
	public String getMEMB_MAIL() {
		return MEMB_MAIL;
	}
	public void setMEMB_MAIL(String mEMB_MAIL) {
		MEMB_MAIL = mEMB_MAIL;
	}
	public String getMEMB_IRA() {
		return MEMB_IRA;
	}
	public void setMEMB_IRA(String mEMB_IRA) {
		MEMB_IRA = mEMB_IRA;
	}
	public String getMEMB_PN() {
		return MEMB_PN;
	}
	public void setMEMB_PN(String mEMB_PN) {
		MEMB_PN = mEMB_PN;
	}
	public String getMEMB_BADR() {
		return MEMB_BADR;
	}
	public void setMEMB_BADR(String mEMB_BADR) {
		MEMB_BADR = mEMB_BADR;
	}
	public String getMEMB_DADR() {
		return MEMB_DADR;
	}
	public void setMEMB_DADR(String mEMB_DADR) {
		MEMB_DADR = mEMB_DADR;
	}
	public String getMEMB_CPON() {
		return MEMB_CPON;
	}
	public void setMEMB_CPON(String mEMB_CPON) {
		MEMB_CPON = mEMB_CPON;
	}
	public String getMEMB_CSRA() {
		return MEMB_CSRA;
	}
	public void setMEMB_CSRA(String mEMB_CSRA) {
		MEMB_CSRA = mEMB_CSRA;
	}
	public String getMEMB_TELN() {
		return MEMB_TELN;
	}
	public void setMEMB_TELN(String mEMB_TELN) {
		MEMB_TELN = mEMB_TELN;
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
	public String getSCSS_YN() {
		return SCSS_YN;
	}
	public void setSCSS_YN(String sCSS_YN) {
		SCSS_YN = sCSS_YN;
	}
	public String getAREA_GUBN() {
		return AREA_GUBN;
	}
	public void setAREA_GUBN(String aREA_GUBN) {
		AREA_GUBN = aREA_GUBN;
	}
	public String getTAXCAL_YN() {
		return TAXCAL_YN;
	}
	public void setTAXCAL_YN(String tAXCAL_YN) {
		TAXCAL_YN = tAXCAL_YN;
	}
	public String getBANK_NAME() {
		return BANK_NAME;
	}
	public void setBANK_NAME(String bANK_NAME) {
		BANK_NAME = bANK_NAME;
	}
	public String getBANK_BUNB() {
		return BANK_BUNB;
	}
	public void setBANK_BUNB(String bANK_BUNB) {
		BANK_BUNB = bANK_BUNB;
	}
	public String getKEEP_LOCATION() {
		return KEEP_LOCATION;
	}
	public void setKEEP_LOCATION(String kEEP_LOCATION) {
		KEEP_LOCATION = kEEP_LOCATION;
	}
	public String getCAR_NUM() {
		return CAR_NUM;
	}
	public void setCAR_NUM(String cAR_NUM) {
		CAR_NUM = cAR_NUM;
	}
	public String getADM_REF() {
		return ADM_REF;
	}
	public void setADM_REF(String aDM_REF) {
		ADM_REF = aDM_REF;
	}
	public String getSTOP_YN() {
		return STOP_YN;
	}
	public void setSTOP_YN(String sTOP_YN) {
		STOP_YN = sTOP_YN;
	}
	public String getSTOP_DTM() {
		return STOP_DTM;
	}
	public void setSTOP_DTM(String sTOP_DTM) {
		STOP_DTM = sTOP_DTM;
	}
	public String getDLVY_CPON() {
		return DLVY_CPON;
	}
	public void setDLVY_CPON(String dLVY_CPON) {
		DLVY_CPON = dLVY_CPON;
	}
	public String getMBDC_RATE() {
		return MBDC_RATE;
	}
	public void setMBDC_RATE(String mBDC_RATE) {
		MBDC_RATE = mBDC_RATE;
	}
	public String getMONTH_YN() {
		return MONTH_YN;
	}
	public void setMONTH_YN(String mONTH_YN) {
		MONTH_YN = mONTH_YN;
	}
	public String getCOM_OPEN() {
		return COM_OPEN;
	}
	public void setCOM_OPEN(String cOM_OPEN) {
		COM_OPEN = cOM_OPEN;
	}
	public String getCOM_CLOSE() {
		return COM_CLOSE;
	}
	public void setCOM_CLOSE(String cOM_CLOSE) {
		COM_CLOSE = cOM_CLOSE;
	}
	public String getCOM_OPEN_HH() {
		return COM_OPEN_HH;
	}
	public void setCOM_OPEN_HH(String cOM_OPEN_HH) {
		COM_OPEN_HH = cOM_OPEN_HH;
	}
	public String getCOM_OPEN_MM() {
		return COM_OPEN_MM;
	}
	public void setCOM_OPEN_MM(String cOM_OPEN_MM) {
		COM_OPEN_MM = cOM_OPEN_MM;
	}
	public String getCOM_CLOSE_HH() {
		return COM_CLOSE_HH;
	}
	public void setCOM_CLOSE_HH(String cOM_CLOSE_HH) {
		COM_CLOSE_HH = cOM_CLOSE_HH;
	}
	public String getCOM_CLOSE_MM() {
		return COM_CLOSE_MM;
	}
	public void setCOM_CLOSE_MM(String cOM_CLOSE_MM) {
		COM_CLOSE_MM = cOM_CLOSE_MM;
	}
	public String getMEMB_ORD_GUBUN() {
		return MEMB_ORD_GUBUN;
	}
	public void setMEMB_ORD_GUBUN(String mEMB_ORD_GUBUN) {
		MEMB_ORD_GUBUN = mEMB_ORD_GUBUN;
	}
	public String getDATE_ORDER() {
		return DATE_ORDER;
	}
	public void setDATE_ORDER(String dATE_ORDER) {
		DATE_ORDER = dATE_ORDER;
	}
	public String getMEMB_NM_ORDER() {
		return MEMB_NM_ORDER;
	}
	public void setMEMB_NM_ORDER(String mEMB_NM_ORDER) {
		MEMB_NM_ORDER = mEMB_NM_ORDER;
	}
	public String getMEMB_ID_ORDER() {
		return MEMB_ID_ORDER;
	}
	public void setMEMB_ID_ORDER(String mEMB_ID_ORDER) {
		MEMB_ID_ORDER = mEMB_ID_ORDER;
	}
	public String getCOM_NM_ORDER() {
		return COM_NM_ORDER;
	}
	public void setCOM_NM_ORDER(String cOM_NM_ORDER) {
		COM_NM_ORDER = cOM_NM_ORDER;
	}
	public String getTOTAL_AMT_SUM() {
		return TOTAL_AMT_SUM;
	}
	public void setTOTAL_AMT_SUM(String tOTAL_AMT_SUM) {
		TOTAL_AMT_SUM = tOTAL_AMT_SUM;
	}
	public String getTOTAL_DLVY_SUM() {
		return TOTAL_DLVY_SUM;
	}
	public void setTOTAL_DLVY_SUM(String tOTAL_DLVY_SUM) {
		TOTAL_DLVY_SUM = tOTAL_DLVY_SUM;
	}
	public String getTOTAL_TAX_GUBN_01_SUM() {
		return TOTAL_TAX_GUBN_01_SUM;
	}
	public void setTOTAL_TAX_GUBN_01_SUM(String tOTAL_TAX_GUBN_01_SUM) {
		TOTAL_TAX_GUBN_01_SUM = tOTAL_TAX_GUBN_01_SUM;
	}
	public String getTOTAL_TAX_GUBN_02_SUM() {
		return TOTAL_TAX_GUBN_02_SUM;
	}
	public void setTOTAL_TAX_GUBN_02_SUM(String tOTAL_TAX_GUBN_02_SUM) {
		TOTAL_TAX_GUBN_02_SUM = tOTAL_TAX_GUBN_02_SUM;
	}
	public String getORDER_CNT() {
		return ORDER_CNT;
	}
	public void setORDER_CNT(String oRDER_CNT) {
		ORDER_CNT = oRDER_CNT;
	}
	public String getORDER_AMT_SUM() {
		return ORDER_AMT_SUM;
	}
	public void setORDER_AMT_SUM(String oRDER_AMT_SUM) {
		ORDER_AMT_SUM = oRDER_AMT_SUM;
	}
	public String getORDER_DLVY_SUM() {
		return ORDER_DLVY_SUM;
	}
	public void setORDER_DLVY_SUM(String oRDER_DLVY_SUM) {
		ORDER_DLVY_SUM = oRDER_DLVY_SUM;
	}
	public String getORDER_TAX_GUBN_01_SUM() {
		return ORDER_TAX_GUBN_01_SUM;
	}
	public void setORDER_TAX_GUBN_01_SUM(String oRDER_TAX_GUBN_01_SUM) {
		ORDER_TAX_GUBN_01_SUM = oRDER_TAX_GUBN_01_SUM;
	}
	public String getORDER_TAX_GUBN_02_SUM() {
		return ORDER_TAX_GUBN_02_SUM;
	}
	public void setORDER_TAX_GUBN_02_SUM(String oRDER_TAX_GUBN_02_SUM) {
		ORDER_TAX_GUBN_02_SUM = oRDER_TAX_GUBN_02_SUM;
	}
	public String getPAY_METD_01_TAX_GUBN_01_SUM() {
		return PAY_METD_01_TAX_GUBN_01_SUM;
	}
	public void setPAY_METD_01_TAX_GUBN_01_SUM(String pAY_METD_01_TAX_GUBN_01_SUM) {
		PAY_METD_01_TAX_GUBN_01_SUM = pAY_METD_01_TAX_GUBN_01_SUM;
	}
	public String getPAY_METD_01_TAX_GUBN_02_SUM() {
		return PAY_METD_01_TAX_GUBN_02_SUM;
	}
	public void setPAY_METD_01_TAX_GUBN_02_SUM(String pAY_METD_01_TAX_GUBN_02_SUM) {
		PAY_METD_01_TAX_GUBN_02_SUM = pAY_METD_01_TAX_GUBN_02_SUM;
	}
	public String getPAY_METD_02_TAX_GUBN_01_SUM() {
		return PAY_METD_02_TAX_GUBN_01_SUM;
	}
	public void setPAY_METD_02_TAX_GUBN_01_SUM(String pAY_METD_02_TAX_GUBN_01_SUM) {
		PAY_METD_02_TAX_GUBN_01_SUM = pAY_METD_02_TAX_GUBN_01_SUM;
	}
	public String getPAY_METD_02_TAX_GUBN_02_SUM() {
		return PAY_METD_02_TAX_GUBN_02_SUM;
	}
	public void setPAY_METD_02_TAX_GUBN_02_SUM(String pAY_METD_02_TAX_GUBN_02_SUM) {
		PAY_METD_02_TAX_GUBN_02_SUM = pAY_METD_02_TAX_GUBN_02_SUM;
	}
	public String getTAX_GUBN() {
		return TAX_GUBN;
	}
	public void setTAX_GUBN(String tAX_GUBN) {
		TAX_GUBN = tAX_GUBN;
	}
	public String getPAY_GUBN() {
		return PAY_GUBN;
	}
	public void setPAY_GUBN(String pAY_GUBN) {
		PAY_GUBN = pAY_GUBN;
	}
	public String getRETURN_DLVY_SUM() {
		return RETURN_DLVY_SUM;
	}
	public void setRETURN_DLVY_SUM(String rETURN_DLVY_SUM) {
		RETURN_DLVY_SUM = rETURN_DLVY_SUM;
	}
	public String getRETURN_AMT_SUM() {
		return RETURN_AMT_SUM;
	}
	public void setRETURN_AMT_SUM(String rETURN_AMT_SUM) {
		RETURN_AMT_SUM = rETURN_AMT_SUM;
	}
	public String getRETURN_TAX_GUBN_01_SUM() {
		return RETURN_TAX_GUBN_01_SUM;
	}
	public void setRETURN_TAX_GUBN_01_SUM(String rETURN_TAX_GUBN_01_SUM) {
		RETURN_TAX_GUBN_01_SUM = rETURN_TAX_GUBN_01_SUM;
	}
	public String getRETURN_TAX_GUBN_02_SUM() {
		return RETURN_TAX_GUBN_02_SUM;
	}
	public void setRETURN_TAX_GUBN_02_SUM(String rETURN_TAX_GUBN_02_SUM) {
		RETURN_TAX_GUBN_02_SUM = rETURN_TAX_GUBN_02_SUM;
	}
}
