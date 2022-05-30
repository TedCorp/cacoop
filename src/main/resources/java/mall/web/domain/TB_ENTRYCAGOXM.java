package mall.web.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 진입카테고리 DTO
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-03-25
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("TB_ENTRYCATOXM")
@XmlRootElement(name="TB_ENTRYCATOXM")
public class TB_ENTRYCAGOXM implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String ENTRY_ID;
	private String ENTRY_NAME;
	private String SORT_ORDR;
	private String SORT_ORDRM;
	private String USE_YN;
	private String REGP_ID;
	private String REG_DTM;
	private String MODP_ID;
	private String MOD_DTM;
	private String IMG_URL;
	
	
	public String getSORT_ORDRM() {
		return SORT_ORDRM;
	}
	public void setSORT_ORDRM(String sORT_ORDRM) {
		SORT_ORDRM = sORT_ORDRM;
	}
	public String getENTRY_ID() {
		return ENTRY_ID;
	}
	public void setENTRY_ID(String eNTRY_ID) {
		ENTRY_ID = eNTRY_ID;
	}
	public String getENTRY_NAME() {
		return ENTRY_NAME;
	}
	public void setENTRY_NAME(String eNTRY_NAME) {
		ENTRY_NAME = eNTRY_NAME;
	}
	public String getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(String sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getREGP_ID() {
		return REGP_ID;
	}
	public void setREGP_ID(String rEGP_ID) {
		REGP_ID = rEGP_ID;
	}
	public String getREG_DTM() {
		return REG_DTM;
	}
	public void setREG_DTM(String rEG_DTM) {
		REG_DTM = rEG_DTM;
	}
	public String getMODP_ID() {
		return MODP_ID;
	}
	public void setMODP_ID(String mODP_ID) {
		MODP_ID = mODP_ID;
	}
	public String getMOD_DTM() {
		return MOD_DTM;
	}
	public void setMOD_DTM(String mOD_DTM) {
		MOD_DTM = mOD_DTM;
	}
	public String getIMG_URL() {
		return IMG_URL;
	}
	public void setIMG_URL(String iMG_URL) {
		IMG_URL = iMG_URL;
	}

	
	
	
}
