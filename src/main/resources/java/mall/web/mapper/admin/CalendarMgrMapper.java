package mall.web.mapper.admin;

import java.util.List;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Package	: mall.web.mapper.admin
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * @Desc	: 게시판 관리
 * @Company	: YT Corp.
 * @Author	: Young-dae Kim (sjie1638@youngthink.co.kr)
 * @Date	: 2016-07-18 (오전 10:56:41)
 * @Version	: 1.0
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/
public interface CalendarMgrMapper {
	public int count(Object obj) throws Exception;
	public List<?> schedulTotList(Object obj) throws Exception;
	public List<?> schedulList(Object obj) throws Exception;
	public int insertSchdul(Object obj) throws Exception;
	public int updateSchdul(Object obj) throws Exception;
	public int deleteSchdul(Object obj) throws Exception;
}
