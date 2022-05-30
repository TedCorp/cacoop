package mall.web.service.admin.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.admin.CompanySaleMgrMapper;
import mall.web.service.DefaultService;

@Service("companySaleMgrService")
public class CompanySaleMgrService implements DefaultService{

	@Resource(name="companySaleMgrMapper")
	CompanySaleMgrMapper companySaleMgrMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return companySaleMgrMapper.count(obj);
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return companySaleMgrMapper.list(obj);
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return companySaleMgrMapper.paginatedList(obj);
	}


	@Override
	public Object getObject(Object obj) throws Exception {
		return companySaleMgrMapper.find(obj);
	}

	public List<?> getExcelList(Object obj) throws Exception {
		return companySaleMgrMapper.excelList(obj);
	}
	public List<?> excelDownDetail(Object obj) throws Exception {
		return companySaleMgrMapper.excelDownDetail(obj);
	}
	
	//디테일카운터
	public int getObjectCountDetail(Object obj) throws Exception {
		return companySaleMgrMapper.countDetail(obj);
	}
	
	
	//디테일리스트
	public List<?> getPaginatedObjectListDetail(Object obj) throws Exception {
		return companySaleMgrMapper.paginatedListDetail(obj);
	}
	
	
	//사용안함
	@Override
	public int insertObject(Object obj) throws Exception {
		return 0;
	}
	//사용안함
	@Override
	public int updateObject(Object obj) throws Exception {
		return 0;
	}
	//사용안함
	@Override
	public int deleteObject(Object obj) throws Exception {
		return 0;
	}

}
