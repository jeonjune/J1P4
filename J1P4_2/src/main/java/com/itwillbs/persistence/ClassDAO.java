package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.Criteria;

@Repository
public class ClassDAO {
    private static final String NAMESPACE = "com.itwillbs.mapper.ClassMapper";

    @Autowired
    private SqlSession sqlSession;

    public List<ClassVO> getAllClasses(Criteria cri) {
        return sqlSession.selectList(NAMESPACE + ".getAllClasses", cri);
    }
    
    public int getClassesCount() {
    	return sqlSession.selectOne(NAMESPACE + ".getClassesCount");
    }

    public ClassVO getClassById(int classNo) {
        return sqlSession.selectOne(NAMESPACE + ".getClassById", classNo);
    }

    public void addClass(ClassVO classVO) {
        sqlSession.insert(NAMESPACE + ".addClass", classVO);
    }

    public void editClass(ClassVO classVO) {
        sqlSession.update(NAMESPACE + ".editClass", classVO);
    }

    public void deleteClass(int classNo) {
        sqlSession.delete(NAMESPACE + ".deleteClass", classNo);
    }

}
