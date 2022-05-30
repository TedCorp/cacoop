package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 회원정보 DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_mbinfoxm")
@XmlRootElement(name="tb_mbinfoxm")
public class TB_MBINFOXM extends DateDomain {

	private static final long serialVersionUID = 1L;
	
	private String MEMB_ID = "";				//회원(가입) 아이디
	private String MEMB_GUBN = "";			//회원구분
	private String MEMB_GUBN_NM = "";		//회원구분명
	private String SUPR_ID = "";				//공급업체 ID
	private String SUPMEM_APST = "";			//기업회원 승인상태
	private String SUPMEM_APST_NM = "";	//기업회원 승인상태 명
	private String APRF_RESN = "";				//승인거부 사유
	private String MEMB_NAME = "";			//회원명
	private String MEMB_PW = "";				//회원(가입) 비밀번호
	private String MEMB_SEX = "";				//회원 성별
	private String SLCAL_GUBN = "";			//음양력 구분
	private String MEMB_BTDY = "";			//회원 생년월일
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
	private String BANK_NAME = "";					//은행명
	private String BANK_BUNB = "";					//계좌번호

	private String KEEP_LOCATION = "";			//상품보관장소
	private String CAR_NUM;						//차량번호
	private String ADM_REF;						//관리자 참조설명기능
		
	private String STOP_YN = "";				//회원활동상태 (활동/일시중지)
	private String STOP_DTM = "";				//회원정지일자
	private String DLVY_CPON = "";			//배송비쿠폰(갯수)	
	private String MBDC_RATE = "";			//VIP할인율(%)
	private String MONTH_YN = "";				//월간결제여부
	
	private String COM_OPEN = "";					//개점
	private String COM_CLOSE = "";					//폐점
	private String COM_OPEN_HH;				//개점 시간
	private String COM_OPEN_MM;				//개점 분
	private String COM_CLOSE_HH;				//폐점 시간
	private String COM_CLOSE_MM;			//폐점 분
	
	private String MEMB_ORD_GUBUN;		//주문일 or 주문자명 정렬 구분
	private String DATE_ORDER;			 		//주문일 정렬 
	private String MEMB_NM_ORDER; 			//주문자명 정렬 
	private String MEMB_ID_ORDER;			//주문자명 정렬 
	private String COM_NM_ORDER;			//사업자상호 정렬
	
	private String CACOOP_NO = "";			//조합원 번호
	
	
	//회원매출집계컬럼
	private String ORDER_CNT;
	private String ORDER_AMT_SUM;
	private String DLVY_AMT_SUM;
	private String TAX_GUBN_01_SUM;
	private String TAX_GUBN_02_SUM;
	private String PAY_METD_01_TAX_GUBN_01_SUM;
	private String PAY_METD_01_TAX_GUBN_02_SUM;
	private String PAY_METD_02_TAX_GUBN_01_SUM;
	private String PAY_METD_02_TAX_GUBN_02_SUM;
	private String TAX_GUBN;					//세금구분
	private String PAY_GUBN;					//결제구분
	
	//반품추가
	private String DLVY_AMT_SUM_RT;
	private String ORDER_AMT_SUM_BEFORE_RT;
	private String TAX_GUBN_01_SUM_RT;
	private String TAX_GUBN_02_SUM_RT;
	private String AMT_TOTAL;	
	
