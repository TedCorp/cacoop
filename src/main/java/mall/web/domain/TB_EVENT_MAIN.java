package mall.web.domain;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * @Company : ted
 * @Author : jang bora
 * @Date : 2021-11-04 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */
@Alias("tb_event_main")
@XmlRootElement(name = "tb_event_main")
public class TB_EVENT_MAIN extends DefaultDomain {

	private static final long serialVersionUID = -1471161809434513649L;

	private String GRP_CD = ""; // 기획전ID
	private String GRP_NM = ""; // 기회명
	private String USE_YN = ""; // 사용여부(디폴트값Y)
	private String START_DT = ""; // 기획전시작일
	private String END_DT = ""; // 기획전종료일
	
	/*사진관련DTO*/
	private String ATFL_ID = ""; // 첨부파일
	private String ATFL_ID_D=""; //디테일사진
	private String RPIMG_SEQ=""; //대표이미지 순서
	private String D_USE_YN=""; //디테일사진 사용여부
	

	/* TB_COATFLXD */
	private String FILEPATH_FLAG = ""; // 이미지 구분
	private String STFL_PATH = ""; // 상세첨부파일경로(메인화면)
	private String STFL_NAME = "";

	private String PD_CODE; // 상품코드
	private String PD_BARCD; // 상품바코드
	private String CHK_UPDATE; // 중복체크
	private List<?> PDLIST; // 상품리스트

	public String getSTART_DT() {
		return START_DT;
	}

	public void setSTART_DT(String sTART_DT) {
		START_DT = sTART_DT;
	}

	public String getEND_DT() {
		return END_DT;
	}

	public void setEND_DT(String eND_DT) {
		END_DT = eND_DT;
	}

	public String getGRP_CD() {
		return GRP_CD;
	}

	public void setGRP_CD(String gRP_CD) {
		GRP_CD = gRP_CD;
	}

	public String getGRP_NM() {
		return GRP_NM;
	}

	public void setGRP_NM(String gRP_NM) {
		GRP_NM = gRP_NM;
	}

	public String getUSE_YN() {
		return USE_YN;
	}

	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}

	public String getATFL_ID() {
		return ATFL_ID;
	}

	public void setATFL_ID(String aTFL_ID) {
		ATFL_ID = aTFL_ID;
	}

	public String getFILEPATH_FLAG() {
		return FILEPATH_FLAG;
	}

	public void setFILEPATH_FLAG(String fILEPATH_FLAG) {
		FILEPATH_FLAG = fILEPATH_FLAG;
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

	public String getPD_CODE() {
		return PD_CODE;
	}

	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}

	public String getPD_BARCD() {
		return PD_BARCD;
	}

	public void setPD_BARCD(String pD_BARCD) {
		PD_BARCD = pD_BARCD;
	}

	public String getCHK_UPDATE() {
		return CHK_UPDATE;
	}

	public void setCHK_UPDATE(String cHK_UPDATE) {
		CHK_UPDATE = cHK_UPDATE;
	}

	public List<?> getPDLIST() {
		return PDLIST;
	}

	public void setPDLIST(List<?> pDLIST) {
		PDLIST = pDLIST;
	}

	public String getATFL_ID_D() {
		return ATFL_ID_D;
	}

	public void setATFL_ID_D(String aTFL_ID_D) {
		ATFL_ID_D = aTFL_ID_D;
	}

	public String getRPIMG_SEQ() {
		return RPIMG_SEQ;
	}

	public void setRPIMG_SEQ(String rPIMG_SEQ) {
		RPIMG_SEQ = rPIMG_SEQ;
	}

	public String getD_USE_YN() {
		return D_USE_YN;
	}

	public void setD_USE_YN(String d_USE_YN) {
		D_USE_YN = d_USE_YN;
	}


}