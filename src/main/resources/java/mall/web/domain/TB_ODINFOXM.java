package mall.web.domain;

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
@Alias("tb_odinfoxm")
@XmlRootElement(name="tb_odinfoxm")
public class TB_ODINFOXM extends DefaultDomain{

	private static final long serialVersionUID = 6909202410826056042L;
	
	/*TB_ODINFOXM*/
	private String ORDER_NUM;			//VARCHAR2(50)			주문번호
	private String ORDER_DATE;			//VARCHAR2(8)			주문일자	
	private String MEMB_YN;				//VARCHAR2(1)	Y		회원 주문 여부
	private String ORDER_PW;			//VARCHAR2(64)	Y		주문 비밀번호
	private String ORDER_AMT;			//NUMBER(15)			주문금액
	private String PRE_DLVY_AMT;		//NUMBER(15)		0	원 배송비
	private String DLVY_AMT;			//NUMBER(15)		0	배송비
	private String DAP_YN;				//VARCHAR2(1)	Y		배송비결제여부
	private String USE_SVMN;			//NUMBER(15)	Y	0	사용적립금
	private String OCCUR_SVMN;			//NUMBER(15)	Y	0	발생적립금
	private String ORDER_CON;			//VARCHAR2(35)			주문상태
	private String ORDER_CON_NM;		//VARCHAR2(35)			주문상태 명
	private String PAY_METD;			//VARCHAR2(35)			결제수단
	private String PAY_METD_NM;			//			 			결제수단 명
	private String PAY_MDKY;			//VARCHAR2(50)	Y		결제모듈키
	private String DLVY_CON;			//VARCHAR2(35)	Y		배송상태
	private String DLVY_COM;			//VARCHAR2(35)	Y		배송업체
	private String DLVY_TDN;			//VARCHAR2(50)	Y		배송운송장번호
	private String CNCL_CON;			//VARCHAR2(35)	Y		취소상태
	private String CNCL_CON_NM;			//VARCHAR2(35)			취소상태 명
	private String CNCL_REQDTM;			//DATE			Y		취소 요청일시
	private String RFND_CON;			//VARCHAR2(35)	Y		환불상태
	private String RFND_CON_NM;			//VARCHAR2(35)			환불상태 명
	private String RFND_REQDTM;			//DATE			Y		환불 요청일시
	private String CNCL_MSG;			//VARCHAR2(255)	Y		취소/환불사유
	private String PAY_AMT;				//NUMBER				PG사 결제금액
	private String DLVY_TIME;			//						배송시간
	private String PAY_DTM;				//						결제시간
	private String ORDER_DTM;			//						주문시간
	private String CPON_YN;				//VARCHAR2(1)	N		쿠폰사용여부
	private String MBDC_RATE;			//NUMBER				VIP할인율(%)
	private String ORIGIN_NUM;			//VARCHAR2(50)			원 주문번호
	private String RFND_MSG;			//VARCHAR2(35)	Y		환불사유코드
	private String RFND_MSG_NM;			//VARCHAR2(35)			환불사유 명
	private String RFND_RMK;			//VARCHAR2(255)	Y		환불거절사유
	
	/*TB_ODINFOXD*/
	private String PD_CODE;							//제품코드
	private String PD_NAME;							//제품명
	private String PD_PRICE;							//제품가격
	private String ORIGIN_QTY;						//주문수량
	private String ORDER_QTY;						//주문수량
	private String DLVY_CON_NM;					//배송상태 명
	private String DLVY_COM_NM; 					//배송업체 명
	private String DLVY_GUBN;						//상품별 배송구분
	
	
	// 상태값
	private String ORDER_GUBUN;					//주문일 or 주문자명 정렬 구분
	private String DATE_ORDER; 					//주문일 정렬 
	private String MEMB_NM_ORDER; 				//주문자명 정렬 
	private String COM_NAME_ORDER; 			//사업사명 정렬
	private String PAY_DATE_ORDER; 				//주문일 정렬
	private String DLAR_DATE_ORDER; 			//배송일시 정렬 
		
	private String ORDER_CON_STATE; 			//주문 상태변경 변수
	private String ORDER_CON_ORDER_NUM; 	//배송준비중 변경 상태 체크 항목
	
