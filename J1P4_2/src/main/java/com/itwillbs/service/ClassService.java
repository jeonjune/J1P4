package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.persistence.ClassDAO;

@Service
public class ClassService {
    
    @Autowired
    private ClassDAO classDAO;

    public List<ClassVO> getAllClasses(Criteria cri) {
        return classDAO.getAllClasses(cri);
    }
    
    public int getClassesCount() {
    	return classDAO.getClassesCount();
    }

    public ClassVO getClassById(int classNo) {
        return classDAO.getClassById(classNo);
    }

    public void addClass(ClassVO classVO) {
        classDAO.addClass(classVO);
    }

    public void editClass(ClassVO classVO) {
        classDAO.editClass(classVO);
    }

    public void deleteClass(int classNo) {
        classDAO.deleteClass(classNo);
    }

}
