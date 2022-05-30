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
 * @Date	: 
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdtotxm")
@XmlRootElement(name="tb_pdtotxm")
public class TB_PDTOTXM extends DefaultDomain{

	private static final long serialVersionUID = 1L;

	private String RNUM;						// NUMBER (15)				순번
	
	/* TB_PDINFOXM */
	private String PD_CODE;					// VARCHAR2 (20 Byte)		제품코드
	private String PD_NAME;					// VARCHAR2 (30 Byte)		제품명	None
	private String PD_BARCD;				// VARCHAR2 (13 Byte)		제품바코드
	private String PD_PRICE;					// NUMBER (15)				제품가격
	private String PDDC_GUBN;				// VARCHAR2 (35 Byte)		제품할인 구분
	private String PDDC_VAL;					// NUMBER (15)	0			제품할인 값
	private String BOX_PDDC_GUBN;		// VARCHAR2 (35 Byte)		박스할인 구분
	private String BOX_PDDC_VAL;			// NUMBER (15)	0			박스할인 값
	private String ATFL_ID;					// VARCHAR2 (12 Byte)		파일ID
	private String RPIMG_SEQ;				// NUMBER (5)					대표이미지 순번
	private String DTL_ATFL_ID;				// VARCHAR2 (12 Byte)		상세첨부파일
	private String DTL_USE_YN;				// VARCHAR2 (1 Byte)		상세첨부파일사용여부
	private String STFL_PATH;				// VARCHAR2 (1 Byte)		상세첨부파일경로(메인화면)
	private String STFL_NAME;				// VARCHAR2 (1 Byte)		상세첨부파일이름(메인화면)
	private String DLVY_GUBN;				// VARCHAR2 (35 Byte)		상품별 배송구분
	private String DLVY_GUBN_NM;			// VARCHAR2 (35 Byte)		상품별 배송구분명
	private String SALE_CON;					// VARCHAR2 (35 Byte)		판매상태
	private String SALE_CON_NM;			// VARCHAR2 (35 Byte)		판매상태 명
	private String TAX_GUBN;				// VARCHAR2 (35 Byte)		과세면세 
	private String TAX_GUBN_NM;			// VARCHAR2 (35 Byte)		과세면세 명
	private String DEL_YN;					// VARCHAR2 (1 Byte)		삭제여부
	private String REAL_PRICE;				// NUMBER (15)				제품가격
	
	/*TB_ODINFOXM  */
	private String ORDER_NUM;				// VARCHAR2(50)			주문번호
	private String ORDER_DATE;				// VARCHAR2(8)			주문일자
	private String ORDER_QTY;				// NUMBER(15)			주문금액
	private String ORDER_AMT;				// NUMBER(15)			주문금액
	private String DLVY_AMT;					// NUMBER(15)	0		배송비
	private String DAP_YN;					// VARCHAR2(1)	Y		배송비결제여부
	private String ORDER_CON;				// VARCHAR2(35)			주문상태
	private String ORDER_CON_NM;		// VARCHAR2(35)			주문상태 명
	private String PAY_METD;					// VARCHAR2(35)			결제수단
	private String PAY_METD_NM;			// VARCHAR2(35)			결제수단 명
	private String PAY_MDKY;				// VARCHAR2(50)	Y		결제모듈키
	private String PAY_DTM;					// DATE						결제시간
	private String ORDER_DTM;				// DATE						주문시간
	
	/*TB_MBINFOXM  */
	private String MEMB_NAME;				// VARCHAR2(30)			회원명
	private String COM_NAME;				// VARCHAR2(100)		회사명
	
	private String SUM_PRICE;				// 소계
	
	
	public String getSUM_PRICE() {
		return SUM_PRICE;
	}
	public void setSUM_PRICE(String sUM_PRICE) {
		SUM_PRICE = sUM_PRICE;
	}
	public String getRNUM() {
		return RNUM;
	}
	public void setRNUM(String rNUM) {
		RNUM = rNUM;
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
	public String getPD_BARCD() {
		return PD_BARCD;
	}
	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
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
	public String getSALE_CON_NM() {
		return SALE_CON_NM;
	}
	public void setSALE_CON_NM(String sALE_CON_NM) {
		SALE_CON_NM = sALE_CON_NM;
	}
	public String getTAX_GUBN_NM() {
		return TAX_GUBN_NM;
	}
	public void setTAX_GUBN_NM(String tAX_GUBN_NM) {
		TAX_GUBN_NM = tAX_GUBN_NM;
	}
	public String getSALE_CON() {
		return SALE_CON;
	}
	public void setSALE_CON(String sALE_CON) {
		SALE_CON = sALE_CON;
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
	public String getREAL_PRICE() {
		return REAL_PRICE;
	}
	public void setREAL_PRICE(String rEAL_PRICE) {
		REAL_PRICE = rEAL_PRICE;
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
	public String getMEMB_NAME() {
		return MEMB_NAME;
	}
	public void setMEMB_NAME(String mEMB_NAME) {
		MEMB_NAME = mEMB_NAME;
	}
	public String getCOM_NAME() {
		return COM_NAME;
	}
	public void setCOM_NAME(String cOM_NAME) {
		COM_NAME = cOM_NAME;
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
	public String getDAP_YN() {
		return DAP_YN;
	}
	public void setDAP_YN(String dAP_YN) {
		DAP_YN = dAP_YN;
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
	public String getPAY_METD_NM() {
		return PAY_METD_NM;
	}
	public void setPAY_METD_NM(String pAY_METD_NM) {
		PAY_METD_NM = pAY_METD_NM;
	}
	public String getPAY_MDKY() {
		return PAY_MDKY;
	}
	public void setPAY_MDKY(String pAY_MDKY) {
		PAY_MDKY = pAY_MDKY;
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
}