	private String CNCL_CON_STATE; 				//취소 상태변경 변수
	private String CNCL_CON_ORDER_NUM; 	//취소 상태 체크 항목
	
	
	/*TB_ODDLAIXM*/
	private String RECV_PERS;	//VARCHAR2(30)			수령인
	private String DLAR_GUBN;	//VARCHAR2(35)			배송지구분
	private String POST_NUM;	//VARCHAR2(6)			우편번호
	private String BASC_ADDR;	//VARCHAR2(200)		기본주소
	private String DTL_ADDR;	//VARCHAR2(200)		상세주소
	private String RECV_TELN;	//VARCHAR2(20)	Y		수령인 전화번호
	private String RECV_CPON;	//VARCHAR2(20)			수령인 휴대전화
	private String DLVY_MSG;	//VARCHAR2(500)	Y	배송메세지
	private String DLAR_DATE;	//								배송시간&출고시간
	private String DLAR_TIME;	//								출고일
	
	/*TB_BKINFOXM*/
	private String BSKT_REGNO;						//장바구니 등록번호
	private String BSKT_REGNO_LIST;				//장바구니에서 주문하기 선택 목록
	private String PD_CUT_SEQ_LIST;				//세절방식 리스트
	private String PD_CUT_SEQ;						//세절방식 
	private String PD_QTY;							//제품등록 수량	
	private String OPTION_CODE;					//옵션
	private String OPTION_CODE_LIST;			//옵션 리스트
			
	/*TB_PDINFOXM*/
	private String PD_STD;					//제품 규격
	private String PD_BARCD;				//제품 바코드
	private String INPUT_CNT;				//입수량
	private String ATFL_ID ; 				//파일 id(피킹리스트 이미지 삽입)
	private String RPIMG_SEQ= "";			//대표이미지 순번	NUMBER (5)
	private String PD_IWHUPRC;				//입고단가
	private String MARGIN;					// 이익율
	private String REAL_PRICE;				// 제품할인가
	

	/*TB_MBINFOXM*/
	private String MEMB_NM;					//			    				회원명
	private String COM_NAME;				//			    				회사명
	private String CAR_NUM;					//								차량번호코드
	private String CAR_NUM_NM;				//								차량번호
	private String ADM_REF;					//								관리자참조설명
	private String DLVY_CPON;				//								배송비쿠폰(갯수)	
	private String COM_BUNB;				// 								사업자번호
	private String MEMB_CPON;				// 								회원 연락처
	
	// 결제단가
	private String ORDER_PREICE;	
	private String DLAR_DATE_TIME;  // 출고 일자 시간 퓨전
	
