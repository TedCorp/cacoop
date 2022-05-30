package mall.web.domain;

/**
 * @author Chang Ji-won (Chjw@youngthink.co.kr)
 * 전단테이블 매핑 Vo
 */
public class TB_JDINFOXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String JD_ID;				// 기존 전단번호
	private String JD_ID_NEW;		// 복사용 신규 전단번호
	private String JD_ID_NCOPY;	// 팝업 신규 전단번호
	private String JD_NAME;			// 전단명
	private String START_DT;			// 전단시작일
	private String END_DT;			// 전단종료일
	private String JD_DESC;			// 전단내용
	private String TOP_ATFL;			// 첨부파일-TOPIMG
	private String ATFL_ID;			// 첨부파일
	private String DEL_YN;			// 삭제여부	
	private String END_YN;			// 마감여부

	private String LOG_DTM;			// 접속로그 일자	
	private String LOG_CNT;			// 접속 카운트
	
	private String JD_GUBN;			// 전단구분
	private String JD_FL1;				// 전단이미지1
	private String JD_FL2;				// 전단이미지2
	private String JD_FL3;				// 전단이미지3
	private String JD_FL4;				// 전단이미지4
	private String JD_FL5;				// 전단이미지5
	private String JD_FL6;				// 전단이미지6
	
	private String JD_PATH;			//전단경로(온라인/오프라인)
	private String JD_LIST;
	
	public String getJD_ID() {
		return JD_ID;
	}
	public void setJD_ID(String jD_ID) {
		JD_ID = jD_ID;
	}
	public String getJD_ID_NEW() {
		return JD_ID_NEW;
	}
	public void setJD_ID_NEW(String jD_ID_NEW) {
		JD_ID_NEW = jD_ID_NEW;
	}
	public String getJD_ID_NCOPY() {
		return JD_ID_NCOPY;
	}
	public void setJD_ID_NCOPY(String jD_ID_NCOPY) {
		JD_ID_NCOPY = jD_ID_NCOPY;
	}
	public String getJD_NAME() {
		return JD_NAME;
	}
	public void setJD_NAME(String jD_NAME) {
		JD_NAME = jD_NAME;
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
	public String getJD_DESC() {
		return JD_DESC;
	}
	public void setJD_DESC(String jD_DESC) {
		JD_DESC = jD_DESC;
	}
	public String getTOP_ATFL() {
		return TOP_ATFL;
	}
	public void setTOP_ATFL(String tOP_ATFL) {
		TOP_ATFL = tOP_ATFL;
	}
	public String getATFL_ID() {
		return ATFL_ID;
	}
	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}	
	public String getEND_YN() {
		return END_YN;
	}
	public void setEND_YN(String eND_YN) {
		END_YN = eND_YN;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getJD_GUBN() {
		return JD_GUBN;
	}
	public void setJD_GUBN(String jD_GUBN) {
		JD_GUBN = jD_GUBN;
	}	
	public String getJD_FL1() {
		return JD_FL1;
	}
	public void setJD_FL1(String jD_FL1) {
		JD_FL1 = jD_FL1;
	}
	public String getJD_FL2() {
		return JD_FL2;
	}
	public void setJD_FL2(String jD_FL2) {
		JD_FL2 = jD_FL2;
	}
	public String getJD_FL3() {
		return JD_FL3;
	}
	public void setJD_FL3(String jD_FL3) {
		JD_FL3 = jD_FL3;
	}
	public String getJD_FL4() {
		return JD_FL4;
	}
	public void setJD_FL4(String jD_FL4) {
		JD_FL4 = jD_FL4;
	}
	public String getJD_LIST() {
		return JD_LIST;
	}
	public void setJD_LIST(String jD_LIST) {
		JD_LIST = jD_LIST;
	}
	public String getJD_PATH() {
		return JD_PATH;
	}
	public void setJD_PATH(String jD_PATH) {
		JD_PATH = jD_PATH;
	}
	public String getJD_FL5() {
		return JD_FL5;
	}
	public void setJD_FL5(String jD_FL5) {
		JD_FL5 = jD_FL5;
	}
	public String getJD_FL6() {
		return JD_FL6;
	}
	public void setJD_FL6(String jD_FL6) {
		JD_FL6 = jD_FL6;
	}
	
}
