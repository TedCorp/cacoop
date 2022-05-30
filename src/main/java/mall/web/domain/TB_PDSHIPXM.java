package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 배송정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdshipxm")
@XmlRootElement(name="tb_pdshipxm")
public class TB_PDSHIPXM extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_PDSHIPXM*/
	private String PD_CODE;					//VARCHAR2(20 Byte)			제품코드
	private String SUPR_ID;					//VARCHAR2(12 Byte)			공급업체
	private String SHIP_CONFIG;				//VARCHAR2(10 Byte)			배송비설정(기본,개별)
	private String DLVY_GUBN;				//VARCHAR2(35 Byte)			배송방법
	private String SHIP_GUBN;				//VARCHAR2(50 Byte)			배송비구분
	private String GUBN_START;				//NUMBER					구분1
	private String GUBN_END;				//NUMBER					구분2
	private String PD_WEIGHT;				//NUMBER					상품총중량
	private String SHIP_WIDTH;				//NUMBER					가로
	private String SHIP_LENGTH;				//NUMBER					세로
	private String SHIP_HEIGHT;				//NUMBER					높이
	private String DLVY_AMT;				//NUMBER					배송비
	private String RFND_DLVY_AMT;			//NUMBER					반품배송비
	private String AREA_DLVY_AMT;			//NUMBER					지역배송비
	private String TEMP_NUM;				//VARCHAR2(20 Byte)			템플릿번호
	
	private String POP_Yn;												//팝업 여부
	private String Click_Yn;											//클릭 여부
	
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
	public String getSHIP_CONFIG() {
		return SHIP_CONFIG;
	}
	public void setSHIP_CONFIG(String sHIP_CONFIG) {
		SHIP_CONFIG = sHIP_CONFIG;
	}
	public String getDLVY_GUBN() {
		return DLVY_GUBN;
	}
	public void setDLVY_GUBN(String dLVY_GUBN) {
		DLVY_GUBN = dLVY_GUBN;
	}
	public String getSHIP_GUBN() {
		return SHIP_GUBN;
	}
	public void setSHIP_GUBN(String sHIP_GUBN) {
		SHIP_GUBN = sHIP_GUBN;
	}
	public String getGUBN_START() {
		return GUBN_START;
	}
	public void setGUBN_START(String gUBN_START) {
		GUBN_START = gUBN_START.replaceAll("\\,", "");
	}
	public String getGUBN_END() {
		return GUBN_END;
	}
	public void setGUBN_END(String gUBN_END) {
		GUBN_END = gUBN_END.replaceAll("\\,", "");
	}
	public String getPD_WEIGHT() {
		return PD_WEIGHT;
	}
	public void setPD_WEIGHT(String pD_WEIGHT) {
		PD_WEIGHT = pD_WEIGHT;
	}
	public String getSHIP_WIDTH() {
		return SHIP_WIDTH;
	}
	public void setSHIP_WIDTH(String sHIP_WIDTH) {
		SHIP_WIDTH = sHIP_WIDTH;
	}
	public String getSHIP_LENGTH() {
		return SHIP_LENGTH;
	}
	public void setSHIP_LENGTH(String sHIP_LENGTH) {
		SHIP_LENGTH = sHIP_LENGTH;
	}
	public String getSHIP_HEIGHT() {
		return SHIP_HEIGHT;
	}
	public void setSHIP_HEIGHT(String sHIP_HEIGHT) {
		SHIP_HEIGHT = sHIP_HEIGHT;
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT.replaceAll("\\,", "");
	}
	public String getRFND_DLVY_AMT() {
		return RFND_DLVY_AMT;
	}
	public void setRFND_DLVY_AMT(String rFND_DLVY_AMT) {
		RFND_DLVY_AMT = rFND_DLVY_AMT.replaceAll("\\,", "");
	}
	public String getAREA_DLVY_AMT() {
		return AREA_DLVY_AMT;
	}
	public void setAREA_DLVY_AMT(String aREA_DLVY_AMT) {
		AREA_DLVY_AMT = aREA_DLVY_AMT.replaceAll("\\,", "");
	}
	public String getPOP_Yn() {
		return POP_Yn;
	}
	public void setPOP_Yn(String pOP_Yn) {
		POP_Yn = pOP_Yn;
	}
	public String getTEMP_NUM() {
		return TEMP_NUM;
	}
	public void setTEMP_NUM(String tEMP_NUM) {
		TEMP_NUM = tEMP_NUM;
	}
	public String getClick_Yn() {
		return Click_Yn;
	}
	public void setClick_Yn(String click_Yn) {
		Click_Yn = click_Yn;
	}
}
