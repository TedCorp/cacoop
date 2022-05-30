package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 공통코드 DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-07 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_optcodxd")
@XmlRootElement(name="tb_optcodxd")
public class TB_OPTCODXD extends DefaultDomain {
	private static final long serialVersionUID = 1L;
	
	private String OPTM_CODE;			//공통 코드
	private String OPTCOD_NAME;			//공통 코드명
	private String OPTD_CODE;			//세부 코드
	private String OPTDCD_NAME;			//세부코드 명
	private int SORT_ORDR;				//정렬순서
	private String USE_YN;				//사용여부
	private String OPT_EXPN;			//코드 설명
	
	
	public String getOPTM_CODE() {
		return OPTM_CODE;
	}
	public void setOPTM_CODE(String oPTM_CODE) {
		OPTM_CODE = oPTM_CODE;
	}
	public String getOPTCOD_NAME() {
		return OPTCOD_NAME;
	}
	public void setOPTCOD_NAME(String oPTCOD_NAME) {
		OPTCOD_NAME = oPTCOD_NAME;
	}
	public String getOPTD_CODE() {
		return OPTD_CODE;
	}
	public void setOPTD_CODE(String oPTD_CODE) {
		OPTD_CODE = oPTD_CODE;
	}
	public String getOPTDCD_NAME() {
		return OPTDCD_NAME;
	}
	public void setOPTDCD_NAME(String oPTDCD_NAME) {
		OPTDCD_NAME = oPTDCD_NAME;
	}
	public int getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(int sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getOPT_EXPN() {
		return OPT_EXPN;
	}
	public void setOPT_EXPN(String oPT_EXPN) {
		OPT_EXPN = oPT_EXPN;
	}	
	
}
