package com.itwillbs.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.ClassAttendanceVO;
import com.itwillbs.persistence.ClassDAO;
import com.itwillbs.persistence.ClassScheduleDAO;
import com.itwillbs.persistence.ClassAttendanceDAO;
import com.itwillbs.persistence.RegistrationDAO;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Component
public class ScheduleStatusUpdater {
    
    private static final Logger logger = LoggerFactory.getLogger(ScheduleStatusUpdater.class);
    
    @Autowired
    private ClassScheduleDAO classScheduleDAO;

    @Autowired
    private ClassDAO classDAO;

    @Autowired
    private ClassAttendanceDAO classAttendanceDAO;

    @Autowired
    private RegistrationDAO registrationDAO;
    
    // 매일 자정에 실행 (실제 환경용)
    @Scheduled(cron = "0 0 0 * * ?")
//     매일 매분에 실행 (테스트용)
//    @Scheduled(cron = "0 * * * * ?")  
    public void updateScheduleStatus() {
        List<ClassScheduleVO> schedules = classScheduleDAO.getRecruitmentSchedules();
        LocalDate today = LocalDate.now();

        for (ClassScheduleVO schedule : schedules) {
            LocalDate startDate = schedule.getStartDate().toLocalDate();
            LocalDate endDate = schedule.getEndDate().toLocalDate();
            long totalClasses = ChronoUnit.DAYS.between(startDate, endDate) + 1;

            if (today.isEqual(startDate.minusDays(1))) {
                ClassVO classVO = classDAO.getClassById(schedule.getClassNo());
                if (schedule.getCurrentEnrollment() >= classVO.getMinCapacity() && schedule.getCurrentEnrollment() <= classVO.getMaxCapacity()) {
                    schedule.setStatus("정상");
                    classScheduleDAO.updateScheduleStatus(schedule);
                    logger.info("@@@@" + schedule.toString());
                    List<RegistrationVO> registeredStudents = registrationDAO.getStudentsBySchedule(schedule.getScheduleId());
                    for (RegistrationVO student : registeredStudents) {
                        Integer scheduleId = schedule.getScheduleId(); // 변경: int -> Integer
                        Integer memNo = student.getMem_no(); // 변경: int -> Integer

                        if (scheduleId == null || memNo == null) {
                            logger.error("Null value detected: scheduleId={}, memNo={}", scheduleId, memNo);
                            continue;
                        }

                        ClassAttendanceVO attendance = new ClassAttendanceVO();
                        attendance.setClassSchedule_no(scheduleId);
                        attendance.setMem_no(memNo);
                        attendance.setTotalClasses((int) totalClasses);
                        attendance.setAttendedClasses(0);
                        logger.info("@@@" + scheduleId , "@@@" + memNo);
                        
                        classAttendanceDAO.saveAttendance(attendance);
                        logger.info("스케줄러 실행 정상처리");
                    }
                } else {
                    schedule.setStatus("폐강");
                    classScheduleDAO.updateScheduleStatus(schedule);
                    logger.info("스케줄러 실행 폐강처리");
                }
            }

            if (today.isAfter(endDate)) {
                schedule.setStatus("종료");
                classScheduleDAO.updateScheduleStatus(schedule);
                logger.info("스케줄러 실행 종료처리");
            }
        }
    }


}
