package mall.web.domain;

/**
 * @author Your Name (your@email.com)
 * 광고테이블 매핑 Vo
 */
public class TB_EVENTPDXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String EVENT_ID;		// 이벤트ID
	private String PD_ID;			// 상품ID
	private String PD_NAME;			// 상품명
	private String PD_PRICE;			// 상품정상가
	private String SELL_PRICE;			// 상품판매가
	private String PD_DESC;			// 상품상세
	private String ATFL_ID;			// 파일ID
	private String DEL_YN;			// 삭제여부
	private String ORD;			// 정렬
	
	
	
	public String getEVENT_ID() {
		return EVENT_ID;
	}
	public void setEVENT_ID(String eVENT_ID) {
		EVENT_ID = eVENT_ID;
	}
	public String getPD_ID() {
		return PD_ID;
	}
	public void setPD_ID(String pD_ID) {
		PD_ID = pD_ID;
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
	public String getSELL_PRICE() {
		return SELL_PRICE;
	}
	public void setSELL_PRICE(String sELL_PRICE) {
		SELL_PRICE = sELL_PRICE;
	}
	public String getPD_DESC() {
		return PD_DESC;
	}
	public void setPD_DESC(String pD_DESC) {
		PD_DESC = pD_DESC;
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
	public String getORD() {
		return ORD;
	}
	public void setORD(String oRD) {
		ORD = oRD;
	}
	
	
	
}
