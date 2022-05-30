package mall.web.controller.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import mall.web.controller.DefaultController;
import mall.web.domain.TB_MBINFOXM;
import mall.web.domain.TB_SYSCALXM;
import mall.web.domain.TB_SYSGRPXM;
import mall.web.service.admin.impl.CalendarMgrService;

@Controller
@RequestMapping(value="/adm/calendarMgr")
public class CalendarMgrController extends DefaultController{

	@Resource(name="calendarMgrService")
	CalendarMgrService calendarMgrService;
	
	
	@RequestMapping(value="/list")
	public ModelAndView getList(@ModelAttribute TB_SYSCALXM tb_syscalxm, ModelMap model,HttpServletRequest request,
			@RequestParam(defaultValue = "0") String moveGbn, @RequestParam(defaultValue = "0") String setMonth,
			@RequestParam(defaultValue = "0") String setYear) throws Exception {

		// 일정 리스트
		List<?> schedulMap = null;
		List<Object> addMoreMap = null;

		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			tb_syscalxm.setMEMB_ID(loginUser.getMEMB_ID());
			// 전체일정리스트
			schedulMap = calendarMgrService.getObjectList(tb_syscalxm);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Date calToday = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


		String calenderStart = sdf.format(calToday);

		// 현재날짜 스플릿 년-월-일
		String[] strCal = calenderStart.split("-");

		int year = 0;

		if(setYear.equals("0")){
			year = Integer.parseInt(strCal[0]);
		}else{
			year = Integer.parseInt(setYear);
		}

		int month =  0;

		if(setMonth.equals("0")){
			month =  Integer.parseInt(strCal[1]);
		}else{
			int parseMonth = Integer.parseInt(setMonth);

			if(moveGbn.equals("0")){
				if(parseMonth==1){
					month = 12;
					year -=1;
				}else
					month = parseMonth-1;

			}else if(moveGbn.equals("1")){
				if(parseMonth==12){
					month = 1;
					year +=1;
				}else
					month = parseMonth+1;

			}
		}

		int start = 0;
		int end =0;
		int base = 2006;
		boolean bool = false;

		if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
			bool = true;

		switch(month) {
			case 1: case 3: case 5: case 7: case 8:
			case 10: case 12: end = 31; break;

			case 4: case 6: case 9: case 11: end = 30; break;

			case 2: if(bool) end = 29; else end = 28;
		}

		start = year - base;
		for(int i = base; i < year; ++i)
			if(i % 4 == 0 && i % 100 != 0 || i % 400 == 0)
				start++;
		start %= 7;

		for(int i = 1; i < month; ++i) {
			switch(i) {
			case 1: case 3: case 5: case 7: case 8:
			case 10: case 12: start += 31; break;

			case 4: case 6: case 9: case 11: start += 30; break;

			case 2: if(bool) start += 29; else start += 28;
			}
		}
		start %= 7;

		String monthStn="";
		if(month < 10){
			monthStn="0"+Integer.toString(month);
		}else{
			monthStn = Integer.toString(month);
		}
		// year년 monthStn월
		List<String> compDateList = new ArrayList<>();
		HashMap<String, String> compOrdMap = new HashMap();


		String eventJoinChk = "N";
		for(Object schedul : schedulMap){
			// 일정 리스트
			compDateList.add(((TB_SYSCALXM)schedul).getCAL_DATE());
		}


		HashMap<Integer,String> compChk = new HashMap<>();

		

		// 일정이 있는 날짜 위치
		for(int i=1; i<=end; i++){
			String date = Integer.toString(i);
			if(i<10)
				date = "0"+date;
			String compDate = year+"-"+monthStn+"-"+date;
			
			if(compDateList.contains(compDate)){	
				compChk.put(i+start, "Y"); // +start는 jsp에서 계산 때문에
			}
			else{
				compChk.put(i+start, "N");
			}
		}
		
		// 달력만들기 재료
		model.addAttribute("year", year);
		model.addAttribute("monthStn", monthStn);
		model.addAttribute("start", start);
		model.addAttribute("end", start+end);
	
		// 오늘 날짜
		String[] todayCal = sdf.format(calToday).split("-");
		model.addAttribute("todayCalY",todayCal[0]);
		model.addAttribute("todayCalM",todayCal[1]);
		model.addAttribute("todayCalD",todayCal[2]);	
	
		model.put("compChk", compChk);
	
		model.addAttribute("calenderStart", calenderStart);
		
		
		return new ModelAndView("admin.layout", "jsp", "admin/calendarMgr/list");
	}
	
	@RequestMapping(value="/view")
	public ModelAndView getView(@ModelAttribute TB_SYSCALXM tb_syscalxm, ModelMap model,HttpServletRequest request) throws Exception {
		

		List<?> schedulMap = null;
		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			tb_syscalxm.setMEMB_ID(loginUser.getMEMB_ID());
			// 일자 내 일정리스트
			schedulMap = calendarMgrService.getSchedulList(tb_syscalxm);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		model.addAttribute("CAL_DATE",tb_syscalxm.getCAL_DATE());
		model.put("schedulMap", schedulMap);
		
		return new ModelAndView("admin.layout", "jsp", "admin/calendarMgr/view");
	}
	
	
	@RequestMapping(value="/insert")
	public ModelAndView getInsert(@ModelAttribute TB_SYSCALXM tb_syscalxm, ModelMap model,HttpServletRequest request
												 , @RequestParam(defaultValue = "0") String saveGbn) throws Exception {
		
		String strRtrUrl = "";
		
		int result = 0;
		
		if(tb_syscalxm.getCAL_CONT()!=null && !tb_syscalxm.getCAL_CONT().equals(""))
			tb_syscalxm.setCAL_CONT(tb_syscalxm.getCAL_CONT().replace("\r\n", "<br>"));
		
		try {
			TB_MBINFOXM loginUser = (TB_MBINFOXM)request.getSession().getAttribute("ADMUSER");
			tb_syscalxm.setMEMB_ID(loginUser.getMEMB_ID());
			
			if (saveGbn.equals("0")) {
				// 일정 저장
				result = calendarMgrService.insertObject(tb_syscalxm);				
			}else if (saveGbn.equals("1")) {
				// 일정 수정
				result = calendarMgrService.updateObject(tb_syscalxm);				
			}else {
				// 일정 삭제
				result = calendarMgrService.deleteObject(tb_syscalxm);
			}
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		
		strRtrUrl = "/adm/calendarMgr/view?CAL_DATE="+tb_syscalxm.getCAL_DATE();		
		RedirectView rv = new RedirectView(servletContextPath.concat(strRtrUrl));
		return new ModelAndView(rv);
	
		
	}
}
