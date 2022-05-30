package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 사용자그룹
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:23)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_sysgrpxm")
@XmlRootElement(name="tb_sysgrpxm")
public class TB_SYSGRPXM extends DefaultDomain {
	
	private static final long serialVersionUID = -6840747069903901206L;
	
	private String GROUP_CD;//	VARCHAR2(35)			그룹코드
	private String GROUP_NAME;//	VARCHAR2(300)	Y		그룹명
	
	public String getGROUP_CD() {
		return GROUP_CD;
	}
	public void setGROUP_CD(String gROUP_CD) {
		GROUP_CD = gROUP_CD;
	}
	public String getGROUP_NAME() {
		return GROUP_NAME;
	}
	public void setGROUP_NAME(String gROUP_NAME) {
		GROUP_NAME = gROUP_NAME;
	}

	

}
