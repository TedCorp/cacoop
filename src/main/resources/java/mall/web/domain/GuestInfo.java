package mall.web.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 고객정보 DTO
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("guest")
@XmlRootElement(name="guest")
public class GuestInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String BIZR_NUM = "";	//사업자번호
	private String STAFF_NAME = "";	//담당자 명
	private String STAFF_CPON = "";	//담당자휴대전화
	
	public String getBIZR_NUM() {
		return BIZR_NUM;
	}
	public void setBIZR_NUM(String bIZR_NUM) {
		BIZR_NUM = bIZR_NUM;
	}
	public String getSTAFF_NAME() {
		return STAFF_NAME;
	}
	public void setSTAFF_NAME(String sTAFF_NAME) {
		STAFF_NAME = sTAFF_NAME;
	}
	public String getSTAFF_CPON() {
		return STAFF_CPON;
	}
	public void setSTAFF_CPON(String sTAFF_CPON) {
		STAFF_CPON = sTAFF_CPON;
	}

}
