package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문정보 상세 DTO
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_odinfoxd")
@XmlRootElement(name="tb_odinfoxd")
public class TB_ODINFOXD extends DefaultDomain{
	
	private static final long serialVersionUID = -1471161809434513649L;
	
	/* TB_ODINFOXD */
	private String ORDER_DTNUM;				//NUMBER(5)				주문상세번호
	private String ORDER_NUM;				//VARCHAR2(50)			주문번호
	private String PD_CODE;					//VARCHAR2(20)			제품코드
	private String PD_NAME;					//VARCHAR2(30)			제품명
	private String PD_PRICE;				//NUMBER(15)				제품가격
	private String REAL_PRICE;				//NUMBER(15)				제품판매가격
	private String PDDC_GUBN;				//VARCHAR2(35)			제품할인 구분
	private String PDDC_VAL;				//NUMBER(15)				제품할인 값
	private String ORIGIN_QTY;				//NUMBER(5)				원 주문수량
	private String ORDER_QTY;				//NUMBER(5)				주문 수량
	private String ORDER_AMT;				//NUMBER(15)				주문금액
	private String DLVY_AMT;				//NUMBER(15)	Y			배송비
	private String USE_SVMN;				//NUMBER(15)	Y			사용적립금
	private String OCCUR_SVMN;				//NUMBER(15)	Y			발생적립금
	private String ORDER_CON;				//VARCHAR2(35)	Y		주문상태
	private String ORDER_CON_NM;			//VARCHAR2(35)			주문상태 명
	private String PAY_METD;				//VARCHAR2(35)	Y		결제수단
	private String PAY_MDKY;				//VARCHAR2(50)	Y		결제모듈키
	private String DLVY_CON;				//VARCHAR2(35)	Y		배송상태
	private String DLVY_COM;				//VARCHAR2(35)	Y		배송업체
	private String DLVY_TDN;				//VARCHAR2(50)	Y		배송운송장번호
	private String CNCL_CON;				//VARCHAR2(35)	Y		취소상태
	private String CNCL_MSG;				//VARCHAR2(255)	Y		취소/환불사유
	private String RFND_CON;				//VARCHAR2(35)	Y		환불상태
	private String RFND_AMT;				//NUMBER(15)			환불금액
	private String RFND_DLVY_TDN;			//VARCHAR2(2000)        환불운송장번호
	private String DTL_RFND_DLVY_TDN;			//VARCHAR2(2000)        환불운송장번호
	private String RFND_DLVY_AMT;			//환불배송비
	private String ATFL_ID ; 				//파일 id(피킹리스트 이미지 삽입)
	private String RPIMG_SEQ;				//대표이미지 순번	NUMBER (5)
	
	/* TB_BKINFOXM */
	private String BSKT_REGNO;				//VARCHAR2(35)	Y		장바구니등록번호
	private String SETPD_CODE;				//VARCHAR2(16)			묶음상품코드
	
	
	/* TB_PDINFOXM */
	private String BOX_PDDC_GUBN;			//								박스할인구분
	private String BOX_PDDC_VAL;			//								박스할인값
	private String INPUT_CNT;				//								입수량
	private String BUNDLE_CNT;				//VARCHAR2(30)			상품묶음단위
	private String PD_CUT_SEQ;				//VARCHAR2(10) 			제품세절방식
	private String PD_CUT_SEQ_UNIT;			//VARCHAR2(10) 			제품세절방식
	private String OPTION_CODE;				//VARCHAR2(35) 			선택옵션
	private String OPTION_NAME;				//VARCHAR2(35) 			선택옵션이름
	private String DLVY_GUBN;				//VARCHAR2(35)	 		상품별 배송구분
	private String PD_QTY;					//VARCHAR2(35)	 		상품별 수량
	private String[] PD_QTYs;				//VARCHAR2(35)	 		상품별 수량
	private String IMGURL;
	
	/* TB_SPINFOXM */
	private String DLVA_FCON;				//NUMBER				배송비 무료조건
	private String SUPR_DLVY_AMT; 									//공급사 배송비
	
