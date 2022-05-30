package mall.web.domain;

/**
 * @author Your Name (your@email.com)
 * 행사 상품정 보 매핑 Vo
 */
public class TB_ADPDIFXM extends TB_ADINFOXM {

	private static final long serialVersionUID = 1L;
	
	private String CAGO_NAME;			// 카테고리명
	private String PD_ID;				// 상품ID
	private String PD_NAME;				// 상품명
	private String PD_PRICE;			// 상품정상가
	private String SELL_PRICE;			// 상품판매가
	private String PD_DESC;				// 상품상세
	private String PD_CONS;				// 제약사항
	private String ATFL_NAME;			// 첨부파일명
	private String IMG_WIDTH;			// 이미지넓이
	private String IMG_HEIGHT;			// 이미지높이
	private String DEL_YN;				// 삭제여부
	private String ORD;
	

	private String OPT_NAME;			// 할인/증정(옵션가) 명
	private String OPT_PRICE;			// 할인/증정(옵션가 가격
	private String UNIT_NAME;			// 판매단위

	private String CHK_UPDATE;			// 중복 업로드 여부
	
	private String[] PD_IDS;			// 상품ID
	private String[] CAGO_NAMES;		// 카테고리명
	private String[] PD_NAMES;			// 상품명
	private String[] PD_PRICES;			// 상품정상가
	private String[] SELL_PRICES;		   // 상품판매가
	private String[] PD_CONSS;			// 제약사항
	private String[] ATFL_NAMES;		// 첨부파일명
	private String[] DEL_YNS;			// 삭제여부
	private String[] ORDS;				// 삭제여부
	private String[] FLAGS;
	
	private String[] OPT_NAMES;			// 할인/증정(옵션가) 명
	private String[] OPT_PRICES;		// 할인/증정(옵션가 가격
	private String[] UNIT_NAMES;		// 판매단위
	
	public String getCAGO_NAME() {
		return CAGO_NAME;
	}
	public void setCAGO_NAME(String cAGO_NAME) {
		CAGO_NAME = cAGO_NAME;
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
		PD_PRICE = pD_PRICE.replaceAll("\\,", "");
	}
	public String getSELL_PRICE() {
		return SELL_PRICE;
	}
	public void setSELL_PRICE(String sELL_PRICE) {
		SELL_PRICE = sELL_PRICE.replaceAll("\\,", "");
	}
	public String getPD_DESC() {
		return PD_DESC;
	}
	public void setPD_DESC(String pD_DESC) {
		PD_DESC = pD_DESC;
	}
	public String getPD_CONS() {
		return PD_CONS;
	}
	public void setPD_CONS(String pD_CONS) {
		PD_CONS = pD_CONS;
	}
	public String getATFL_NAME() {
		return ATFL_NAME;
	}
	public void setATFL_NAME(String aTFL_NAME) {
		ATFL_NAME = aTFL_NAME;
	}
	public String getIMG_WIDTH() {
		return IMG_WIDTH;
	}
	public void setIMG_WIDTH(String iMG_WIDTH) {
		IMG_WIDTH = iMG_WIDTH;
	}
	public String getIMG_HEIGHT() {
		return IMG_HEIGHT;
	}
	public void setIMG_HEIGHT(String iMG_HEIGHT) {
		IMG_HEIGHT = iMG_HEIGHT;
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
	public String[] getPD_IDS() {
		return PD_IDS;
	}
	public void setPD_IDS(String[] pD_IDS) {
		PD_IDS = pD_IDS;
	}
	public String[] getCAGO_NAMES() {
		return CAGO_NAMES;
	}
	public void setCAGO_NAMES(String[] cAGO_NAMES) {
		CAGO_NAMES = cAGO_NAMES;
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
	public String[] getSELL_PRICES() {
		return SELL_PRICES;
	}
	public void setSELL_PRICES(String[] sELL_PRICES) {
		SELL_PRICES = sELL_PRICES;
	}
	public String[] getPD_CONSS() {
		return PD_CONSS;
	}
	public void setPD_CONSS(String[] pD_CONSS) {
		PD_CONSS = pD_CONSS;
	}
	public String[] getATFL_NAMES() {
		return ATFL_NAMES;
	}
	public void setATFL_NAMES(String[] aTFL_NAMES) {
		ATFL_NAMES = aTFL_NAMES;
	}
	public String[] getDEL_YNS() {
		return DEL_YNS;
	}
	public void setDEL_YNS(String[] dEL_YNS) {
		DEL_YNS = dEL_YNS;
	}
	public String[] getFLAGS() {
		return FLAGS;
	}
	public void setFLAGS(String[] fLAGS) {
		FLAGS = fLAGS;
	}
	public String getCHK_UPDATE() {
		return CHK_UPDATE;
	}
	public void setCHK_UPDATE(String cHK_UPDATE) {
		CHK_UPDATE = cHK_UPDATE;
	}
	public String[] getORDS() {
		return ORDS;
	}
	public void setORDS(String[] oRDS) {
		ORDS = oRDS;
	}
	public String getOPT_NAME() {
		return OPT_NAME;
	}
	public void setOPT_NAME(String oPT_NAME) {
		OPT_NAME = oPT_NAME;
	}
	public String getOPT_PRICE() {
		return OPT_PRICE;
	}
	public void setOPT_PRICE(String oPT_PRICE) {
		OPT_PRICE = oPT_PRICE.replaceAll("\\,", "");
	}
	public String getUNIT_NAME() {
		return UNIT_NAME;
	}
	public void setUNIT_NAME(String uNIT_NAME) {
		UNIT_NAME = uNIT_NAME;
	}
	public String[] getOPT_NAMES() {
		return OPT_NAMES;
	}
	public void setOPT_NAMES(String[] oPT_NAMES) {
		OPT_NAMES = oPT_NAMES;
	}
	public String[] getOPT_PRICES() {
		return OPT_PRICES;
	}
	public void setOPT_PRICES(String[] oPT_PRICES) {
		OPT_PRICES = oPT_PRICES;
	}
	public String[] getUNIT_NAMES() {
		return UNIT_NAMES;
	}
	public void setUNIT_NAMES(String[] uNIT_NAMES) {
		UNIT_NAMES = uNIT_NAMES;
	}
	
}
