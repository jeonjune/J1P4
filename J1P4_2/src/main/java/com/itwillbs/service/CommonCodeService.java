package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.persistence.CommonCodeDAO;
import com.itwillbs.domain.CommonCodeVO;
import com.itwillbs.domain.CommonCodeDetailVO;

@Service
public class CommonCodeService {

    @Autowired
    private CommonCodeDAO commonCodeDAO;

    public List<CommonCodeVO> getAllCommonCodes() {
        return commonCodeDAO.getAllCommonCodes();
    }

    public CommonCodeVO getCommonCodeById(String codeId) {
        return commonCodeDAO.getCommonCodeById(codeId);
    }

    public List<CommonCodeDetailVO> getCommonCodeDetailsByCodeId(String codeId) {
        return commonCodeDAO.getCommonCodeDetailsByCodeId(codeId);
    }
}
