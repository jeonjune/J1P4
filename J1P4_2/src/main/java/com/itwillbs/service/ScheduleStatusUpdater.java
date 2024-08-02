package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.persistence.ClassDAO;
import com.itwillbs.persistence.ClassScheduleDAO;

import java.time.LocalDate;
import java.util.List;

@Component
public class ScheduleStatusUpdater {

    @Autowired
    private ClassScheduleDAO classScheduleDAO;

    @Autowired
    private ClassDAO classDAO;

//    @Scheduled(cron = "0 * * * * ?") // 매 분 마다 (테스트용)
    @Scheduled(cron = "0 0 0 * * ?")  // 매일 자정에 실행
    public void updateScheduleStatus() {
        List<ClassScheduleVO> schedules = classScheduleDAO.getRecruitmentSchedules();
        LocalDate today = LocalDate.now();

        for (ClassScheduleVO schedule : schedules) {
            LocalDate startDate = schedule.getStartDate().toLocalDate();
            if (today.isEqual(startDate.minusDays(1))) {
                ClassVO classVO = classDAO.getClassById(schedule.getClassNo());
                if (schedule.getCurrentEnrollment() >= classVO.getMinCapacity() && schedule.getCurrentEnrollment() <= classVO.getMaxCapacity()) {
                    schedule.setStatus("정상");
                } else {
                    schedule.setStatus("폐강");
                }
                classScheduleDAO.updateScheduleStatus(schedule);
            }
        }
    }
}
