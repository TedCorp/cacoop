package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdinfoxm")
@XmlRootElement(name="tb_pdinfoxm")
public class TB_PDINFOXM extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_PDINFOXM	*/
	private String PD_CODE= "";					//VARCHAR2 (20 Byte)		제품코드	
	private String SUPR_ID= "";						//VARCHAR2 (12 Byte)		공급업체 ID	
	private String SUPR_NAME= "";					//VARCHAR2 (12 Byte)		공급업체명
	private String PD_NAME= "";					//VARCHAR2 (30 Byte)		제품명	None
	private String CAGO_ID= "";						//VARCHAR2 (50 Byte)		카테고리ID	
	private String PD_PRICE= "";					//NUMBER (15)				제품가격
	private String PDDC_GUBN= "";				//VARCHAR2 (35 Byte)		제품할인 구분
	private String PDDC_GUBN_NM= "";			//									제품할인명
	private String PDDC_VAL= "";					//NUMBER (15)	0			제품할인 값	
	private String SVMN_GUBN= "";				//VARCHAR2 (35 Byte)		적립금 구분	
	private String SVMN_VAL= "";					//NUMBER (15)				적립 값
	private String INVEN_QTY= "";					//NUMBER (5)					재고수량
	private String POS_NAME= "";					//VARCHAR2 (30 Byte)		POS명
	private String PD_BARCD= "";					//VARCHAR2 (13 Byte)		제품바코드	
	private String STORE_CTR= "";					//VARCHAR2 (100 Byte)	보관기준 (사용안함)
	private String PD_STD= "";						//VARCHAR2 (100 Byte)	제품규격
	private String DTB_DLINE= "";					//VARCHAR2 (8 Byte)		유통기한
	private String MAKE_COM= "";					//VARCHAR2 (50 Byte)		제조회사
	private String ORG_CT= "";						//VARCHAR2 (35 Byte)		원산지	
	private String SALE_CON= "";					//VARCHAR2 (35 Byte)		판매상태	
	private String PD_DINFO= "";					//CLOB							상품 상세정보
	private String DLVREF_GUIDE= "";				//CLOB							배송/환불 안내
	private String ATFL_ID= "";						//VARCHAR2 (12 Byte)		파일ID	
	private String RPIMG_SEQ= "";					//NUMBER (5)					대표이미지 순번
	private String ADC1_NAME= "";					//VARCHAR2 (50 Byte)		추가컬럼1 명
	private String ADC2_NAME= "";					//VARCHAR2 (50 Byte)		추가컬럼2 명
	private String ADC3_NAME= "";					//VARCHAR2 (50 Byte)		추가컬럼3 명
	private String ADC4_NAME= "";					//VARCHAR2 (50 Byte)		추가컬럼4 명
	private String ADC5_NAME= "";					//VARCHAR2 (50 Byte)		추가컬럼5 명
	private String ADC1_VAL= "";					//VARCHAR2 (100 Byte)	추가컬럼1 값
	private String ADC2_VAL= "";					//VARCHAR2 (100 Byte)	추가컬럼2 값
	private String ADC3_VAL= "";					//VARCHAR2 (100 Byte)	추가컬럼3 값
	private String ADC4_VAL= "";					//VARCHAR2 (100 Byte)	추가컬럼4 값
	private String ADC5_VAL= "";					//VARCHAR2 (100 Byte)	추가컬럼5 값
	private String PD_ICON= "";						//VARCHAR2 (100 Byte)	상품아이콘
	private String STD_UNIT= "";					//VARCHAR2 (35 Byte)		규격단위
	private String TAX_GUBN = "";					//VARCHAR2 (35 Byte)		과세면세 구분
	private String DEL_YN = "";						//VARCHAR2 (1 Byte)		삭제여부	
	private String DTL_ATFL_ID= "";				//VARCHAR2 (12 Byte)		상세첨부파일
	private String DTL_USE_YN= "";				//VARCHAR2 (1 Byte)		상세첨부파일사용여부
	private String LINK_YN = "";					//VARCHAR2 (1 Byte)		링크여부
	private String BUNDLE_CNT = "";				//VARCHAR2 (10 Byte)		묶음배송 수
	private String DLVR_INDI_YN = "";			//VARCHAR2 (1 Byte)		개별배송 여부
	private String KEEP_GUBN= "";					//VARCHAR2 (35 Byte)		보관기준
	private String PACKING_GUBN= "";			//VARCHAR2 (35 Byte)		팩킹기준
	private String KEEP_LOCATION= "";			//VARCHAR2 (255 Byte)	보관위치
	private String LIMIT_QTY = "";					//NUMBER (15)				한정수량
	private String RETAIL_YN = "";			    	//VARCHAR2 (10 Byte)		리테일상품 사용여부
	private String RETAIL_GUBN = "";				//VARCHAR2 (100 Byte)	리테일상품 구분
	private String INPUT_CNT = ""; 				//NUMBER (15)				입수량
	private String QNT_LIMT_USE = "";			//VARCHAR2 (3 Byte)		수량제한표시여부	
	private String ONDY_GUBN = "";				//VARCHAR2 (35 Byte)		일배상품구분
	private String OPTION_GUBN = "";			//VARCHAR2 (35 Byte)		상품옵션구분  
	private String OPTION_GUBN_NAME = "";	//									상품옵션명
	private String BOX_PDDC_GUBN = "";		//VARCHAR2 (35 Byte)		박스할인구분
	private String BOX_PDDC_VAL = "";			//VARCHAR2 (35 Byte)		박스할인 값	
	private String DLVY_GUBN= "";					//VARCHAR2 (35 Byte)		상품별 배송구분
	private String DLVY_GUBN_NM= "";			//									상품별 배송구분명
	private String PD_INTERFACE_YN = "";
	private String PD_IWHUPRC="";				//NUMBER (15)				입고단가
	private String PRICE_POLICY="";				//varvchar2 (10Byte)	가격정책
	
	/*TB_PDCAGOXM*/
	private String CAGO_NAME = "";		//카테고리명
	private String UPCAGO_ID = "";		//상위 카테고리
	private String UPCAGO_NAME = "";	//상위 카테고리명
	private String SORT_ORDR = "";		//카테고리 정렬
	private String CAGO_ID_PATH = "";	//카테고리ID PATH
	private String CAGO_NM_PATH = "";	//카테고리명 PATH
	private String PRD_CNT = "";			//제품수
	
	
	/*TB_COATFLXD*/
	private String FILEPATH_FLAG = "";			//VARCHAR2 (50 Byte)		이미지 구분
	private String STFL_PATH= "";					//									상세첨부파일경로(메인화면)
	private String STFL_NAME= "";					//									상세첨부파일이름(메인화면)
	
	/*TB_PDRCMDXM*/
	private String RCMD_GUBN = "";				//VARCHAR2 (100 Byte)	추천상품구분
	
	/*상품상세*/
	private String PD_CODE_IN = "";				//									상품코드 입력구분 (자동/수동)
	private String PD_BARCD_IN = "";				//									상품바코드 입력구분 (자동/수동)
	private String REAL_PRICE = "";				//									실제 판매가 (제품할인적용가)
	private String PD_CUT_SEQ_CNT = "";		//									세절방식 cnt
	
	/*엑셀 업로드 에러 관리*/
	private String ERROR_CODE = "";				//									에러코드
	private String ERROR_TEXT = "";				//									에러TEXT
	
	/*검색조건*/
	private String max_value = "";
	private String min_value = "";
	private String salecon_sch = "";				//VARCHAR2 (35 Byte)		판매상태 검색구분
	
	/*목록 리스트 업데이트용*/
	private String TODAY_CHANGE_YN = "";		//									당일변경유무
	
	private String PD_CNT = "";
	private String LINK_MODP_DATE = "";
	
	private String OPTION_CNT ="";

	/*사용안함*/
	private String AVG_PD_PTS = "";				//									평점 평균
	private int CAGO_ID_LEN = 0;					//									제품코드 길이
	
	
	public String getOPTION_CNT() {
		return OPTION_CNT;
	}
	public void setOPTION_CNT(String oPTION_CNT) {
		OPTION_CNT = oPTION_CNT;
	}
	public String getLINK_MODP_DATE() {
		return LINK_MODP_DATE;
	}
	public void setLINK_MODP_DATE(String lINK_MODP_DATE) {
		LINK_MODP_DATE = lINK_MODP_DATE;
	}
	public String getPD_CNT() {
		return PD_CNT;
	}
	public void setPD_CNT(String pD_CNT) {
		PD_CNT = pD_CNT;
	}
	public String getPRICE_POLICY() {
		return PRICE_POLICY;
	}
	public void setPRICE_POLICY(String pRICE_POLICY) {
		PRICE_POLICY = pRICE_POLICY;
	}
	public String getERROR_CODE() {
		return ERROR_CODE;
	}
	public void setERROR_CODE(String eRROR_CODE) {
		ERROR_CODE = eRROR_CODE;
	}
	public String getERROR_TEXT() {
		return ERROR_TEXT;
	}
	public void setERROR_TEXT(String eRROR_TEXT) {
		ERROR_TEXT = eRROR_TEXT;
	}
	String getOPTION_GUBN_NAME() {
		return OPTION_GUBN_NAME;
	}
	public void setOPTION_GUBN_NAME(String oPTION_GUBN_NAME) {
		OPTION_GUBN_NAME = oPTION_GUBN_NAME;
	}
	public String getOPTION_GUBN() {
		return OPTION_GUBN;
	}
	public void setOPTION_GUBN(String oPTION_GUBN) {
		OPTION_GUBN = oPTION_GUBN;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public String getCAGO_ID() {
		return CAGO_ID;
	}
	public void setCAGO_ID(String cAGO_ID) {
		CAGO_ID = cAGO_ID;
	}
	public String getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(String pD_PRICE) {
		PD_PRICE = pD_PRICE.replaceAll("\\,", "");
	}
	public String getPDDC_GUBN() {
		return PDDC_GUBN;
	}
	public void setPDDC_GUBN(String pDDC_GUBN) {
		PDDC_GUBN = pDDC_GUBN;
	}	
	public String getPDDC_GUBN_NM() {
		return PDDC_GUBN_NM;
	}
	public void setPDDC_GUBN_NM(String pDDC_GUBN_NM) {
		PDDC_GUBN_NM = pDDC_GUBN_NM;
	}
	public String getPDDC_VAL() {
		return PDDC_VAL;
	}
	public void setPDDC_VAL(String pDDC_VAL) {
		PDDC_VAL = pDDC_VAL.replaceAll("\\,", "");
	}
	public String getSVMN_GUBN() {
		return SVMN_GUBN;
	}
	public void setSVMN_GUBN(String sVMN_GUBN) {
		SVMN_GUBN = sVMN_GUBN;
	}
	public String getSVMN_VAL() {
		return SVMN_VAL;
	}
	public void setSVMN_VAL(String sVMN_VAL) {
		SVMN_VAL = sVMN_VAL.replaceAll("\\,", "");;
	}
	public String getINVEN_QTY() {
		return INVEN_QTY;
	}
	public void setINVEN_QTY(String iNVEN_QTY) {
		INVEN_QTY = iNVEN_QTY.replaceAll("\\,", "");
	}
	public String getPOS_NAME() { 
		return POS_NAME;
	}
	public void setPOS_NAME(String pOS_NAME) {
		POS_NAME = pOS_NAME;
	}
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}
	public String getSTORE_CTR() {
		return STORE_CTR;
	}
	public void setSTORE_CTR(String sTORE_CTR) {
		STORE_CTR = sTORE_CTR;
	}
	public String getPD_STD() {
		return PD_STD;
	}
	public void setPD_STD(String pD_STD) {
		PD_STD = pD_STD;
	}
	public String getDTB_DLINE() {
		return DTB_DLINE;
	}
	public void setDTB_DLINE(String dTB_DLINE) {
		DTB_DLINE = dTB_DLINE;
	}
	public String getMAKE_COM() {
		return MAKE_COM;
	}
	public void setMAKE_COM(String mAKE_COM) {
		MAKE_COM = mAKE_COM;
	}
	public String getORG_CT() {
		return ORG_CT;
	}
	public void setORG_CT(String oRG_CT) {
		ORG_CT = oRG_CT;
	}
	public String getSALE_CON() {
		return SALE_CON;
	}
	public void setSALE_CON(String sALE_CON) {
		SALE_CON = sALE_CON;
	}
	public String getPD_DINFO() {
		return PD_DINFO;
	}
	public void setPD_DINFO(String pD_DINFO) {
		PD_DINFO = pD_DINFO;
	}
	public String getDLVREF_GUIDE() {
		return DLVREF_GUIDE;
	}
	public void setDLVREF_GUIDE(String dLVREF_GUIDE) {
		DLVREF_GUIDE = dLVREF_GUIDE;
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
	public String getADC1_NAME() {
		return ADC1_NAME;
	}
	public void setADC1_NAME(String aDC1_NAME) {
		ADC1_NAME = aDC1_NAME;
	}
	public String getADC2_NAME() {
		return ADC2_NAME;
	}
	public void setADC2_NAME(String aDC2_NAME) {
		ADC2_NAME = aDC2_NAME;
	}
	public String getADC3_NAME() {
		return ADC3_NAME;
	}
	public void setADC3_NAME(String aDC3_NAME) {
		ADC3_NAME = aDC3_NAME;
	}
	public String getADC4_NAME() {
		return ADC4_NAME;
	}
	public void setADC4_NAME(String aDC4_NAME) {
		ADC4_NAME = aDC4_NAME;
	}
	public String getADC5_NAME() {
		return ADC5_NAME;
	}
	public void setADC5_NAME(String aDC5_NAME) {
		ADC5_NAME = aDC5_NAME;
	}
	public String getADC1_VAL() {
		return ADC1_VAL;
	}
	public void setADC1_VAL(String aDC1_VAL) {
		ADC1_VAL = aDC1_VAL;
	}
	public String getADC2_VAL() {
		return ADC2_VAL;
	}
	public void setADC2_VAL(String aDC2_VAL) {
		ADC2_VAL = aDC2_VAL;
	}
	public String getADC3_VAL() {
		return ADC3_VAL;
	}
	public void setADC3_VAL(String aDC3_VAL) {
		ADC3_VAL = aDC3_VAL;
	}
	public String getADC4_VAL() {
		return ADC4_VAL;
	}
	public void setADC4_VAL(String aDC4_VAL) {
		ADC4_VAL = aDC4_VAL;
	}
	public String getADC5_VAL() {
		return ADC5_VAL;
	}
	public void setADC5_VAL(String aDC5_VAL) {
		ADC5_VAL = aDC5_VAL;
	}
	public String getPD_ICON() {
		return PD_ICON;
	}
	public void setPD_ICON(String pD_ICON) {
		PD_ICON = pD_ICON;
	}
	public String getSTD_UNIT() {
		return STD_UNIT;
	}
	public void setSTD_UNIT(String sTD_UNIT) {
		STD_UNIT = sTD_UNIT;
	}
	public String getSUPR_NAME() {
		return SUPR_NAME;
	}
	public void setSUPR_NAME(String sUPR_NAME) {
		SUPR_NAME = sUPR_NAME;
	}
	public String getPD_CODE_IN() {
		return PD_CODE_IN;
	}
	public void setPD_CODE_IN(String pD_CODE_IN) {
		PD_CODE_IN = pD_CODE_IN;
	}
	public String getPD_BARCD_IN() {
		return PD_BARCD_IN;
	}
	public void setPD_BARCD_IN(String pD_BARCD_IN) {
		PD_BARCD_IN = pD_BARCD_IN;
	}
	public String getCAGO_NAME() {
		return CAGO_NAME;
	}
	public void setCAGO_NAME(String cAGO_NAME) {
		CAGO_NAME = cAGO_NAME;
	}
	public String getCAGO_ID_PATH() {
		return CAGO_ID_PATH;
	}
	public void setCAGO_ID_PATH(String cAGO_ID_PATH) {
		CAGO_ID_PATH = cAGO_ID_PATH;
	}
	public String getCAGO_NM_PATH() {
		return CAGO_NM_PATH;
	}
	public void setCAGO_NM_PATH(String cAGO_NM_PATH) {
		CAGO_NM_PATH = cAGO_NM_PATH;
	}
	public String getPRD_CNT() {
		return PRD_CNT;
	}
	public void setPRD_CNT(String pRD_CNT) {
		PRD_CNT = pRD_CNT;
	}
	public String getAVG_PD_PTS() {
		return AVG_PD_PTS;
	}
	public void setAVG_PD_PTS(String aVG_PD_PTS) {
		AVG_PD_PTS = aVG_PD_PTS;
	}
	public String getUPCAGO_ID() {
		return UPCAGO_ID;
	}
	public void setUPCAGO_ID(String uPCAGO_ID) {
		UPCAGO_ID = uPCAGO_ID;
	}
	public String getUPCAGO_NAME() {
		return UPCAGO_NAME;
	}
	public void setUPCAGO_NAME(String uPCAGO_NAME) {
		UPCAGO_NAME = uPCAGO_NAME;
	}
	public String getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(String sORT_ORDR) {
		SORT_ORDR = sORT_ORDR.replaceAll("\\,", "");
	}
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE.replaceAll("\\,", "");
	}
	public String getTAX_GUBN() {
		return TAX_GUBN;
	}
	public void setTAX_GUBN(String tAX_GUBN) {
		TAX_GUBN = tAX_GUBN;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getDTL_ATFL_ID() {
		return DTL_ATFL_ID;
	}
	public void setDTL_ATFL_ID(String dTL_ATFL_ID) {
		DTL_ATFL_ID = dTL_ATFL_ID;
	}
	public String getDTL_USE_YN() {
		return DTL_USE_YN;
	}
	public void setDTL_USE_YN(String dTL_USE_YN) {
		DTL_USE_YN = dTL_USE_YN;
	}
	public String getSTFL_PATH() {
		return STFL_PATH;
	}
	public void setSTFL_PATH(String sTFL_PATH) {
		STFL_PATH = sTFL_PATH;
	}
	public String getSTFL_NAME() {
		return STFL_NAME;
	}
	public void setSTFL_NAME(String sTFL_NAME) {
		STFL_NAME = sTFL_NAME;
	}
	public String getLINK_YN() {
		return LINK_YN;
	}
	public void setLINK_YN(String lINK_YN) {
		LINK_YN = lINK_YN;
	}
	public String getBUNDLE_CNT() {
		return BUNDLE_CNT;
	}
	public void setBUNDLE_CNT(String bUNDLE_CNT) {
		BUNDLE_CNT = bUNDLE_CNT;
	}
	public String getDLVR_INDI_YN() {
		return DLVR_INDI_YN;
	}
	public void setDLVR_INDI_YN(String dLVR_INDI_YN) {
		DLVR_INDI_YN = dLVR_INDI_YN;
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
	public String getKEEP_LOCATION() {
		return KEEP_LOCATION;
	}
	public void setKEEP_LOCATION(String kEEP_LOCATION) {
		KEEP_LOCATION = kEEP_LOCATION;
	}
	public String getLIMIT_QTY() {
		return LIMIT_QTY;
	}
	public void setLIMIT_QTY(String lIMIT_QTY) {
		LIMIT_QTY = lIMIT_QTY.replaceAll("\\,", "");
	}
	public String getINPUT_CNT() {
		return INPUT_CNT;
	}
	public void setINPUT_CNT(String iNPUT_CNT) {
		INPUT_CNT = iNPUT_CNT.replaceAll("\\,", "");
	}
	public int getCAGO_ID_LEN() {
		return CAGO_ID_LEN;
	}
	public void setCAGO_ID_LEN(int cAGO_ID_LEN) {
		CAGO_ID_LEN = cAGO_ID_LEN;
	}
	public String getQNT_LIMT_USE() {
		return QNT_LIMT_USE;
	}
	public void setQNT_LIMT_USE(String qNT_LIMT_USE) {
		QNT_LIMT_USE = qNT_LIMT_USE;
	}
	public String getONDY_GUBN() {
		return ONDY_GUBN;
	}
	public void setONDY_GUBN(String oNDY_GUBN) {
		ONDY_GUBN = oNDY_GUBN;
	}
	public String getRETAIL_GUBN() {
		return RETAIL_GUBN;
	}
	public void setRETAIL_GUBN(String rETAIL_GUBN) {
		RETAIL_GUBN = rETAIL_GUBN;
	}
	public String getRETAIL_YN() {
		return RETAIL_YN;
	}
	public void setRETAIL_YN(String rETAIL_YN) {
		RETAIL_YN = rETAIL_YN;
	}
	public String getTODAY_CHANGE_YN() {
		return TODAY_CHANGE_YN;
	}
	public void setTODAY_CHANGE_YN(String tODAY_CHANGE_YN) {
		TODAY_CHANGE_YN = tODAY_CHANGE_YN;
	}
	public String getPD_CUT_SEQ_CNT() {
		return PD_CUT_SEQ_CNT;
	}
	public void setPD_CUT_SEQ_CNT(String pD_CUT_SEQ_CNT) {
		PD_CUT_SEQ_CNT = pD_CUT_SEQ_CNT;
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
		BOX_PDDC_VAL = bOX_PDDC_VAL.replaceAll("\\,", "");
	}
	public String getFILEPATH_FLAG() {
		return FILEPATH_FLAG;
	}
	public void setFILEPATH_FLAG(String fILEPATH_FLAG) {
		FILEPATH_FLAG = fILEPATH_FLAG;
	}	
	public String getRCMD_GUBN() {
		return RCMD_GUBN;
	}
	public void setRCMD_GUBN(String rCMD_GUBN) {
		RCMD_GUBN = rCMD_GUBN;
	}
	public String getPD_INTERFACE_YN() {
		return PD_INTERFACE_YN;
	}
	public void setPD_INTERFACE_YN(String pD_INTERFACE_YN) {
		PD_INTERFACE_YN = pD_INTERFACE_YN;
	}
	public String getMax_value() {
		return max_value;
	}
	public void setMax_value(String max_value) {
		this.max_value = max_value;
	}
	public String getMin_value() {
		return min_value;
	}
	public void setMin_value(String min_value) {
		this.min_value = min_value;
	}
	public String getDLVY_GUBN() {
		return DLVY_GUBN;
	}
	public void setDLVY_GUBN(String dLVY_GUBN) {
		DLVY_GUBN = dLVY_GUBN;
	}
	public String getDLVY_GUBN_NM() {
		return DLVY_GUBN_NM;
	}
	public void setDLVY_GUBN_NM(String dLVY_GUBN_NM) {
		DLVY_GUBN_NM = dLVY_GUBN_NM;
	}
	public String getSalecon_sch() {
		return salecon_sch;
	}
	public void setSalecon_sch(String salecon_sch) {
		this.salecon_sch = salecon_sch;
	}
	public String getPD_IWHUPRC() {
		return PD_IWHUPRC;
	}
	public void setPD_IWHUPRC(String pD_IWHUPRC) {
		PD_IWHUPRC = pD_IWHUPRC.replaceAll("\\,", "");
	}
	
}
