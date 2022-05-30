package mall.web.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import mall.web.domain.TB_ODINFOXM;
import mall.web.service.mall.OrderService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.controller
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 기본 Controller
 * @Company	: YT Corp.
 * @Author	: Tae-seok Choi (tschoi@youngthink.co.kr)
 * @Date	: 2016-07-11 (오후 11:04:15)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Controller
public class DefaultController {
	
	public static final String SUCCESS = "success";
	public static final String FAILURE = "failure";
	
	@Value("#{servletContext.contextPath}")
	public String servletContextPath;
	
	
	@Resource(name="orderService")
	OrderService orderService;
	
	/*public int refreshOrder(String memb_id) throws Exception {
		// 미결재내역  세션 생성
		TB_ODINFOXM resultNotPayCnt= new TB_ODINFOXM();
		resultNotPayCnt.setREGP_ID(memb_id);	
		List<TB_ODINFOXM> notPayCnt =(List<TB_ODINFOXM>) orderService.getObjectList(resultNotPayCnt);
		int cnt = 0;
		for(int i=0; i<notPayCnt.size();i++){
			if(notPayCnt.get(i).getORDER_CON().equals("ORDER_CON_01"))
				cnt++;
		}
	
		return cnt;
	}*/
	
}
