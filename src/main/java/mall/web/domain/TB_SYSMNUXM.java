package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 시스템메뉴 DTO
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_sysmnuxm")
@XmlRootElement(name="tb_sysmnuxm")
public class TB_SYSMNUXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String MENU_CD;				//메뉴코드
	private String MENU_NAME;			//메뉴명
	private String MENU_URL;			//메뉴URL
	private String UPPER_MENU_CD;		//상위메뉴코드
	private int SORT_ORDR;				//정렬순서
	private String MENU_GUBN;			//메뉴구분
	private String OUTPT_FG;			//출력여부
	private String MENU_CSS;			//메뉴CSS

	private String LVL;					//메뉴 레벨
	private String LEAF;				//최하위 레벨 여부(1-동일레벨 존재, 0-동일레벨 미존재)
	private String MENU_NAME_PATH;		//메뉴명 경로
	private String MENU_CD_PATH;		//메뉴코드 경로

	private String SERVLETPATH;			//servletPath
	
	private String UPPER_MENU_NAME; 	//상위메뉴명
	
	public String getMENU_CD() {
		return MENU_CD;
	}
	public void setMENU_CD(String mENU_CD) {
		MENU_CD = mENU_CD;
	}
	public String getMENU_NAME() {
		return MENU_NAME;
	}
	public void setMENU_NAME(String mENU_NAME) {
		MENU_NAME = mENU_NAME;
	}
	public String getMENU_URL() {
		return MENU_URL;
	}
	public void setMENU_URL(String mENU_URL) {
		MENU_URL = mENU_URL;
	}
	public String getUPPER_MENU_CD() {
		return UPPER_MENU_CD;
	}
	public void setUPPER_MENU_CD(String uPPER_MENU_CD) {
		UPPER_MENU_CD = uPPER_MENU_CD;
	}
	public int getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(int sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getMENU_GUBN() {
		return MENU_GUBN;
	}
	public void setMENU_GUBN(String mENU_GUBN) {
		MENU_GUBN = mENU_GUBN;
	}
	public String getOUTPT_FG() {
		return OUTPT_FG;
	}
	public void setOUTPT_FG(String oUTPT_FG) {
		OUTPT_FG = oUTPT_FG;
	}
	public String getMENU_CSS() {
		return MENU_CSS;
	}
	public void setMENU_CSS(String mENU_CSS) {
		MENU_CSS = mENU_CSS;
	}

	public String getLEAF() {
		return LEAF;
	}
	public void setLEAF(String lEAF) {
		LEAF = lEAF;
	}
	public String getMENU_NAME_PATH() {
		return MENU_NAME_PATH;
	}
	public void setMENU_NAME_PATH(String mENU_NAME_PATH) {
		MENU_NAME_PATH = mENU_NAME_PATH;
	}
	public String getMENU_CD_PATH() {
		return MENU_CD_PATH;
	}
	public void setMENU_CD_PATH(String mENU_CD_PATH) {
		MENU_CD_PATH = mENU_CD_PATH;
	}
	public String getSERVLETPATH() {
		return SERVLETPATH;
	}
	public void setSERVLETPATH(String sERVLETPATH) {
		SERVLETPATH = sERVLETPATH;
	}
	public String getLVL() {
		return LVL;
	}
	public void setLVL(String lVL) {
		LVL = lVL;
	}
	public String getUPPER_MENU_NAME() {
		return UPPER_MENU_NAME;
	}
	public void setUPPER_MENU_NAME(String uPPER_MENU_NAME) {
		UPPER_MENU_NAME = uPPER_MENU_NAME;
	}
	

}
