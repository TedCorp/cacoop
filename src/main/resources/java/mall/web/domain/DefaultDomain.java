package mall.web.domain;

import java.io.Serializable;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 기본 DTO
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-11 (오후 11:09:33)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("defaultDomain")
@XmlRootElement(name="defaultDomain")

public class DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int count;
	private List<?> list;
	private Object selectOne;
	
	private String jsp;
	
	// variable for pagination
	private int pagerOffset = 0;
	private int pagerMaxItemCount = 0;
	private int pagerMaxIndexPages = 10;
	private int pagerMaxPageItems = 10;
	private String pagerUrl = null;
	
	private int pageNum = 1;						//페이지 번호
	private int rowCnt = 10;						//페이지당 리스트수
	
	//검색조건
	private String schGbn;		//검색구분
	private String schTxt;		//검색어
	private String schParam;	//검색셀렉트박스 (목록업데이트와 중복되는것)
	
	private String datepickerStr; //시작일자
	private String datepickerEnd; //종료일자
	
	//공통변수
	private String SUPR_ID;		//공급업체 ID
	private String SUPR_NAME;	//공급업체 명
	private String LVL;			//레벨

	private String MEMB_ID;		//회원 ID
	
	private String REGP_ID;		//등록자 ID
	private Date REG_DTM;		//등록 일시
	private String MODP_ID;		//수정자 ID
	private Date MOD_DTM;		//수정 일시
	private String RNUM;		//공급업체 ID
	
	private String rtnUrl;

	private String sortGubun;
	private String sortOdr;
	
	private String [] adIdArr;	
	private String [] pdIdArr;

	private String LGD_RESPCODE;
	private String LGD_RESPMSG;
	
	private String MODE;		//I, U, D
	
	private String reSearchChk;		// 이전 검색 포함 체크 유무
	private String schTxt_bef;		// 이전 검색 조건
	private List schTxt_befList;	// 이전 검색 조건 myBatis foreach용
	
	private String reSearch;		// 검색내 검색 
	
	private String ORDER_DATE; //주문일
	private String PAY_METD; // 주문방식
	
	private String entcago;	// 진입카테고리
	
	
	public String getSchParam() {
		return schParam;
	}
	public void setSchParam(String schParam) {
		this.schParam = schParam;
	}
	public String getEntcago() {
		return entcago;
	}
	public void setEntcago(String entcago) {
		this.entcago = entcago;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<?> getList() {
		return list;
	}
	public void setList(List<?> list) {
		this.list = list;
	}
	public Object getSelectOne() {
		return selectOne;
	}
	public void setSelectOne(Object selectOne) {
		this.selectOne = selectOne;
	}
	public String getJsp() {
		return jsp;
	}
	public void setJsp(String jsp) {
		this.jsp = jsp;
	}
	public int getPagerOffset() {
		return pagerOffset;
	}
	public void setPagerOffset(int pagerOffset) {
		this.pagerOffset = pagerOffset;
	}
	public int getPagerMaxItemCount() {
		return pagerMaxItemCount;
	}
	public void setPagerMaxItemCount(int pagerMaxItemCount) {
		this.pagerMaxItemCount = pagerMaxItemCount;
	}
	public int getPagerMaxIndexPages() {
		return pagerMaxIndexPages;
	}
	public void setPagerMaxIndexPages(int pagerMaxIndexPages) {
		this.pagerMaxIndexPages = pagerMaxIndexPages;
	}
	public int getPagerMaxPageItems() {
		return pagerMaxPageItems;
	}
	public void setPagerMaxPageItems(int pagerMaxPageItems) {
		this.pagerMaxPageItems = pagerMaxPageItems;
	}
	public String getPagerUrl() {
		return pagerUrl;
	}
	public void setPagerUrl(String pagerUrl) {
		this.pagerUrl = pagerUrl;
	}
	public String getSUPR_ID() {
		return SUPR_ID;
	}
	public void setSUPR_ID(String sUPR_ID) {
		SUPR_ID = sUPR_ID;
	}
	public String getSUPR_NAME() {
		return SUPR_NAME;
	}
	public void setSUPR_NAME(String sUPR_NAME) {
		SUPR_NAME = sUPR_NAME;
	}
	public String getREGP_ID() {
		return REGP_ID;
	}
	public void setREGP_ID(String rEGP_ID) {
		REGP_ID = rEGP_ID;
	}
	public Date getREG_DTM() {
		return REG_DTM;
	}
	public void setREG_DTM(Date rEG_DTM) {
		REG_DTM = rEG_DTM;
	}
	public String getMODP_ID() {
		return MODP_ID;
	}
	public void setMODP_ID(String mODP_ID) {
		MODP_ID = mODP_ID;
	}
	public Date getMOD_DTM() {
		return MOD_DTM;
	}
	public void setMOD_DTM(Date mOD_DTM) {
		MOD_DTM = mOD_DTM;
	}
	public String getRNUM() {
		return RNUM;
	}
	public void setRNUM(String rNUM) {
		RNUM = rNUM;
	}
	public String getSchGbn() {
		return schGbn;
	}
	public void setSchGbn(String schGbn) {
		this.schGbn = schGbn;
	}
	public String getSchTxt() {
		return schTxt;
	}
	public void setSchTxt(String schTxt) {
		this.schTxt = schTxt;
	}
	public String getDatepickerStr() {
		return datepickerStr;
	}
	public void setDatepickerStr(String datepickerStr) {
		this.datepickerStr = datepickerStr;
	}
	public String getDatepickerEnd() {
		return datepickerEnd;
	}
	public void setDatepickerEnd(String datepickerEnd) {
		this.datepickerEnd = datepickerEnd;
	}
	public String getMEMB_ID() {
		return MEMB_ID;
	}
	public void setMEMB_ID(String mEMB_ID) {
		MEMB_ID = mEMB_ID;
	}
	public String getLVL() {
		return LVL;
	}
	public void setLVL(String lVL) {
		LVL = lVL;
	}
	public String getRtnUrl() {
		return rtnUrl;
	}
	public void setRtnUrl(String rtnUrl) {
		this.rtnUrl = rtnUrl;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getRowCnt() {
		return rowCnt;
	}
	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}
	public String getSortGubun() {
		return sortGubun;
	}
	public void setSortGubun(String sortGubun) {
		this.sortGubun = sortGubun;
	}
	public String getSortOdr() {
		return sortOdr;
	}
	public void setSortOdr(String sortOdr) {
		this.sortOdr = sortOdr;
	}
	public String[] getAdIdArr() {
		return adIdArr;
	}
	public void setAdIdArr(String[] adIdArr) {
		this.adIdArr = adIdArr;
	}
	public String[] getPdIdArr() {
		return pdIdArr;
	}
	public void setPdIdArr(String[] pdIdArr) {
		this.pdIdArr = pdIdArr;
	}
	public String getLGD_RESPCODE() {
		return LGD_RESPCODE;
	}
	public void setLGD_RESPCODE(String lGD_RESPCODE) {
		LGD_RESPCODE = lGD_RESPCODE;
	}
	public String getLGD_RESPMSG() {
		return LGD_RESPMSG;
	}
	public void setLGD_RESPMSG(String lGD_RESPMSG) {
		LGD_RESPMSG = lGD_RESPMSG;
	}
	public String getMODE() {
		return MODE;
	}
	public void setMODE(String mODE) {
		MODE = mODE;
	}
	public String getSchTxt_bef() {
		return schTxt_bef;
	}
	public void setSchTxt_bef(String schTxt_bef) {
		this.schTxt_bef = schTxt_bef;
	}
	public String getReSearchChk() {
		return reSearchChk;
	}
	public void setReSearchChk(String reSearchChk) {
		this.reSearchChk = reSearchChk;
	}
	public List getSchTxt_befList() {
		return schTxt_befList;
	}
	public void setSchTxt_befList(List schTxt_befList) {
		this.schTxt_befList = schTxt_befList;
	}
	public String getReSearch() {
		return reSearch;
	}
	public void setReSearch(String reSearch) {
		this.reSearch = reSearch;
	}
	public String getORDER_DATE() {
		return ORDER_DATE;
	}
	public void setORDER_DATE(String oRDER_DATE) {
		ORDER_DATE = oRDER_DATE;
	}
	public String getPAY_METD() {
		return PAY_METD;
	}
	public void setPAY_METD(String pAY_METD) {
		PAY_METD = pAY_METD;
	}
	
	
}
