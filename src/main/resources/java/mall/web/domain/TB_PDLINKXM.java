package mall.web.domain;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.domain
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 제품 연계 가격정보
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-21 (오후 1:57:40)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Alias("tb_pdlinkxm")
@XmlRootElement(name="tb_pdlinkxm")
public class TB_PDLINKXM extends TB_PDINFOXM{

	private static final long serialVersionUID = 1733226044024796314L;
	
	private String PD_CODE= "";			//VARCHAR2 (20 Byte)		제품코드
	private String MALL_GUBN = "";		//VARCHAR2 (35 Byte)		연계쇼핑몰구분
	
	private String PD_PRICE01= "";		//NUMBER (15)				제품가격1	
	private String PD_PRICE02= "";		//NUMBER (15)				제품가격2	
	private String PD_PRICE03= "";		//NUMBER (15)				제품가격3	
	private String PD_PRICE04= "";		//NUMBER (15)				제품가격4	
	private String PD_PRICE05= "";		//NUMBER (15)				제품가격5	
	

	private String[] PD_CODES;				// 상품ID
	private String[] MALL_GUBNS;			// 연계쇼핑몰 구분
	private String[] PD_PRICES01;			// 연계쇼핑몰 판매가1
	private String[] PD_PRICES02;			// 연계쇼핑몰 판매가2
	private String[] PD_PRICES03;			// 연계쇼핑몰 판매가3
	private String[] PD_PRICES04;			// 연계쇼핑몰 판매가4
	private String[] PD_PRICES05;			// 연계쇼핑몰 판매가5
	
	public String getPD_CODE() {
		return PD_CODE;
	}
	public void setPD_CODE(String pD_CODE) {
		PD_CODE = pD_CODE;
	}
	public String getMALL_GUBN() {
		return MALL_GUBN;
	}
	public void setMALL_GUBN(String mALL_GUBN) {
		MALL_GUBN = mALL_GUBN;
	}
	public String getPD_PRICE01() {
		return PD_PRICE01;
	}
	public void setPD_PRICE01(String pD_PRICE01) {
		PD_PRICE01 = pD_PRICE01;
	}
	public String getPD_PRICE02() {
		return PD_PRICE02;
	}
	public void setPD_PRICE02(String pD_PRICE02) {
		PD_PRICE02 = pD_PRICE02;
	}
	public String getPD_PRICE03() {
		return PD_PRICE03;
	}
	public void setPD_PRICE03(String pD_PRICE03) {
		PD_PRICE03 = pD_PRICE03;
	}
	public String getPD_PRICE04() {
		return PD_PRICE04;
	}
	public void setPD_PRICE04(String pD_PRICE04) {
		PD_PRICE04 = pD_PRICE04;
	}
	public String getPD_PRICE05() {
		return PD_PRICE05;
	}
	public void setPD_PRICE05(String pD_PRICE05) {
		PD_PRICE05 = pD_PRICE05;
	}

	public String[] getPD_CODES() {
		return PD_CODES;
	}
	public void setPD_CODES(String[] pD_CODES) {
		PD_CODES = pD_CODES;
	}
	public String[] getPD_PRICES01() {
		return PD_PRICES01;
	}
	public void setPD_PRICES01(String[] pD_PRICES01) {
		PD_PRICES01 = pD_PRICES01;
	}
	public String[] getPD_PRICES02() {
		return PD_PRICES02;
	}
	public void setPD_PRICES02(String[] pD_PRICES02) {
		PD_PRICES02 = pD_PRICES02;
	}
	public String[] getPD_PRICES03() {
		return PD_PRICES03;
	}
	public void setPD_PRICES03(String[] pD_PRICES03) {
		PD_PRICES03 = pD_PRICES03;
	}
	public String[] getPD_PRICES04() {
		return PD_PRICES04;
	}
	public void setPD_PRICES04(String[] pD_PRICES04) {
		PD_PRICES04 = pD_PRICES04;
	}
	public String[] getPD_PRICES05() {
		return PD_PRICES05;
	}
	public void setPD_PRICES05(String[] pD_PRICES05) {
		PD_PRICES05 = pD_PRICES05;
	}
	public String[] getMALL_GUBNS() {
		return MALL_GUBNS;
	}
	public void setMALL_GUBNS(String[] mALL_GUBNS) {
		MALL_GUBNS = mALL_GUBNS;
	}

	

}
