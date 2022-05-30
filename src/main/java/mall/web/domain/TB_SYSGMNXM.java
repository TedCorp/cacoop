package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 그룹별메뉴관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:56:19)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_sysgmnxm")
@XmlRootElement(name="tb_sysgmnxm")
public class TB_SYSGMNXM extends TB_SYSMNUXM {

	private static final long serialVersionUID = 7916403690507240506L;
	
	private String GROUP_CD;//	VARCHAR2(35)			그룹코드

	private String CHK;// 그룹별 메뉴 선택 여부
	
	private String CHK_MENU_CODE;//메뉴 체크항목
	
	public String getGROUP_CD() {
		return GROUP_CD;
	}

	public void setGROUP_CD(String gROUP_CD) {
		GROUP_CD = gROUP_CD;
	}

	public String getCHK() {
		return CHK;
	}

	public void setCHK(String cHK) {
		CHK = cHK;
	}

	public String getCHK_MENU_CODE() {
		return CHK_MENU_CODE;
	}

	public void setCHK_MENU_CODE(String cHK_MENU_CODE) {
		CHK_MENU_CODE = cHK_MENU_CODE;
	}


}
