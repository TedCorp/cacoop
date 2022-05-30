package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 카테고리 DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdcagoxm")
@XmlRootElement(name="tb_pdcagoxm")
public class TB_PDCAGOXM extends DefaultDomain{
	
	private static final long serialVersionUID = -1471161809434513649L;
	
	private String CAGO_ID;		//카테고리ID
	private String CAGO_NAME;	//카테고리명
	private String UPCAGO_ID;	//상위 카테고리ID
	private String UPCAGO_NAME;	//상위 카테고리명
	private int SORT_ORDR;		//정렬순서
	private String USE_YN;		//사용여부
	
	private String PRD_CNT; 	//상품개수

	private String CAGO_ID_PATH = "";	//카테고리ID PATH
	private String CAGO_NM_PATH = "";	//카테고리명 PATH
	
	public String getCAGO_ID() {
		return CAGO_ID;
	}
	public void setCAGO_ID(String cAGO_ID) {
		CAGO_ID = cAGO_ID;
	}
	public String getCAGO_NAME() {
		return CAGO_NAME;
	}
	public void setCAGO_NAME(String cAGO_NAME) {
		CAGO_NAME = cAGO_NAME;
	}
	public String getUPCAGO_ID() {
		return UPCAGO_ID;
	}
	public void setUPCAGO_ID(String uPCAGO_ID) {
		UPCAGO_ID = uPCAGO_ID;
	}
	public int getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(int sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getPRD_CNT() {
		return PRD_CNT;
	}
	public void setPRD_CNT(String pRD_CNT) {
		PRD_CNT = pRD_CNT;
	}
	public String getUPCAGO_NAME() {
		return UPCAGO_NAME;
	}
	public void setUPCAGO_NAME(String uPCAGO_NAME) {
		UPCAGO_NAME = uPCAGO_NAME;
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


}
