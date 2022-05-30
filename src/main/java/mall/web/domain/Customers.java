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
@Alias("customers")
@XmlRootElement(name="customers")
public class Customers implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int CUSTOMERNUMBER;
	private String CUSTOMERNAME;
	private String CONTACTLASTNAME;
	private String CONTACTFIRSTNAME;
	private String PHONE;
	private String ADDRESSLINE1;
	private String ADDRESSLINE2;
	private String CITY;
	private String STATE;
	private String POSTALCODE;
	private String COUNTRY;
	private int SALESREPEMPLOYEENUMBER;
	private Double CREDITLIMIT;
	
	public int getCUSTOMERNUMBER() {
		return CUSTOMERNUMBER;
	}
	@XmlElement
	public void setCUSTOMERNUMBER(int cUSTOMERNUMBER) {
		CUSTOMERNUMBER = cUSTOMERNUMBER;
	}
	public String getCUSTOMERNAME() {
		return CUSTOMERNAME;
	}
	@XmlElement
	public void setCUSTOMERNAME(String cUSTOMERNAME) {
		CUSTOMERNAME = cUSTOMERNAME;
	}
	public String getCONTACTLASTNAME() {
		return CONTACTLASTNAME;
	}
	@XmlElement
	public void setCONTACTLASTNAME(String cONTACTLASTNAME) {
		CONTACTLASTNAME = cONTACTLASTNAME;
	}
	public String getCONTACTFIRSTNAME() {
		return CONTACTFIRSTNAME;
	}
	@XmlElement
	public void setCONTACTFIRSTNAME(String cONTACTFIRSTNAME) {
		CONTACTFIRSTNAME = cONTACTFIRSTNAME;
	}
	public String getPHONE() {
		return PHONE;
	}
	@XmlElement
	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}
	public String getADDRESSLINE1() {
		return ADDRESSLINE1;
	}
	@XmlElement
	public void setADDRESSLINE1(String aDDRESSLINE1) {
		ADDRESSLINE1 = aDDRESSLINE1;
	}
	public String getADDRESSLINE2() {
		return ADDRESSLINE2;
	}
	@XmlElement
	public void setADDRESSLINE2(String aDDRESSLINE2) {
		ADDRESSLINE2 = aDDRESSLINE2;
	}
	public String getCITY() {
		return CITY;
	}
	@XmlElement
	public void setCITY(String cITY) {
		CITY = cITY;
	}
	public String getSTATE() {
		return STATE;
	}
	@XmlElement
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	public String getPOSTALCODE() {
		return POSTALCODE;
	}
	@XmlElement
	public void setPOSTALCODE(String pOSTALCODE) {
		POSTALCODE = pOSTALCODE;
	}
	public String getCOUNTRY() {
		return COUNTRY;
	}
	@XmlElement
	public void setCOUNTRY(String cOUNTRY) {
		COUNTRY = cOUNTRY;
	}
	public int getSALESREPEMPLOYEENUMBER() {
		return SALESREPEMPLOYEENUMBER;
	}
	@XmlElement
	public void setSALESREPEMPLOYEENUMBER(int sALESREPEMPLOYEENUMBER) {
		SALESREPEMPLOYEENUMBER = sALESREPEMPLOYEENUMBER;
	}
	public Double getCREDITLIMIT() {
		return CREDITLIMIT;
	}
	@XmlElement
	public void setCREDITLIMIT(Double cREDITLIMIT) {
		CREDITLIMIT = cREDITLIMIT;
	}
}
