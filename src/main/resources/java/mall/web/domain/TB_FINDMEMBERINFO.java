package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

@Alias("tb_findmemberinfo")
@XmlRootElement(name="tb_findmemberinfo")

public class TB_FINDMEMBERINFO extends DefaultDomain{
	
	/*private static final long serialVersionUID = -1471161809434513649L;*/
	
	private String MEMB_ID;	    //아이디	
	private String MEMB_PW;   	//비밀번호
	private String MEMB_NAME;	//이름
	private String MEMB_CPON;	//핸드폰번호
	private String COM_BUNB;	//사업자번호
	private String MEMB_MAIL;	//이메일

	private String FIND_GBN;	//찾기 구분 ID/PW
	
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}	
	public String getMEMB_PW() {
		return MEMB_PW;
	}
	public void setMEMB_PW(String mEMB_PW) {
		MEMB_PW = mEMB_PW;
	}
	public String getMEMB_NAME() {
		return MEMB_NAME;
	}
	public void setMEMB_NAME(String mEMB_NAME) {
		MEMB_NAME = mEMB_NAME;
	}
	public String getMEMB_CPON() {
		return MEMB_CPON;
	}
	public void setMEMB_CPON(String mEMB_CPON) {
		MEMB_CPON = mEMB_CPON;
	}
	public String getCOM_BUNB() {
		return COM_BUNB;
	}
	public void setCOM_BUNB(String cOM_BUNB) {
		COM_BUNB = cOM_BUNB;
	}
	public String getMEMB_MAIL() {
		return MEMB_MAIL;
	}
	public void setMEMB_MAIL(String mEMB_MAIL) {
		MEMB_MAIL = mEMB_MAIL;
	}
	public String getFIND_GBN() {
		return FIND_GBN;
	}
	public void setFIND_GBN(String fIND_GBN) {
		FIND_GBN = fIND_GBN;
	}


	
	
	
}
