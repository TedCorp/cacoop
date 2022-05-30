package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 연계 제품정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("goods_master")
@XmlRootElement(name="goods_master")
public class GOODS_MASTER extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	private String GOODS_CODE;
	private String GOODS_NAME;
	private String POS_NAME;
	private String STDARD;
	private String VOLUME;
	private String GOODS_BCODE;
	private String BOX_BCODE;
	private String GUBUN1;
	private String GUBUN2;
	private String GUBUN3;
	private String GUBUN4;

	private String CAGO_ID;
	private String CAGO_NAME;
	
	
	public String getGOODS_CODE() {
		return GOODS_CODE;
	}
	public void setGOODS_CODE(String gOODS_CODE) {
		GOODS_CODE = gOODS_CODE;
	}
	public String getGOODS_NAME() {
		return GOODS_NAME;
	}
	public void setGOODS_NAME(String gOODS_NAME) {
		GOODS_NAME = gOODS_NAME;
	}
	public String getPOS_NAME() {
		return POS_NAME;
	}
	public void setPOS_NAME(String pOS_NAME) {
		POS_NAME = pOS_NAME;
	}
	public String getSTDARD() {
		return STDARD;
	}
	public void setSTDARD(String sTDARD) {
		STDARD = sTDARD;
	}
	public String getVOLUME() {
		return VOLUME;
	}
	public void setVOLUME(String vOLUME) {
		VOLUME = vOLUME;
	}
	public String getGOODS_BCODE() {
		return GOODS_BCODE;
	}
	public void setGOODS_BCODE(String gOODS_BCODE) {
		GOODS_BCODE = gOODS_BCODE;
	}
	public String getBOX_BCODE() {
		return BOX_BCODE;
	}
	public void setBOX_BCODE(String bOX_BCODE) {
		BOX_BCODE = bOX_BCODE;
	}
	public String getGUBUN1() {
		return GUBUN1;
	}
	public void setGUBUN1(String gUBUN1) {
		GUBUN1 = gUBUN1;
	}
	public String getGUBUN2() {
		return GUBUN2;
	}
	public void setGUBUN2(String gUBUN2) {
		GUBUN2 = gUBUN2;
	}
	public String getGUBUN3() {
		return GUBUN3;
	}
	public void setGUBUN3(String gUBUN3) {
		GUBUN3 = gUBUN3;
	}
	public String getGUBUN4() {
		return GUBUN4;
	}
	public void setGUBUN4(String gUBUN4) {
		GUBUN4 = gUBUN4;
	}
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
	
	

}
