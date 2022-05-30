package mall.web.domain;

import java.sql.Date;

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
@Alias("tb_shiptexm")
@XmlRootElement(name="tb_shiptexm")
public class TB_SHIPTEXM extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	/*TB_SHIPTEXM*/
	private String TEMP_NUM;				//VARCHAR2(20 Byte)			템플릿코드
	private String TEMP_NAME;				//VARCHAR2(100 Byte)		템플릿명
	private String SUPR_ID;					//VARCHAR2(12 Byte)			공급업체
	private String DLVY_GUBN;				//VARCHAR2(35 Byte)			배송방법
	private String SHIP_GUBN;				//VARCHAR2(50 Byte)			배송비구분
	private String GUBN_START;				//NUMBER					구분1
	private String GUBN_END;				//NUMBER					구분2
	private String DLVY_AMT;				//NUMBER					배송비
	private String RFND_DLVY_AMT;			//NUMBER					반품배송비
	private Date REG_DATE;					//DATE						등록날짜
	
	private String[] TEMP_NUMS;
	
	public String getTEMP_NUM() {
		return TEMP_NUM;
	}
	public void setTEMP_NUM(String tEMP_NUM) {
		TEMP_NUM = tEMP_NUM;
	}
	public String getTEMP_NAME() {
		return TEMP_NAME;
	}
	public void setTEMP_NAME(String tEMP_NAME) {
		TEMP_NAME = tEMP_NAME;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
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
	public String getRFND_DLVY_AMT() {
		return RFND_DLVY_AMT;
	}
	public void setRFND_DLVY_AMT(String rFND_DLVY_AMT) {
		RFND_DLVY_AMT = rFND_DLVY_AMT;
	}
	public Date getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(Date rEG_DATE) {
		REG_DATE = rEG_DATE;
	}
	public String[] getTEMP_NUMS() {
		return TEMP_NUMS;
	}
	public void setTEMP_NUMS(String[] tEMP_NUMS) {
		TEMP_NUMS = tEMP_NUMS;
	}
}
