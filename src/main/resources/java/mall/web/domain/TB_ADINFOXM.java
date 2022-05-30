package mall.web.domain;

/**
 * @author Your Name (your@email.com)
 * 광고테이블 매핑 Vo
 */
public class TB_ADINFOXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String AD_ID;			// 기존 광고번호
	private String AD_ID_NEW;		// 복사용 신규 광고번호
	private String AD_ID_NCOPY;		// 팝업 신규 광고번호
	private String AD_NAME;			// 광고명
	private String START_DT;		// 광고시작일
	private String END_DT;			// 광고종료일
	private String AD_DESC;			// 광고내용
	private String TOP_ATFL;		// 첨부파일-TOPIMG
	private String ATFL_ID;			// 첨부파일
	private String DEL_YN;			// 삭제여부
	private String TOP_TYPE;		// 삭제여부
	private String END_YN;			// 광고 종료여부
	
	private String PD_CNT;			// 등록상품수

	private String LOG_DTM;			// 접속로그 일자
	private String LOG_CNT;			// 접속 카운트
	
	public String getAD_ID() {
		return AD_ID;
	}
	public void setAD_ID(String aD_ID) {
		AD_ID = aD_ID;
	}
	public String getAD_NAME() {
		return AD_NAME;
	}
	public void setAD_NAME(String aD_NAME) {
		AD_NAME = aD_NAME;
	}
	public String getSTART_DT() {
		return START_DT;
	}
	public void setSTART_DT(String sTART_DT) {
		START_DT = sTART_DT;
	}
	public String getEND_DT() {
		return END_DT;
	}
	public void setEND_DT(String eND_DT) {
		END_DT = eND_DT;
	}
	public String getAD_DESC() {
		return AD_DESC;
	}
	public void setAD_DESC(String aD_DESC) {
		AD_DESC = aD_DESC;
	}
	public String getTOP_ATFL() {
		return TOP_ATFL;
	}
	public void setTOP_ATFL(String tOP_ATFL) {
		TOP_ATFL = tOP_ATFL;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getAD_ID_NEW() {
		return AD_ID_NEW;
	}
	public void setAD_ID_NEW(String aD_ID_NEW) {
		AD_ID_NEW = aD_ID_NEW;
	}
	public String getPD_CNT() {
		return PD_CNT;
	}
	public void setPD_CNT(String pD_CNT) {
		PD_CNT = pD_CNT;
	}
	public String getATFL_ID() {
		return ATFL_ID;
	}
	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}
	public String getAD_ID_NCOPY() {
		return AD_ID_NCOPY;
	}
	public void setAD_ID_NCOPY(String aD_ID_NCOPY) {
		AD_ID_NCOPY = aD_ID_NCOPY;
	}
	public String getLOG_DTM() {
		return LOG_DTM;
	}
	public void setLOG_DTM(String lOG_DTM) {
		LOG_DTM = lOG_DTM;
	}
	public String getLOG_CNT() {
		return LOG_CNT;
	}
	public void setLOG_CNT(String lOG_CNT) {
		LOG_CNT = lOG_CNT;
	}
	public String getTOP_TYPE() {
		return TOP_TYPE;
	}
	public void setTOP_TYPE(String tOP_TYPE) {
		TOP_TYPE = tOP_TYPE;
	}
	public String getEND_YN() {
		return END_YN;
	}
	public void setEND_YN(String eND_YN) {
		END_YN = eND_YN;
	}
	
}