	// 회원구분용
	private String MEMB_ID_TMP = "";			//회원아이디 임시(중복체크 비교용)
	private String COM_BUNB_TMP = "";		//회사 사업자번호 임시(중복체크 비교용)
	private String SUPR_FLAG ="";				//기업회원 등록과 수정 구분용
	
	
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
	public String getAPRF_RESN() {
		return APRF_RESN;
	}
	public void setAPRF_RESN(String aPRF_RESN) {
		APRF_RESN = aPRF_RESN;
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
	public String getMEMB_SEX() {
		return MEMB_SEX;
	}
	public void setMEMB_SEX(String mEMB_SEX) {
		MEMB_SEX = mEMB_SEX;
	}
	public String getMEMB_BTDY() {
		return MEMB_BTDY;
	}
	public void setMEMB_BTDY(String mEMB_BTDY) {
		MEMB_BTDY = mEMB_BTDY;
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
	public String getSUPMEM_APST() {
		return SUPMEM_APST;
	}
	public void setSUPMEM_APST(String sUPMEM_APST) {
		SUPMEM_APST = sUPMEM_APST;
	}
	public String getSLCAL_GUBN() {
		return SLCAL_GUBN;
	}
	public void setSLCAL_GUBN(String sLCAL_GUBN) {
		SLCAL_GUBN = sLCAL_GUBN;
	}
	public String getCOM_BUNB() {
		return COM_BUNB;
	}
	public void setCOM_BUNB(String cOM_BUNB) {
		COM_BUNB = cOM_BUNB;
	}
	public String getSUPMEM_APST_NM() {
		return SUPMEM_APST_NM;
	}
	public void setSUPMEM_APST_NM(String sUPMEM_APST_NM) {
		SUPMEM_APST_NM = sUPMEM_APST_NM;
	}
	public String getMEMB_ID_TMP() {
		return MEMB_ID_TMP;
	}
	public void setMEMB_ID_TMP(String mEMB_ID_TMP) {
		MEMB_ID_TMP = mEMB_ID_TMP;
	}
	public String getSUPR_FLAG() {
		return SUPR_FLAG;
	}
	public void setSUPR_FLAG(String sUPR_FLAG) {
		SUPR_FLAG = sUPR_FLAG;
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
	public String getCACOOP_NO() {
		return CACOOP_NO;
	}
	public void setCACOOP_NO(String cACOOP_NO) {
		CACOOP_NO = cACOOP_NO;
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
	public String getDLVY_AMT_SUM() {
		return DLVY_AMT_SUM;
	}
	public void setDLVY_AMT_SUM(String dLVY_AMT_SUM) {
		DLVY_AMT_SUM = dLVY_AMT_SUM;
	}
	public String getTAX_GUBN_01_SUM() {
		return TAX_GUBN_01_SUM;
	}
	public void setTAX_GUBN_01_SUM(String tAX_GUBN_01_SUM) {
		TAX_GUBN_01_SUM = tAX_GUBN_01_SUM;
	}
	public String getTAX_GUBN_02_SUM() {
		return TAX_GUBN_02_SUM;
	}
	public void setTAX_GUBN_02_SUM(String tAX_GUBN_02_SUM) {
		TAX_GUBN_02_SUM = tAX_GUBN_02_SUM;
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
	public String getDLVY_AMT_SUM_RT() {
		return DLVY_AMT_SUM_RT;
	}
	public void setDLVY_AMT_SUM_RT(String dLVY_AMT_SUM_RT) {
		DLVY_AMT_SUM_RT = dLVY_AMT_SUM_RT;
	}
	public String getORDER_AMT_SUM_BEFORE_RT() {
		return ORDER_AMT_SUM_BEFORE_RT;
	}
	public void setORDER_AMT_SUM_BEFORE_RT(String oRDER_AMT_SUM_BEFORE_RT) {
		ORDER_AMT_SUM_BEFORE_RT = oRDER_AMT_SUM_BEFORE_RT;
	}
	public String getTAX_GUBN_01_SUM_RT() {
		return TAX_GUBN_01_SUM_RT;
	}
	public void setTAX_GUBN_01_SUM_RT(String tAX_GUBN_01_SUM_RT) {
		TAX_GUBN_01_SUM_RT = tAX_GUBN_01_SUM_RT;
	}
	public String getTAX_GUBN_02_SUM_RT() {
		return TAX_GUBN_02_SUM_RT;
	}
	public void setTAX_GUBN_02_SUM_RT(String tAX_GUBN_02_SUM_RT) {
		TAX_GUBN_02_SUM_RT = tAX_GUBN_02_SUM_RT;
	}	
	public String getAMT_TOTAL() {
		return AMT_TOTAL;
	}
	public void setAMT_TOTAL(String aMT_TOTAL) {
		AMT_TOTAL = aMT_TOTAL;
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
	public String getCOM_BUNB_TMP() {
		return COM_BUNB_TMP;
	}
	public void setCOM_BUNB_TMP(String cOM_BUNB_TMP) {
		COM_BUNB_TMP = cOM_BUNB_TMP;
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
	public String getMONTH_YN() {
		return MONTH_YN;
	}
	public void setMONTH_YN(String mONTH_YN) {
		MONTH_YN = mONTH_YN;
	}
	public String getMBDC_RATE() {
		return MBDC_RATE;
	}
	public void setMBDC_RATE(String mBDC_RATE) {
		MBDC_RATE = mBDC_RATE;
	}
	
}
