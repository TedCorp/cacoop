package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_coatflxd")
@XmlRootElement(name="tb_coatflxd")
public class TB_COATFLXD extends DefaultDomain{

	private static final long serialVersionUID = 1733226044024796314L;
	
	private String ATFL_SEQ;			//첨부 파일 순번
	private String ATFL_ID = "";		//첨부 파일 ID
	private String STFL_PATH;		//스토리지 파일 경로
	private String STFL_NAME;		//스토리지 파일 명
	private String ORFL_NAME;		//원본 파일 명
	private String FILE_EXT;			//파일 확장자
	private String FILE_SIZE;			//파일 SIZE
	private String DEL_YN;			//삭제여부
	private String UPLOAD_CODE;

	private String IMG_GUBUN;		//썸네일 구분 
	
	private String FILEPATH_FLAG;	//파일구분
	
	public String getATFL_SEQ() {
		return ATFL_SEQ;
	}
	public void setATFL_SEQ(String aTFL_SEQ) {
		ATFL_SEQ = aTFL_SEQ;
	}
	public String getATFL_ID() {
		return ATFL_ID;
	}
	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}
	public String getSTFL_PATH() {
		return STFL_PATH;
	}
	public void setSTFL_PATH(String sTFL_PATH) {
		STFL_PATH = sTFL_PATH;
	}
	public String getSTFL_NAME() {
		return STFL_NAME;
	}
	public void setSTFL_NAME(String sTFL_NAME) {
		STFL_NAME = sTFL_NAME;
	}
	public String getORFL_NAME() {
		return ORFL_NAME;
	}
	public void setORFL_NAME(String oRFL_NAME) {
		ORFL_NAME = oRFL_NAME;
	}
	public String getFILE_EXT() {
		return FILE_EXT;
	}
	public void setFILE_EXT(String fILE_EXT) {
		FILE_EXT = fILE_EXT;
	}
	public String getFILE_SIZE() {
		return FILE_SIZE;
	}
	public void setFILE_SIZE(String fILE_SIZE) {
		FILE_SIZE = fILE_SIZE;
	}
	public String getDEL_YN() {
		return DEL_YN;
	}
	public void setDEL_YN(String dEL_YN) {
		DEL_YN = dEL_YN;
	}
	public String getIMG_GUBUN() {
		return IMG_GUBUN;
	}
	public void setIMG_GUBUN(String iMG_GUBUN) {
		IMG_GUBUN = iMG_GUBUN;
	}
	public String getFILEPATH_FLAG() {
		return FILEPATH_FLAG;
	}
	public void setFILEPATH_FLAG(String fILEPATH_FLAG) {
		FILEPATH_FLAG = fILEPATH_FLAG;
	}
	public String getUPLOAD_CODE() {
		return UPLOAD_CODE;
	}
	public void setUPLOAD_CODE(String uPLOAD_CODE) {
		UPLOAD_CODE = uPLOAD_CODE;
	}
}
