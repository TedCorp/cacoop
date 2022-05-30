package mall.web.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.domain.Customers;
import mall.web.service.CustomersService;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.controller
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 고객정보관리 Controller
 * @Company	: YT Corp.
 * @Author	: Byeong-gwon Gang (multiple@nate.com)
 * @Date	: 2016-07-07 (오후 11:04:15)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
@Controller
@RequestMapping(value="/customers")
public class CustomersController {
	
	private static final String SUCCESS = "success";
	private static final String FAILURE = "failure";
	
	@Value("#{servletContext.contextPath}")
	private String servletContextPath;
	
	@Resource(name="customersService")
	CustomersService customersService;
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: getCustomersList
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객목록 조회
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:04:40)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getCustomersList(@ModelAttribute Customers customers, Model model) throws Exception {
		List<Customers> customersList = null;
		customersList = customersService.selectCustomersList(customers);
		model.addAttribute("customersList", customersList);
		return new ModelAndView("admin.layout", "jsp", "admin/customers/list");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: view
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객정보조회 
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-08 (오전 9:30:03)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/{CUSTOMERNUMBER}", method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute Customers customers, Model model) throws Exception {
		Customers customer = null;
		customer = customersService.selectCustomers(customers);
		model.addAttribute("customer", customer);
		return new ModelAndView("admin.layout", "jsp", "admin/customers/view");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: editNew
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객정보 등록 폼
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:04:52)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public ModelAndView editNew(@ModelAttribute Customers customers, Model model) throws Exception {
		return new ModelAndView("admin.layout", "jsp", "admin/customers/new");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: insert
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객정보 등록
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:05:15)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param result
	 * @param status
	 * @param model
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(method=RequestMethod.POST)
	public @ResponseBody String insert(@ModelAttribute Customers customers, BindingResult result, SessionStatus status, Model model) throws Exception {
		int insertCnt = customersService.insertCustomers(customers);
		return insertCnt > 0 ? SUCCESS : FAILURE;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: edit
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객정보 변경을 위한 정보 조회
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-08 (오전 9:31:25)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/edit/{CUSTOMERNUMBER}", method=RequestMethod.GET)
	public ModelAndView edit(@ModelAttribute Customers customers, Model model) throws Exception {
		Customers customer = null;
		customer = customersService.selectCustomers(customers);
		model.addAttribute("customer", customer);
		return new ModelAndView("admin.layout", "jsp", "admin/customers/edit");
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: update
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 고객정보 수정
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-07 (오후 11:05:47)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param result
	 * @param status
	 * @param model
	 * @return String
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/edit/{CUSTOMERNUMBER}", method=RequestMethod.PUT)
	public @ResponseBody String update(@ModelAttribute Customers customers, BindingResult result, SessionStatus status, Model model) throws Exception {
		int updateCnt = customersService.updateCustomers(customers);
		return updateCnt > 0 ? SUCCESS : FAILURE;
	}
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.web.controller.CustomersController.java
	 * @Method	: delete
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 삭제 
	 * @Company	: YT Corp.
	 * @Author	: Byeong-gwon Gang (multiple@nate.com)
	 * @Date	: 2016-07-08 (오전 11:14:21)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @param customers
	 * @param result
	 * @param status
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@RequestMapping(value="/{CUSTOMERNUMBER}", method=RequestMethod.DELETE)
	public ModelAndView delete(@ModelAttribute Customers customers, BindingResult result, SessionStatus status, Model model) throws Exception {
		RedirectView rv = new RedirectView(servletContextPath + "/customers");
		return new ModelAndView(rv);
	}
}
