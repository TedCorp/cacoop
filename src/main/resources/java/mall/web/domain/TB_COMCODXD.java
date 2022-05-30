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
@Alias("tb_comcodxd")
@XmlRootElement(name="tb_comcodxd")
public class TB_COMCODXD extends DefaultDomain {
	private static final long serialVersionUID = 1L;
	
	private String COMM_CODE;			//공통 코드
	private String COMCOD_NAME;			//공통 코드명
	private String COMD_CODE;			//세부 코드
	private String COMDCD_NAME;			//세부코드 명
	private int SORT_ORDR;				//정렬순서
	private String USE_YN;				//사용여부
	private String CODE_EXPN;			//코드 설명
	
	private String CodFlag;				// 디테일 조작용 flag
	
	
	
	
	public String getCodFlag() {
		return CodFlag;
	}
	public void setCodFlag(String codFlag) {
		CodFlag = codFlag;
	}
	public String getCOMM_CODE() {
		return COMM_CODE;
	}
	public void setCOMM_CODE(String cOMM_CODE) {
		COMM_CODE = cOMM_CODE;
	}
	public String getCOMCOD_NAME() {
		return COMCOD_NAME;
	}
	public void setCOMCOD_NAME(String cOMCOD_NAME) {
		COMCOD_NAME = cOMCOD_NAME;
	}
	public String getCOMD_CODE() {
		return COMD_CODE;
	}
	public void setCOMD_CODE(String cOMD_CODE) {
		COMD_CODE = cOMD_CODE;
	}
	public String getCOMDCD_NAME() {
		return COMDCD_NAME;
	}
	public void setCOMDCD_NAME(String cOMDCD_NAME) {
		COMDCD_NAME = cOMDCD_NAME;
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
	public String getCODE_EXPN() {
		return CODE_EXPN;
	}
	public void setCODE_EXPN(String cODE_EXPN) {
		CODE_EXPN = cODE_EXPN;
	}

	
	
	
}