	//
	private String[] ORDER_DTNUMS;			//NUMBER(5)				주문상세번호
	private String[] PD_CODES;				//VARCHAR2(20)			제품코드
	private String[] PD_NAMES;				//VARCHAR2(30)			제품명
	private String[] PD_PRICES;				//NUMBER(15)				제품가격
	private String[] REAL_PRICES;			//NUMBER(15)				제품할인 적용가
	private String[] PDDC_GUBNS;			//VARCHAR2(35)			제품할인 구분
	private String[] PDDC_VALS;				//NUMBER(15)				제품할인 값
	private String[] ORIGIN_QTYS;			//NUMBER(5)				원 주문수량
	private String[] ORDER_QTYS;			//NUMBER(5)				주문 수량
	private String[] ORDER_AMTS;			//NUMBER(15)				주문금액
	private String[] EDIT_GBNS;				//VARCHAR2(4000)		증감구분
	private String[] PD_CUT_SEQS;			//VARCHAR2(10) 			제품세절방식
	private String[] OPTION_CODES;		//VARCHAR2(35) 			선택옵션
	private String[] BOX_PDDC_GUBNS;	//VARCHAR2(35)			박스할인구분
	private String[] BOX_PDDC_VALS;		//NUMBER(15)				박스할인값
	private String[] INPUT_CNTS;			//								입수량
	private String[] DLVY_TDNS;				//								운송장번호
	private String[] DLVY_AMTS;				//								배송비
	private String[] SETPD_CODES;			//								묶음상품코드
	
	private String SUPR_ID;					//								업체정보 2020-02-25	
	private String DTL_DLVY_TDN;			//								DTL 운송장번호		 2020-03-11	
	private String LOGIN_SUPR_ID;		//								현재로그인된 SUPR_ID정보 / 업데이트 컨트롤 위함		 2020-03-12
	private String DTL_ORDER_CON;
	
	private String EXCEL_CODE;	// 엑셀업로드 관리
	private String EXCEL_MSG;	// 엑셀업로드 관리
	private String ORDER_NM;	// 주문자명
	private String ORDER_ADDR;	// 주문자주소
	private Object obj;
	
	private String OPTION1_NAME;		//옵션명1(연동상품)
	private String OPTION1_VALUE;		//옵션값1(연동상품)
	private String OPTION2_NAME;		//옵션명2(연동상품)
	private String OPTION2_VALUE;		//옵션값2(연동상품)
	private String OPTION3_NAME;		//옵션명3(연동상품)
	private String OPTION3_VALUE;		//옵션값3(연동상품)
	
	private String[] OPTION1_NAMES;		//옵션명1(연동상품)
	private String[] OPTION1_VALUES;		//옵션값1(연동상품)
	private String[] OPTION2_NAMES;		//옵션명2(연동상품)
	private String[] OPTION2_VALUES;		//옵션값2(연동상품)
	private String[] OPTION3_NAMES;		//옵션명3(연동상품)
	private String[] OPTION3_VALUES;		//옵션값3(연동상품)
	
	private String OPTION1;		//옵션값2(연동상품)
	private String OPTION2;		//옵션값2(연동상품)
	private String OPTION3;		//옵션값3(연동상품)
	
	private String LINK_MODP_DATE;
	private String LINK_ORDER_KEY;

	/* TB_MBINFOXM */
	private String MEMB_NAME;
	private String MEMB_CPON;
	private String MEMB_GUBN; //멤버권한 구분
	private String MEMB_ID;
	
	
	/* TB_ODINFOXM */
	private String ORDER_DTM;
	
	private String DLVY_MSG;
	private String RECV_TELN;
	
	private String PAY_METD_NM;	  //결제방법
	private String DLVY_CON_NM;	  //배송상태
	private String DLVY_COM_NAME; //택배사이름
	
	private String TOTAL_CANCEL;
	
	/* TB_EXTRPROD */
	private String EXTRA_PD_CODE;
	private String EXTRA_PD_QTY;
	
