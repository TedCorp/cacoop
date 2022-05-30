package mall.web.domain;

/**
 * @author Your Name (your@email.com)
 * 광고테이블 매핑 Vo
 */
public class TB_EVENTIFXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String EVENT_ID;		// 이벤트ID
	private String EVENT_NAME;		// 이벤트명
	private String START_DT;		// 이벤트시작일
	private String END_DT;			// 이벤트종료일
	
	private String MENU_NAME;		// 메뉴명
	private String MENU_YN;			// 메뉴표시여부
	private String MENU_ORDER;		// 메뉴순서
	
	private String EVENT_DESC;		// 광고내용
	private String TOP_ATFL;		// 첨부파일-TOPIMG
	private String ATFL_ID;			// 첨부파일
	private String DEL_YN;			// 삭제여부
	private String END_YN;			// 광고 종료여부
	
	public String getEVENT_ID() {
		return EVENT_ID;
	}
	public void setEVENT_ID(String eVENT_ID) {
		EVENT_ID = eVENT_ID;
	}
	public String getEVENT_NAME() {
		return EVENT_NAME;
	}
	public void setEVENT_NAME(String eVENT_NAME) {
		EVENT_NAME = eVENT_NAME;
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
	public String getMENU_NAME() {
		return MENU_NAME;
	}
	public void setMENU_NAME(String mENU_NAME) {
		MENU_NAME = mENU_NAME;
	}
	public String getMENU_YN() {
		return MENU_YN;
	}
	public void setMENU_YN(String mENU_YN) {
		MENU_YN = mENU_YN;
	}
	public String getMENU_ORDER() {
		return MENU_ORDER;
	}
	public void setMENU_ORDER(String mENU_ORDER) {
		MENU_ORDER = mENU_ORDER;
	}
	public String getEVENT_DESC() {
		return EVENT_DESC;
	}
	public void setEVENT_DESC(String eVENT_DESC) {
		EVENT_DESC = eVENT_DESC;
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

	
}
