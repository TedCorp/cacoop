package mall.web.domain;

/**
 * @author Your Name (your@email.com)
 * 행사 상품정 보 매핑 Vo
 */
public class LinkAPI extends TB_ADINFOXM {

	private static final long serialVersionUID = 1L;
	
	private String QUERY;			// 쿼리
	private String ENDPOINT;		// ENDPOINT
	
	
	public String getQUERY() {
		return QUERY;
	}
	public void setQUERY(String qUERY) {
		QUERY = qUERY;
	}
	public String getENDPOINT() {
		return ENDPOINT;
	}
	public void setENDPOINT(String eNDPOINT) {
		ENDPOINT = eNDPOINT;
	}
	
	
	
	
}
