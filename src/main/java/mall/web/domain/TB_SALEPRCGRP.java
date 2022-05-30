package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

@Alias("tb_saleprcgrp")
@XmlRootElement(name="tb_saleprcgrp")
public class TB_SALEPRCGRP extends DefaultDomain{

	private String PRCGRP = "";
	private String SALEGBN = "";
	private String STYMD = "";
	private String STRTIME = "";
	private String SALEPRCAMT = "";
	private String SALEPRCYUL = "";
	private String ENDYMD = "";
	private String ENDTIME = "";	
	
	private String GODCD= "";			
	public String getGODCD() {
		return GODCD;
	}
	public void setGODCD(String gODCD) {
		GODCD = gODCD;
	}
	public String getPRCGRP() {
		return PRCGRP;
	}
	public void setPRCGRP(String pRCGRP) {
		PRCGRP = pRCGRP;
	}
	public String getSALEGBN() {
		return SALEGBN;
	}
	public void setSALEGBN(String sALEGBN) {
		SALEGBN = sALEGBN;
	}
	public String getSTYMD() {
		return STYMD;
	}
	public void setSTYMD(String sTYMD) {
		STYMD = sTYMD;
	}
	public String getSTRTIME() {
		return STRTIME;
	}
	public void setSTRTIME(String sTRTIME) {
		STRTIME = sTRTIME;
	}
	public String getSALEPRCAMT() {
		return SALEPRCAMT;
	}
	public void setSALEPRCAMT(String sALEPRCAMT) {
		SALEPRCAMT = sALEPRCAMT;
	}
	public String getSALEPRCYUL() {
		return SALEPRCYUL;
	}
	public void setSALEPRCYUL(String sALEPRCYUL) {
		SALEPRCYUL = sALEPRCYUL;
	}
	public String getENDYMD() {
		return ENDYMD;
	}
	public void setENDYMD(String eNDYMD) {
		ENDYMD = eNDYMD;
	}
	public String getENDTIME() {
		return ENDTIME;
	}
	public void setENDTIME(String eNDTIME) {
		ENDTIME = eNDTIME;
	}
	
}
