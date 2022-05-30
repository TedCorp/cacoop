package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 그룹별사용자관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:56:27)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_sysgusxm")
@XmlRootElement(name="tb_sysgusxm")
public class TB_SYSGUSXM extends TB_SYSMNUXM {

	private static final long serialVersionUID = 4656784059404249898L;
	
	private String GROUP_CD;			//	그룹코드
	private String MEMB_ID;				//	회원아이디
	private String MEMB_NM;				//	회원 명 
	private String CHK_MEMB_ID;			//  회원 체크항목
	
	public String getGROUP_CD() {
		return GROUP_CD;
	}
	public void setGROUP_CD(String gROUP_CD) {
		GROUP_CD = gROUP_CD;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getMEMB_NM() {
		return MEMB_NM;
	}
	public void setMEMB_NM(String mEMB_NM) {
		MEMB_NM = mEMB_NM;
	}
	public String getCHK_MEMB_ID() {
		return CHK_MEMB_ID;
	}
	public void setCHK_MEMB_ID(String cHK_MEMB_ID) {
		CHK_MEMB_ID = cHK_MEMB_ID;
	}
	
	
}
