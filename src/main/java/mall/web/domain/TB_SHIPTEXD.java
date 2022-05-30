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
@Alias("tb_shiptexd")
@XmlRootElement(name="tb_shiptexd")
public class TB_SHIPTEXD extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_SHIPTEXD*/
	private String TEMP_NUM;				//VARCHAR2(20 Byte)			템플릿코드
	private String SHIP_GUBN;				//VARCHAR2(50 Byte)			배송비구분
	private String GUBN_START;				//NUMBER					구분1
	private String GUBN_END;				//NUMBER					구분2
	private String DLVY_AMT;				//NUMBER					배송비
	private int TEMP_SEQ;					//NUMBER					템플릿 순번
	
	private String[] GUBN_STARTS;			//NUMBER					구분1
	private String[] GUBN_ENDS;				//NUMBER					구분2
	private String[] DLVY_AMTS;				//NUMBER					배송비
	
	public String getTEMP_NUM() {
		return TEMP_NUM;
	}
	public void setTEMP_NUM(String tEMP_NUM) {
		TEMP_NUM = tEMP_NUM;
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
		GUBN_START = gUBN_START;
	}
	public String getGUBN_END() {
		return GUBN_END;
	}
	public void setGUBN_END(String gUBN_END) {
		GUBN_END = gUBN_END;
	}
	public String getDLVY_AMT() {
		return DLVY_AMT;
	}
	public void setDLVY_AMT(String dLVY_AMT) {
		DLVY_AMT = dLVY_AMT;
	}
	public int getTEMP_SEQ() {
		return TEMP_SEQ;
	}
	public void setTEMP_SEQ(int tEMP_SEQ) {
		TEMP_SEQ = tEMP_SEQ;
	}
	public String[] getGUBN_STARTS() {
		return GUBN_STARTS;
	}
	public void setGUBN_STARTS(String[] gUBN_STARTS) {
		GUBN_STARTS = gUBN_STARTS;
	}
	public String[] getGUBN_ENDS() {
		return GUBN_ENDS;
	}
	public void setGUBN_ENDS(String[] gUBN_ENDS) {
		GUBN_ENDS = gUBN_ENDS;
	}
	public String[] getDLVY_AMTS() {
		return DLVY_AMTS;
	}
	public void setDLVY_AMTS(String[] dLVY_AMTS) {
		DLVY_AMTS = dLVY_AMTS;
	}
}
