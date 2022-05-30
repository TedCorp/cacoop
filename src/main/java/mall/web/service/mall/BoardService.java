package mall.web.service.mall;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import mall.web.mapper.mall.BoardMapper;
import mall.web.service.DefaultService;

@Service("boardService")
public class BoardService implements DefaultService {

	@Resource(name="boardMapper")
	BoardMapper boardMapper;
	
	@Override
	public int getObjectCount(Object obj) throws Exception {
		return boardMapper.count(obj); 
	}

	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return null;
	}

	@Override
	public List<?> getPaginatedObjectList(Object obj) throws Exception {
		return boardMapper.paginatedList(obj);
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		return boardMapper.find(obj);
	}

	@Override
	public int insertObject(Object obj) throws Exception {
		return boardMapper.insert(obj);
	}

	@Override
	public int updateObject(Object obj) throws Exception {
		return 0;
	}

	@Override
	public int deleteObject(Object obj) throws Exception {
		return boardMapper.delete(obj);
	}
	
	public int reviewInsert(Object obj) throws Exception {
		return boardMapper.reviewInsert(obj);
	}

	public int qnaInsert(Object obj) throws Exception {
		return boardMapper.qnaInsert(obj); 
	}
	
	public List<?> getBoardObjectList(Object obj) throws Exception {
		return boardMapper.boardList(obj); 
	}
	
	public Object getRevQnaObject(Object obj) throws Exception {
		return boardMapper.revQnaFind(obj);
	}
	
	public int updateObjectQna(Object obj) throws Exception {
		return boardMapper.updateQna(obj);
	}
	
	public int updateObjectReview(Object obj) throws Exception {
		return boardMapper.updateReview(obj);
	}
}
