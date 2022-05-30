package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 약관관리 DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_tminfoxm")
@XmlRootElement(name="tb_tminfoxm")
public class TB_TMINFOXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String TERM_GUBN = "";		//약관 구분
	private String TERM_CONT = "";		//약관 내용

	private String TERM_GUBN1 = "";		//약관 구분 - 회원약관
	private String TERM_GUBN2 = "";		//약관 구분 - 개인정보취급방침
	private String TERM_CONT1 = "";		//회원약관
	private String TERM_CONT2 = "";		//개인정보취급방침
	
	public String getTERM_GUBN() {
		return TERM_GUBN;
	}
	public void setTERM_GUBN(String tERM_GUBN) {
		TERM_GUBN = tERM_GUBN;
	}
	public String getTERM_CONT() {
		return TERM_CONT;
	}
	public void setTERM_CONT(String tERM_CONT) {
		TERM_CONT = tERM_CONT;
	}
	public String getTERM_CONT1() {
		return TERM_CONT1;
	}
	public void setTERM_CONT1(String tERM_CONT1) {
		TERM_CONT1 = tERM_CONT1;
	}
	public String getTERM_CONT2() {
		return TERM_CONT2;
	}
	public void setTERM_CONT2(String tERM_CONT2) {
		TERM_CONT2 = tERM_CONT2;
	}
	public String getTERM_GUBN1() {
		return TERM_GUBN1;
	}
	public void setTERM_GUBN1(String tERM_GUBN1) {
		TERM_GUBN1 = tERM_GUBN1;
	}
	public String getTERM_GUBN2() {
		return TERM_GUBN2;
	}
	public void setTERM_GUBN2(String tERM_GUBN2) {
		TERM_GUBN2 = tERM_GUBN2;
	}


}
