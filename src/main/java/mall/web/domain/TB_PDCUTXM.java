package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품정보
 * @Company	: YT Corp.
 * @Author	: ...? 
 * @Date	: 2017-07-13 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdcutxm")
@XmlRootElement(name="tb_pdcutxm")
public class TB_PDCUTXM extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	private String SEQ="";       //NUMBER 										 NOT NULL,
	private String PD_CODE="";   //VARCHAR2(20 BYTE)					 NOT NULL,
	private String CUT_UNIT="";  //VARCHAR2(30 BYTE)					 NOT NULL,
	private String USE_YN = ""; //VARCHAR2(3 BYTE)                    DEFAULT 'Y'
	
	//////////////////////////
	private String PD_CODE_IN = "";	
	private String CAGO_ID="";	
	private int CAGO_ID_LEN =0;
	
	//////////////////////////
	
	public String getSEQ() {
		return SEQ;
	}
	public void setSEQ(String sEQ) {
		SEQ = sEQ;
	}
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getCUT_UNIT() {
		return CUT_UNIT;
	}
	public void setCUT_UNIT(String cUT_UNIT) {
		CUT_UNIT = cUT_UNIT;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getPD_CODE_IN() {
		return PD_CODE_IN;
	}
	public void setPD_CODE_IN(String pD_CODE_IN) {
		PD_CODE_IN = pD_CODE_IN;
	}
	public String getCAGO_ID() {
		return CAGO_ID;
	}
	public void setCAGO_ID(String cAGO_ID) {
		CAGO_ID = cAGO_ID;
	}
	public int getCAGO_ID_LEN() {
		return CAGO_ID_LEN;
	}
	public void setCAGO_ID_LEN(int cAGO_ID_LEN) {
		CAGO_ID_LEN = cAGO_ID_LEN;
	}
	
	

	
	
}
