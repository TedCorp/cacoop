package mall.web.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 진입카테고리 디테일 DTO
 * @Company	: YT Corp.
 * @Author	: 
 * @Date	: 2020-03-30
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("TB_ENTRYCATOXD")
@XmlRootElement(name="TB_ENTRYCATOXD")
public class TB_ENTRYCAGOXD implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String ENTRY_ID;
	private String ENTRYD_ID;
	private String ENTRYD_NAME;
	private String SORT_ORDR;
	private String REGP_ID;
	private String REG_DTM;
	private String MODP_ID;
	private String MOD_DTM;
	
	
	public String getENTRYD_NAME() {
		return ENTRYD_NAME;
	}
	public void setENTRYD_NAME(String eNTRYD_NAME) {
		ENTRYD_NAME = eNTRYD_NAME;
	}
	public String getENTRYD_ID() {
		return ENTRYD_ID;
	}
	public void setENTRYD_ID(String eNTRYD_ID) {
		ENTRYD_ID = eNTRYD_ID;
	}
	public String getENTRY_ID() {
		return ENTRY_ID;
	}
	public void setENTRY_ID(String eNTRY_ID) {
		ENTRY_ID = eNTRY_ID;
	}
	public String getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(String sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
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
	
	
}
