package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 주문배송지정보 DTO
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-13 (오후 08:10:10)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("xtb_oddlaixm")
@XmlRootElement(name="xtb_oddlaixm")
public class XTB_ODDLAIXM extends DefaultDomain{
	
	private static final long serialVersionUID = -6215499596814261517L;
	
	private String ORDER_NUM;	//VARCHAR2(50)			주문번호
	private String DLVY_ROWNUM;	//VARCHAR2(35)			배송지번호
	private String DLVY_NAME;	//VARCHAR2(35)			배송지명
	private String STAFF_NAME = "";	//VARCHAR2(30)		담당자명
	private String POST_NUM;	//VARCHAR2(6)			우편번호
	private String BASC_ADDR;	//VARCHAR2(200)			기본주소
	private String DTL_ADDR;	//VARCHAR2(200)			상세주소
	private String EXTRA_ADDR;	//VARCHAR2(200)			추가주소
	private String STAFF_CPON;	//VARCHAR2(20)			담당자명 휴대전화
	private String DLVY_MSG;	//VARCHAR2(500)	Y		배송메세지
	
	private String[] DLVY_ROWNUMS;	//VARCHAR2(35)			배송지번호
	private String[] DLVY_NAMES;	//VARCHAR2(35)			배송지명
	private String[] STAFF_NAMES;	//VARCHAR2(30)		담당자명
	private String[] POST_NUMS;	//VARCHAR2(6)			우편번호
	private String[] BASC_ADDRS;	//VARCHAR2(200)			기본주소
	private String[] DTL_ADDRS;	//VARCHAR2(200)			추가주소
	private String[] EXTRA_ADDRS;	//VARCHAR2(200)			상세주소
	private String[] STAFF_CPONS;	//VARCHAR2(20)			담당자명 휴대전화
	
	public String getORDER_NUM() {
		return ORDER_NUM;
	}
	public void setORDER_NUM(String oRDER_NUM) {
		ORDER_NUM = oRDER_NUM;
	}
	public String getDLVY_ROWNUM() {
		return DLVY_ROWNUM;
	}
	public void setDLVY_ROWNUM(String dLVY_ROWNUM) {
		DLVY_ROWNUM = dLVY_ROWNUM;
	}
	public String getDLVY_NAME() {
		return DLVY_NAME;
	}
	public void setDLVY_NAME(String dLVY_NAME) {
		DLVY_NAME = dLVY_NAME;
	}
	public String getSTAFF_NAME() {
		return STAFF_NAME;
	}
	public void setSTAFF_NAME(String sTAFF_NAME) {
		STAFF_NAME = sTAFF_NAME;
	}
	public String getPOST_NUM() {
		return POST_NUM;
	}
	public void setPOST_NUM(String pOST_NUM) {
		POST_NUM = pOST_NUM;
	}
	public String getBASC_ADDR() {
		return BASC_ADDR;
	}
	public void setBASC_ADDR(String bASC_ADDR) {
		BASC_ADDR = bASC_ADDR;
	}
	public String getDTL_ADDR() {
		return DTL_ADDR;
	}
	public void setDTL_ADDR(String dTL_ADDR) {
		DTL_ADDR = dTL_ADDR;
	}
	public String getSTAFF_CPON() {
		return STAFF_CPON;
	}
	public void setSTAFF_CPON(String sTAFF_CPON) {
		STAFF_CPON = sTAFF_CPON;
	}
	public String getDLVY_MSG() {
		return DLVY_MSG;
	}
	public void setDLVY_MSG(String dLVY_MSG) {
		DLVY_MSG = dLVY_MSG;
	}
	public String getEXTRA_ADDR() {
		return EXTRA_ADDR;
	}
	public void setEXTRA_ADDR(String eXTRA_ADDR) {
		EXTRA_ADDR = eXTRA_ADDR;
	}
	public String[] getDLVY_ROWNUMS() {
		return DLVY_ROWNUMS;
	}
	public void setDLVY_ROWNUMS(String[] dLVY_ROWNUMS) {
		DLVY_ROWNUMS = dLVY_ROWNUMS;
	}
	public String[] getDLVY_NAMES() {
		return DLVY_NAMES;
	}
	public void setDLVY_NAMES(String[] dLVY_NAMES) {
		DLVY_NAMES = dLVY_NAMES;
	}
	public String[] getSTAFF_NAMES() {
		return STAFF_NAMES;
	}
	public void setSTAFF_NAMES(String[] sTAFF_NAMES) {
		STAFF_NAMES = sTAFF_NAMES;
	}
	public String[] getPOST_NUMS() {
		return POST_NUMS;
	}
	public void setPOST_NUMS(String[] pOST_NUMS) {
		POST_NUMS = pOST_NUMS;
	}
	public String[] getBASC_ADDRS() {
		return BASC_ADDRS;
	}
	public void setBASC_ADDRS(String[] bASC_ADDRS) {
		BASC_ADDRS = bASC_ADDRS;
	}
	public String[] getDTL_ADDRS() {
		return DTL_ADDRS;
	}
	public void setDTL_ADDRS(String[] dTL_ADDRS) {
		DTL_ADDRS = dTL_ADDRS;
	}
	public String[] getEXTRA_ADDRS() {
		return EXTRA_ADDRS;
	}
	public void setEXTRA_ADDRS(String[] eXTRA_ADDRS) {
		EXTRA_ADDRS = eXTRA_ADDRS;
	}
	public String[] getSTAFF_CPONS() {
		return STAFF_CPONS;
	}
	public void setSTAFF_CPONS(String[] sTAFF_CPONS) {
		STAFF_CPONS = sTAFF_CPONS;
	}
	
	
}
