package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 일정관리
 * @Company	: YT Corp.
 * @Author	: HEESUN LEE (tschoi@youngthink.co.kr)
 * @Date	: 2018-07-17 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_syscalxm")
@XmlRootElement(name="tb_syscalxm")
public class TB_SYSCALXM extends DefaultDomain {

	private static final long serialVersionUID = 1L;
	
	private String CAL_SEQ;			//일정순번
	private String MEMB_ID;			//회원아이디
	private String CAL_CONT;		//일정내용
	private String CMPLT_YN;		//완료여부
	private String CAL_DATE;
	
	private int CNT =0;		// 추후 사용가능성있어서 만들어놓음 ( 하루 일정갯수 )
	
	public String getCAL_SEQ() {
		return CAL_SEQ;
	}
	public void setCAL_SEQ(String cAL_SEQ) {
		CAL_SEQ = cAL_SEQ;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getCAL_CONT() {
		return CAL_CONT;
	}
	public void setCAL_CONT(String cAL_CONT) {
		CAL_CONT = cAL_CONT;
	}
	public String getCMPLT_YN() {
		return CMPLT_YN;
	}
	public void setCMPLT_YN(String cMPLT_YN) {
		CMPLT_YN = cMPLT_YN;
	}
	public String getCAL_DATE() {
		return CAL_DATE;
	}
	public void setCAL_DATE(String cAL_DATE) {
		CAL_DATE = cAL_DATE;
	}
	public int getCNT() {
		return CNT;
	}
	public void setCNT(int cNT) {
		CNT = cNT;
	}

}
