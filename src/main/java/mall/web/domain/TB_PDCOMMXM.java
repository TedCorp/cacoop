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
@Alias("tb_pdcommxm")
@XmlRootElement(name="tb_pdcommxm")
public class TB_PDCOMMXM extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_PDCOMMXM*/
	private String BRD_NUM;					//NUMBER					댓글 번호
	private String PRD_SBJT;				//VARCHAR (200 Byte)		댓글 제목
	private String PD_CODE;					//VARCHAR2 (20 Byte)		제품코드
	private String BRD_CONT;				//CLOB						댓글 내용
	private String PD_PTS;					//NUMBER					상품 별점
	private String DEL_YN;					//VARCHAR2(1)				삭제 여부
	private String ORDER_NUM;				//VARCHAR2(50 Byte)			주문번호
	private String ATFL_ID;					//VARCHAR(20 Byte)			파일ID
	private String ATFL_SEQ;				//VARCHAR(20 Byte)			파일ID
	private String FILE_NM = "";			//VARCHAR(100 Byte)			파일 이름
	private String RPIMG_SEQ;				//NUMBER					대표이미지 순번
	private String DTL_ATFL_ID;				//VARCHAR2 (12 Byte)		상세첨부파일
	private String DTL_USE_YN;				//VARCHAR2 (1 Byte)		상세첨부파일사용여부
	
	/* TB_COATFLXD */
	private String FILEPATH_FLAG = ""; // 이미지 구분
	private String STFL_PATH = ""; // 상세첨부파일경로(메인화면)
	private String STFL_NAME = "";

	public String getBRD_NUM() {
		return BRD_NUM;
	}
	public void setBRD_NUM(String bRD_NUM) {
		BRD_NUM = bRD_NUM;
	}
	public String getPRD_SBJT() {
		return PRD_SBJT;
	}
	public void setPRD_SBJT(String pRD_SBJT) {
		PRD_SBJT = pRD_SBJT;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getBRD_CONT() {
		return BRD_CONT;
	}
	public void setBRD_CONT(String bRD_CONT) {
		BRD_CONT = bRD_CONT;
	}
	public String getPD_PTS() {
		return PD_PTS;
	}
	public void setPD_PTS(String pD_PTS) {
		PD_PTS = pD_PTS;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getATFL_ID() {
		return ATFL_ID;
	}
	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}
	public String getATFL_SEQ() {
		return ATFL_SEQ;
	}
	public void setATFL_SEQ(String aTFL_SEQ) {
		ATFL_SEQ = aTFL_SEQ;
	}
	public String getFILE_NM() {
		return FILE_NM;
	}
	public void setFILE_NM(String fILE_NM) {
		FILE_NM = fILE_NM;
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
	}	public String getFILEPATH_FLAG() {
		return FILEPATH_FLAG;
	}
	public void setFILEPATH_FLAG(String fILEPATH_FLAG) {
		FILEPATH_FLAG = fILEPATH_FLAG;
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
}