	// 검색조건
	private String LOGIN_SUPR_ID;	// 로그인한 유저의 업체코드	
	private String ORDER_DTNUM;	
	
	
	public String getRFND_MSG_NM() {
		return RFND_MSG_NM;
	}
	public void setRFND_MSG_NM(String rFND_MSG_NM) {
		RFND_MSG_NM = rFND_MSG_NM;
	}
	public String getRFND_RMK() {
		return RFND_RMK;
	}
	public void setRFND_RMK(String rFND_RMK) {
		RFND_RMK = rFND_RMK;
	}
	public String getRFND_CON_NM() {
		return RFND_CON_NM;
	}
	public void setRFND_CON_NM(String rFND_CON_NM) {
		RFND_CON_NM = rFND_CON_NM;
	}
	public String getMEMB_CPON() {
		return MEMB_CPON;
	}
	public void setMEMB_CPON(String mEMB_CPON) {
		MEMB_CPON = mEMB_CPON;
	}
	public String getPRE_DLVY_AMT() {
		return PRE_DLVY_AMT;
	}
	public void setPRE_DLVY_AMT(String pRE_DLVY_AMT) {
		PRE_DLVY_AMT = pRE_DLVY_AMT;
	}
	public String getCOM_BUNB() {
		return COM_BUNB;
	}
	public void setCOM_BUNB(String cOM_BUNB) {
		COM_BUNB = cOM_BUNB;
	}
	public String getORDER_DTNUM() {
		return ORDER_DTNUM;
	}
	public void setORDER_DTNUM(String oRDER_DTNUM) {
		ORDER_DTNUM = oRDER_DTNUM;
	}
	public String getLOGIN_SUPR_ID() {
		return LOGIN_SUPR_ID;
	}
	public void setLOGIN_SUPR_ID(String lOGIN_SUPR_ID) {
		LOGIN_SUPR_ID = lOGIN_SUPR_ID;
	}
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getORDER_DATE() {
		return ORDER_DATE;
	}
	public void setORDER_DATE(String oRDER_DATE) {
		ORDER_DATE = oRDER_DATE;
	}
	public String getMEMB_YN() {
		return MEMB_YN;
	}
	public void setMEMB_YN(String mEMB_YN) {
		MEMB_YN = mEMB_YN;
	}
	public String getORDER_PW() {
		return ORDER_PW;
	}
	public void setORDER_PW(String oRDER_PW) {
		ORDER_PW = oRDER_PW;
	}
	public String getORDER_AMT() {
		return ORDER_AMT;
	}
	public void setORDER_AMT(String oRDER_AMT) {
		ORDER_AMT = oRDER_AMT.replaceAll("\\,", "");;
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT.replaceAll("\\,", "");
	}
	public String getDAP_YN() {
		return DAP_YN;
	}
	public void setDAP_YN(String dAP_YN) {
		DAP_YN = dAP_YN;
	}
	public String getUSE_SVMN() {
		return USE_SVMN;
	}
	public void setUSE_SVMN(String uSE_SVMN) {
		USE_SVMN = uSE_SVMN;
	}
	public String getOCCUR_SVMN() {
		return OCCUR_SVMN;
	}
	public void setOCCUR_SVMN(String oCCUR_SVMN) {
		OCCUR_SVMN = oCCUR_SVMN;
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
	public String getPAY_MDKY() {
		return PAY_MDKY;
	}
	public void setPAY_MDKY(String pAY_MDKY) {
		PAY_MDKY = pAY_MDKY;
	}
	public String getDLVY_CON() {
		return DLVY_CON;
	}
	public void setDLVY_CON(String dLVY_CON) {
		DLVY_CON = dLVY_CON;
	}
	public String getDLVY_COM() {
		return DLVY_COM;
	}
	public void setDLVY_COM(String dLVY_COM) {
		DLVY_COM = dLVY_COM;
	}
	public String getDLVY_TDN() {
		return DLVY_TDN;
	}
	public void setDLVY_TDN(String dLVY_TDN) {
		DLVY_TDN = dLVY_TDN;
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
	public String getRFND_CON() {
		return RFND_CON;
	}
	public void setRFND_CON(String rFND_CON) {
		RFND_CON = rFND_CON;
	}
	public String getRFND_REQDTM() {
		return RFND_REQDTM;
	}
	public void setRFND_REQDTM(String rFND_REQDTM) {
		RFND_REQDTM = rFND_REQDTM;
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
	public String getCOM_NAME_ORDER() {
		return COM_NAME_ORDER;
	}
	public void setCOM_NAME_ORDER(String cOM_NAME_ORDER) {
		COM_NAME_ORDER = cOM_NAME_ORDER;
	}
	public String getPAY_DATE_ORDER() {
		return PAY_DATE_ORDER;
	}
	public void setPAY_DATE_ORDER(String pAY_DATE_ORDER) {
		PAY_DATE_ORDER = pAY_DATE_ORDER;
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
	public String getORDER_GUBUN() {
		return ORDER_GUBUN;
	}
	public void setORDER_GUBUN(String oRDER_GUBUN) {
		ORDER_GUBUN = oRDER_GUBUN;
	}
	public String getMEMB_NM() {
		return MEMB_NM;
	}
	public void setMEMB_NM(String mEMB_NM) {
		MEMB_NM = mEMB_NM;
	}
	public String getORDER_CON_NM() {
		return ORDER_CON_NM;
	}
	public void setORDER_CON_NM(String oRDER_CON_NM) {
		ORDER_CON_NM = oRDER_CON_NM;
	}
	public String getPAY_METD_NM() {
		return PAY_METD_NM;
	}
	public void setPAY_METD_NM(String pAY_METD_NM) {
		PAY_METD_NM = pAY_METD_NM;
	}
	public String getORDER_CON_STATE() {
		return ORDER_CON_STATE;
	}
	public void setORDER_CON_STATE(String oRDER_CON_STATE) {
		ORDER_CON_STATE = oRDER_CON_STATE;
	}
	public String getORDER_CON_ORDER_NUM() {
		return ORDER_CON_ORDER_NUM;
	}
	public void setORDER_CON_ORDER_NUM(String oRDER_CON_ORDER_NUM) {
		ORDER_CON_ORDER_NUM = oRDER_CON_ORDER_NUM;
	}
	public String getDLVY_CON_NM() {
		return DLVY_CON_NM;
	}
	public void setDLVY_CON_NM(String dLVY_CON_NM) {
		DLVY_CON_NM = dLVY_CON_NM;
	}
	public String getDLVY_COM_NM() {
		return DLVY_COM_NM;
	}
	public void setDLVY_COM_NM(String dLVY_COM_NM) {
		DLVY_COM_NM = dLVY_COM_NM;
	}
	public String getDLAR_GUBN() {
		return DLAR_GUBN;
	}
	public void setDLAR_GUBN(String dLAR_GUBN) {
		DLAR_GUBN = dLAR_GUBN;
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
	public String getCNCL_CON_STATE() {
		return CNCL_CON_STATE;
	}
	public void setCNCL_CON_STATE(String cNCL_CON_STATE) {
		CNCL_CON_STATE = cNCL_CON_STATE;
	}
	public String getCNCL_CON_ORDER_NUM() {
		return CNCL_CON_ORDER_NUM;
	}
	public void setCNCL_CON_ORDER_NUM(String cNCL_CON_ORDER_NUM) {
		CNCL_CON_ORDER_NUM = cNCL_CON_ORDER_NUM;
	}
	public String getCNCL_CON_NM() {
		return CNCL_CON_NM;
	}
	public void setCNCL_CON_NM(String cNCL_CON_NM) {
		CNCL_CON_NM = cNCL_CON_NM;
	}
	public String getBSKT_REGNO_LIST() {
		return BSKT_REGNO_LIST;
	}
	public void setBSKT_REGNO_LIST(String bSKT_REGNO_LIST) {
		BSKT_REGNO_LIST = bSKT_REGNO_LIST;
	}
	public String getBSKT_REGNO() {
		return BSKT_REGNO;
	}
	public void setBSKT_REGNO(String bSKT_REGNO) {
		BSKT_REGNO = bSKT_REGNO;
	}
	public String getPD_QTY() {
		return PD_QTY;
	}
	public void setPD_QTY(String pD_QTY) {
		PD_QTY = pD_QTY;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}
	public String getCNCL_MSG() {
		return CNCL_MSG;
	}
	public void setCNCL_MSG(String cNCL_MSG) {
		CNCL_MSG = cNCL_MSG;
	}
	public String getPAY_AMT() {
		return PAY_AMT;
	}
	public void setPAY_AMT(String pAY_AMT) {
		PAY_AMT = pAY_AMT;
	}
	public String getPD_STD() {
		return PD_STD;
	}
	public void setPD_STD(String pD_STD) {
		PD_STD = pD_STD;
	}
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}
	public String getORIGIN_QTY() {
		return ORIGIN_QTY;
	}
	public void setORIGIN_QTY(String oRIGIN_QTY) {
		ORIGIN_QTY = oRIGIN_QTY;
	}
	public String getORDER_QTY() {
		return ORDER_QTY;
	}
	public void setORDER_QTY(String oRDER_QTY) {
		ORDER_QTY = oRDER_QTY;
	}
	public String getDLVY_TIME() {
		return DLVY_TIME;
	}
	public void setDLVY_TIME(String dLVY_TIME) {
		DLVY_TIME = dLVY_TIME;
	}
	public String getCOM_NAME() {
		return COM_NAME;
	}
	public void setCOM_NAME(String cOM_NAME) {
		COM_NAME = cOM_NAME;
	}
	public String getCAR_NUM() {
		return CAR_NUM;
	}
	public void setCAR_NUM(String cAR_NUM) {
		CAR_NUM = cAR_NUM;
	}
	public String getCAR_NUM_NM() {
		return CAR_NUM_NM;
	}
	public void setCAR_NUM_NM(String cAR_NUM_NM) {
		CAR_NUM_NM = cAR_NUM_NM;
	}
	public String getATFL_ID() {
		return ATFL_ID;
	}
	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}
	public String getRPIMG_SEQ() {
		return RPIMG_SEQ;
	}
	public void setRPIMG_SEQ(String rPIMG_SEQ) {
		RPIMG_SEQ = rPIMG_SEQ;
	}
	public String getPAY_DTM() {
		return PAY_DTM;
	}
	public void setPAY_DTM(String pAY_DTM) {
		PAY_DTM = pAY_DTM;
	}
	public String getORDER_DTM() {
		return ORDER_DTM;
	}
	public void setORDER_DTM(String oRDER_DTM) {
		ORDER_DTM = oRDER_DTM;
	}
	public String getINPUT_CNT() {
		return INPUT_CNT;
	}
	public void setINPUT_CNT(String iNPUT_CNT) {
		INPUT_CNT = iNPUT_CNT;
	}
	public String getADM_REF() {
		return ADM_REF;
	}
	public void setADM_REF(String aDM_REF) {
		ADM_REF = aDM_REF;
	}
	public String getDLAR_DATE_TIME() {
		return DLAR_DATE_TIME;
	}
	public void setDLAR_DATE_TIME(String dLAR_DATE_TIME) {
		DLAR_DATE_TIME = dLAR_DATE_TIME;
	}
	public String getORDER_PREICE() {
		return ORDER_PREICE;
	}
	public void setORDER_PREICE(String oRDER_PREICE) {
		ORDER_PREICE = oRDER_PREICE;
	}
	public String getPD_CUT_SEQ() {
		return PD_CUT_SEQ;
	}
	public void setPD_CUT_SEQ(String pD_CUT_SEQ) {
		PD_CUT_SEQ = pD_CUT_SEQ;
	}
	public String getPD_CUT_SEQ_LIST() {
		return PD_CUT_SEQ_LIST;
	}
	public void setPD_CUT_SEQ_LIST(String pD_CUT_SEQ_LIST) {
		PD_CUT_SEQ_LIST = pD_CUT_SEQ_LIST;
	}
	public String getDLAR_DATE_ORDER() {
		return DLAR_DATE_ORDER;
	}
	public void setDLAR_DATE_ORDER(String dLAR_DATE_ORDER) {
		DLAR_DATE_ORDER = dLAR_DATE_ORDER;
	}
	public String getOPTION_CODE() {
		return OPTION_CODE;
	}
	public void setOPTION_CODE(String oPTION_CODE) {
		OPTION_CODE = oPTION_CODE;
	}
	public String getOPTION_CODE_LIST() {
		return OPTION_CODE_LIST;
	}
	public void setOPTION_CODE_LIST(String oPTION_CODE_LIST) {
		OPTION_CODE_LIST = oPTION_CODE_LIST;
	}
	public String getCPON_YN() {
		return CPON_YN;
	}
	public void setCPON_YN(String cPON_YN) {
		CPON_YN = cPON_YN;
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
	public String getDLVY_GUBN() {
		return DLVY_GUBN;
	}
	public void setDLVY_GUBN(String dLVY_GUBN) {
		DLVY_GUBN = dLVY_GUBN;
	}
	public String getPD_IWHUPRC() {
		return PD_IWHUPRC;
	}
	public void setPD_IWHUPRC(String pD_IWHUPRC) {
		PD_IWHUPRC = pD_IWHUPRC;
	}
	public String getMARGIN() {
		return MARGIN;
	}
	public void setMARGIN(String mARGIN) {
		MARGIN = mARGIN;
	}
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE;
	}
	public String getORIGIN_NUM() {
		return ORIGIN_NUM;
	}
	public void setORIGIN_NUM(String oRIGIN_NUM) {
		ORIGIN_NUM = oRIGIN_NUM;
	}
	public String getRFND_MSG() {
		return RFND_MSG;
	}
	public void setRFND_MSG(String rFND_MSG) {
		RFND_MSG = rFND_MSG;
	}
	
}