	private String MEMBERS_PRICE;
	
	
	
	
	public String getMEMBERS_PRICE() {
		return MEMBERS_PRICE;
	}
	public void setMEMBERS_PRICE(String mEMBERS_PRICE) {
		MEMBERS_PRICE = mEMBERS_PRICE;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getDTL_RFND_DLVY_TDN() {
		return DTL_RFND_DLVY_TDN;
	}
	public void setDTL_RFND_DLVY_TDN(String dTL_RFND_DLVY_TDN) {
		DTL_RFND_DLVY_TDN = dTL_RFND_DLVY_TDN;
	}
	
	public String getRFND_DLVY_TDN() {
		return RFND_DLVY_TDN;
	}
	public void setRFND_DLVY_TDN(String rFND_DLVY_TDN) {
		RFND_DLVY_TDN = rFND_DLVY_TDN;
	}
	public String getTOTAL_CANCEL() {
		return TOTAL_CANCEL;
	}
	public void setTOTAL_CANCEL(String tOTAL_CANCEL) {
		TOTAL_CANCEL = tOTAL_CANCEL;
	}
	public String getPAY_METD_NM() {
		return PAY_METD_NM;
	}
	public void setPAY_METD_NM(String pAY_METD_NM) {
		PAY_METD_NM = pAY_METD_NM;
	}
	public String getDLVY_CON_NM() {
		return DLVY_CON_NM;
	}
	public void setDLVY_CON_NM(String dLVY_CON_NM) {
		DLVY_CON_NM = dLVY_CON_NM;
	}
	public String getDLVY_COM_NAME() {
		return DLVY_COM_NAME;
	}
	public void setDLVY_COM_NAME(String dLVY_COM_NAME) {
		DLVY_COM_NAME = dLVY_COM_NAME;
	}
	public String getMEMB_GUBN() {
		return MEMB_GUBN;
	}
	public void setMEMB_GUBN(String mEMB_GUBN) {
		MEMB_GUBN = mEMB_GUBN;
	}
	public String getRECV_TELN() {
		return RECV_TELN;
	}
	public void setRECV_TELN(String rECV_TELN) {
		RECV_TELN = rECV_TELN;
	}
	public String getDLVY_MSG() {
		return DLVY_MSG;
	}
	public void setDLVY_MSG(String dLVY_MSG) {
		DLVY_MSG = dLVY_MSG;
	}
	public String getORDER_DTM() {
		return ORDER_DTM;
	}
	public void setORDER_DTM(String oRDER_DTM) {
		ORDER_DTM = oRDER_DTM;
	}
	public String getORIGIN_QTY() {
		return ORIGIN_QTY;
	}
	public void setORIGIN_QTY(String oRIGIN_QTY) {
		ORIGIN_QTY = oRIGIN_QTY;
	}
	public String[] getORIGIN_QTYS() {
		return ORIGIN_QTYS;
	}
	public void setORIGIN_QTYS(String[] oRIGIN_QTYS) {
		ORIGIN_QTYS = oRIGIN_QTYS;
	}
	public String[] getORDER_DTNUMS() {
		return ORDER_DTNUMS;
	}
	public void setORDER_DTNUMS(String[] oRDER_DTNUMS) {
		ORDER_DTNUMS = oRDER_DTNUMS;
	}
	public String[] getREAL_PRICES() {
		return REAL_PRICES;
	}
	public void setREAL_PRICES(String[] rEAL_PRICES) {
		REAL_PRICES = rEAL_PRICES;
	}
	public String[] getEDIT_GBNS() {
		return EDIT_GBNS;
	}
	public void setEDIT_GBNS(String[] eDIT_GBNS) {
		EDIT_GBNS = eDIT_GBNS;
	}
	public String getDTL_ORDER_CON() {
		return DTL_ORDER_CON;
	}
	public void setDTL_ORDER_CON(String dTL_ORDER_CON) {
		DTL_ORDER_CON = dTL_ORDER_CON;
	}
	public String getLINK_MODP_DATE() {
		return LINK_MODP_DATE;
	}
	public void setLINK_MODP_DATE(String lINK_MODP_DATE) {
		LINK_MODP_DATE = lINK_MODP_DATE;
	}
	public String getLINK_ORDER_KEY() {
		return LINK_ORDER_KEY;
	}
	public void setLINK_ORDER_KEY(String lINK_ORDER_KEY) {
		LINK_ORDER_KEY = lINK_ORDER_KEY;
	}
	public String[] getOPTION1_NAMES() {
		return OPTION1_NAMES;
	}
	public void setOPTION1_NAMES(String[] oPTION1_NAMES) {
		OPTION1_NAMES = oPTION1_NAMES;
	}
	public String[] getOPTION1_VALUES() {
		return OPTION1_VALUES;
	}
	public void setOPTION1_VALUES(String[] oPTION1_VALUES) {
		OPTION1_VALUES = oPTION1_VALUES;
	}
	public String[] getOPTION2_NAMES() {
		return OPTION2_NAMES;
	}
	public void setOPTION2_NAMES(String[] oPTION2_NAMES) {
		OPTION2_NAMES = oPTION2_NAMES;
	}
	public String[] getOPTION2_VALUES() {
		return OPTION2_VALUES;
	}
	public void setOPTION2_VALUES(String[] oPTION2_VALUES) {
		OPTION2_VALUES = oPTION2_VALUES;
	}
	public String getOPTION1_NAME() {
		return OPTION1_NAME;
	}
	public void setOPTION1_NAME(String oPTION1_NAME) {
		OPTION1_NAME = oPTION1_NAME;
	}
	public String getOPTION1_VALUE() {
		return OPTION1_VALUE;
	}
	public void setOPTION1_VALUE(String oPTION1_VALUE) {
		OPTION1_VALUE = oPTION1_VALUE;
	}
	public String getOPTION2_NAME() {
		return OPTION2_NAME;
	}
	public void setOPTION2_NAME(String oPTION2_NAME) {
		OPTION2_NAME = oPTION2_NAME;
	}
	public String getOPTION2_VALUE() {
		return OPTION2_VALUE;
	}
	public void setOPTION2_VALUE(String oPTION2_VALUE) {
		OPTION2_VALUE = oPTION2_VALUE;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public String getORDER_NM() {
		return ORDER_NM;
	}
	public void setORDER_NM(String oRDER_NM) {
		ORDER_NM = oRDER_NM;
	}
	public String getORDER_ADDR() {
		return ORDER_ADDR;
	}
	public void setORDER_ADDR(String oRDER_ADDR) {
		ORDER_ADDR = oRDER_ADDR;
	}
	public String getEXCEL_CODE() {
		return EXCEL_CODE;
	}
	public void setEXCEL_CODE(String eXCEL_CODE) {
		EXCEL_CODE = eXCEL_CODE;
	}
	public String getEXCEL_MSG() {
		return EXCEL_MSG;
	}
	public void setEXCEL_MSG(String eXCEL_MSG) {
		EXCEL_MSG = eXCEL_MSG;
	}
	public String getLOGIN_SUPR_ID() {
		return LOGIN_SUPR_ID;
	}
	public void setLOGIN_SUPR_ID(String lOGIN_SUPR_ID) {
		LOGIN_SUPR_ID = lOGIN_SUPR_ID;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getORDER_DTNUM() {
		return ORDER_DTNUM;
	}
	public void setORDER_DTNUM(String oRDER_DTNUM) {
		ORDER_DTNUM = oRDER_DTNUM;
	}
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
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
	public String getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}
	public String getPDDC_GUBN() {
		return PDDC_GUBN;
	}
	public void setPDDC_GUBN(String pDDC_GUBN) {
		PDDC_GUBN = pDDC_GUBN;
	}
	public String getPDDC_VAL() {
		return PDDC_VAL;
	}
	public void setPDDC_VAL(String pDDC_VAL) {
		PDDC_VAL = pDDC_VAL;
	}
	public String getBUNDLE_CNT() {
		return BUNDLE_CNT;
	}
	public void setBUNDLE_CNT(String bUNDLE_CNT) {
		BUNDLE_CNT = bUNDLE_CNT;
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
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT;
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
	public String getORDER_CON_NM() {
		return ORDER_CON_NM;
	}
	public void setORDER_CON_NM(String oRDER_CON_NM) {
		ORDER_CON_NM = oRDER_CON_NM;
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
	public String getCNCL_MSG() {
		return CNCL_MSG;
	}
	public void setCNCL_MSG(String cNCL_MSG) {
		CNCL_MSG = cNCL_MSG;
	}
	public String getRFND_CON() {
		return RFND_CON;
	}
	public void setRFND_CON(String rFND_CON) {
		RFND_CON = rFND_CON;
	}
	public String getRFND_AMT() {
		return RFND_AMT;
	}
	public void setRFND_AMT(String rFND_AMT) {
		RFND_AMT = rFND_AMT;
	}
	public String[] getPD_CODES() {
		return PD_CODES;
	}
	public void setPD_CODES(String[] pD_CODES) {
		PD_CODES = pD_CODES;
	}
	public String[] getPD_NAMES() {
		return PD_NAMES;
	}
	public void setPD_NAMES(String[] pD_NAMES) {
		PD_NAMES = pD_NAMES;
	}
	public String[] getPD_PRICES() {
		return PD_PRICES;
	}
	public void setPD_PRICES(String[] pD_PRICES) {
		PD_PRICES = pD_PRICES;
	}
	public String[] getPDDC_GUBNS() {
		return PDDC_GUBNS;
	}
	public void setPDDC_GUBNS(String[] pDDC_GUBNS) {
		PDDC_GUBNS = pDDC_GUBNS;
	}
	public String[] getPDDC_VALS() {
		return PDDC_VALS;
	}
	public void setPDDC_VALS(String[] pDDC_VALS) {
		PDDC_VALS = pDDC_VALS;
	}
	public String[] getORDER_QTYS() {
		return ORDER_QTYS;
	}
	public void setORDER_QTYS(String[] oRDER_QTYS) {
		ORDER_QTYS = oRDER_QTYS;
	}
	public String[] getORDER_AMTS() {
		return ORDER_AMTS;
	}
	public void setORDER_AMTS(String[] oRDER_AMTS) {
		ORDER_AMTS = oRDER_AMTS;
	}
	public String getBSKT_REGNO() {
		return BSKT_REGNO;
	}
	public void setBSKT_REGNO(String bSKT_REGNO) {
		BSKT_REGNO = bSKT_REGNO;
	}
	public String getSETPD_CODE() {
		return SETPD_CODE;
	}
	public void setSETPD_CODE(String sETPD_CODE) {
		SETPD_CODE = sETPD_CODE;
	}
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE;
	}
	public String getPD_CUT_SEQ() {
		return PD_CUT_SEQ;
	}
	public void setPD_CUT_SEQ(String pD_CUT_SEQ) {
		PD_CUT_SEQ = pD_CUT_SEQ;
	}
	public String[] getPD_CUT_SEQS() {
		return PD_CUT_SEQS;
	}
	public void setPD_CUT_SEQS(String[] pD_CUT_SEQS) {
		PD_CUT_SEQS = pD_CUT_SEQS;
	}
	public String getPD_CUT_SEQ_UNIT() {
		return PD_CUT_SEQ_UNIT;
	}
	public void setPD_CUT_SEQ_UNIT(String pD_CUT_SEQ_UNIT) {
		PD_CUT_SEQ_UNIT = pD_CUT_SEQ_UNIT;
	}
	public String getOPTION_CODE() {
		return OPTION_CODE;
	}
	public void setOPTION_CODE(String oPTION_CODE) {
		OPTION_CODE = oPTION_CODE;
	}
	public String[] getOPTION_CODES() {
		return OPTION_CODES;
	}
	public void setOPTION_CODES(String[] oPTION_CODES) {
		OPTION_CODES = oPTION_CODES;
	}
	public String getBOX_PDDC_GUBN() {
		return BOX_PDDC_GUBN;
	}
	public void setBOX_PDDC_GUBN(String bOX_PDDC_GUBN) {
		BOX_PDDC_GUBN = bOX_PDDC_GUBN;
	}
	public String getBOX_PDDC_VAL() {
		return BOX_PDDC_VAL;
	}
	public void setBOX_PDDC_VAL(String bOX_PDDC_VAL) {
		BOX_PDDC_VAL = bOX_PDDC_VAL;
	}
	public String[] getBOX_PDDC_GUBNS() {
		return BOX_PDDC_GUBNS;
	}
	public void setBOX_PDDC_GUBNS(String[] bOX_PDDC_GUBNS) {
		BOX_PDDC_GUBNS = bOX_PDDC_GUBNS;
	}
	public String[] getBOX_PDDC_VALS() {
		return BOX_PDDC_VALS;
	}
	public void setBOX_PDDC_VALS(String[] bOX_PDDC_VALS) {
		BOX_PDDC_VALS = bOX_PDDC_VALS;
	}
	public String getINPUT_CNT() {
		return INPUT_CNT;
	}
	public void setINPUT_CNT(String iNPUT_CNT) {
		INPUT_CNT = iNPUT_CNT;
	}
	public String[] getINPUT_CNTS() {
		return INPUT_CNTS;
	}
	public void setINPUT_CNTS(String[] iNPUT_CNTS) {
		INPUT_CNTS = iNPUT_CNTS;
	}
	public String getOPTION_NAME() {
		return OPTION_NAME;
	}
	public void setOPTION_NAME(String oPTION_NAME) {
		OPTION_NAME = oPTION_NAME;
	}
	public String getDLVY_GUBN() {
		return DLVY_GUBN;
	}
	public void setDLVY_GUBN(String dLVY_GUBN) {
		DLVY_GUBN = dLVY_GUBN;
	}
	public String getDTL_DLVY_TDN() {
		return DTL_DLVY_TDN;
	}
	public void setDTL_DLVY_TDN(String dTL_DLVY_TDN) {
		DTL_DLVY_TDN = dTL_DLVY_TDN;
	}
	public String getMEMB_NAME() {
		return MEMB_NAME;
	}
	public void setMEMB_NAME(String mEMB_NAME) {
		MEMB_NAME = mEMB_NAME;
	}
	public String getMEMB_CPON() {
		return MEMB_CPON;
	}
	public void setMEMB_CPON(String mEMB_CPON) {
		MEMB_CPON = mEMB_CPON;
	}
	public String[] getDLVY_TDNS() {
		return DLVY_TDNS;
	}
	public void setDLVY_TDNS(String[] dLVY_TDNS) {
		DLVY_TDNS = dLVY_TDNS;
	}
	public String[] getDLVY_AMTS() {
		return DLVY_AMTS;
	}
	public void setDLVY_AMTS(String[] dLVY_AMTS) {
		DLVY_AMTS = dLVY_AMTS;
	}
	public String[] getSETPD_CODES() {
		return SETPD_CODES;
	}
	public void setSETPD_CODES(String[] sETPD_CODES) {
		SETPD_CODES = sETPD_CODES;
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
	public String getOPTION1() {
		return OPTION1;
	}
	public void setOPTION1(String oPTION1) {
		OPTION1 = oPTION1;
	}
	public String getOPTION2() {
		return OPTION2;
	}
	public void setOPTION2(String oPTION2) {
		OPTION2 = oPTION2;
	}
	public String[] getPD_QTYs() {
		return PD_QTYs;
	}
	public void setPD_QTYs(String[] pD_QTYs) {
		PD_QTYs = pD_QTYs;
	}
	public String getPD_QTY() {
		return PD_QTY;
	}
	public void setPD_QTY(String pD_QTY) {
		PD_QTY = pD_QTY;
	}
	public String getDLVA_FCON() {
		return DLVA_FCON;
	}
	public void setDLVA_FCON(String dLVA_FCON) {
		DLVA_FCON = dLVA_FCON;
	}
	public String getSUPR_DLVY_AMT() {
		return SUPR_DLVY_AMT;
	}
	public void setSUPR_DLVY_AMT(String sUPR_DLVY_AMT) {
		SUPR_DLVY_AMT = sUPR_DLVY_AMT;
	}
	public String getOPTION3_NAME() {
		return OPTION3_NAME;
	}
	public void setOPTION3_NAME(String oPTION3_NAME) {
		OPTION3_NAME = oPTION3_NAME;
	}
	public String getOPTION3_VALUE() {
		return OPTION3_VALUE;
	}
	public void setOPTION3_VALUE(String oPTION3_VALUE) {
		OPTION3_VALUE = oPTION3_VALUE;
	}
	public String getOPTION3() {
		return OPTION3;
	}
	public void setOPTION3(String oPTION3) {
		OPTION3 = oPTION3;
	}
	public String[] getOPTION3_NAMES() {
		return OPTION3_NAMES;
	}
	public void setOPTION3_NAMES(String[] oPTION3_NAMES) {
		OPTION3_NAMES = oPTION3_NAMES;
	}
	public String[] getOPTION3_VALUES() {
		return OPTION3_VALUES;
	}
	public void setOPTION3_VALUES(String[] oPTION3_VALUES) {
		OPTION3_VALUES = oPTION3_VALUES;
	}
	public String getRFND_DLVY_AMT() {
		return RFND_DLVY_AMT;
	}
	public void setRFND_DLVY_AMT(String rFND_DLVY_AMT) {
		RFND_DLVY_AMT = rFND_DLVY_AMT.replaceAll("\\,", "");
	}
	public String getEXTRA_PD_CODE() {
		return EXTRA_PD_CODE;
	}
	public void setEXTRA_PD_CODE(String eXTRA_PD_CODE) {
		EXTRA_PD_CODE = eXTRA_PD_CODE;
	}
	public String getEXTRA_PD_QTY() {
		return EXTRA_PD_QTY;
	}
	public void setEXTRA_PD_QTY(String eXTRA_PD_QTY) {
		EXTRA_PD_QTY = eXTRA_PD_QTY;
	}
	public String getIMGURL() {
		return IMGURL;
	}
	public void setIMGURL(String iMGURL) {
		IMGURL = iMGURL;
	}

	
}
