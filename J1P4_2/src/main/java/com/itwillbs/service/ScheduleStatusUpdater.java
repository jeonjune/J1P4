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
    
    @Scheduled(cron = "0 0 0 * * ?")  // 매일 자정에 실행 (테스트용)
//    @Scheduled(cron = "0 * * * * ?")  // 매일 매분에 실행 (테스트용)
    public void updateScheduleStatus() {
        List<ClassScheduleVO> schedules = classScheduleDAO.getRecruitmentSchedules();
        LocalDate today = LocalDate.now();

        for (ClassScheduleVO schedule : schedules) {
            LocalDate startDate = schedule.getStartDate().toLocalDate();
            LocalDate endDate = schedule.getEndDate().toLocalDate();
            long totalClasses = ChronoUnit.DAYS.between(startDate, endDate) + 1;  // 수업 일수 계산

            if (today.isEqual(startDate.minusDays(1))) {
                ClassVO classVO = classDAO.getClassById(schedule.getClassNo());
                if (schedule.getCurrentEnrollment() >= classVO.getMinCapacity() && schedule.getCurrentEnrollment() <= classVO.getMaxCapacity()) {
                    schedule.setStatus("정상");
                    classScheduleDAO.updateScheduleStatus(schedule);

                    // 정상 상태로 변경 시 classAttendance 테이블에 학생 등록 정보 삽입
                    List<RegistrationVO> registeredStudents = registrationDAO.getStudentsBySchedule(schedule.getScheduleId());
                    for (RegistrationVO student : registeredStudents) {
                        ClassAttendanceVO attendance = new ClassAttendanceVO();
                        attendance.setClassSchedule_no(schedule.getScheduleId());
                        attendance.setMem_no(student.getMem_no());
                        attendance.setTotalClasses((int) totalClasses);  // 총 수업 일수 설정
                        attendance.setAttendedClasses(0);  // 초기값 설정

                        // 중복된 항목이 있는지 확인
                        ClassAttendanceVO existingAttendance = classAttendanceDAO.getAttendanceByScheduleAndMember(schedule.getScheduleId(), student.getMem_no());
                        if (existingAttendance == null) {
                            classAttendanceDAO.saveAttendance(attendance);
                        }
                        logger.info("스케줄러 실행 정상처리");
                    }
                } else {
                    schedule.setStatus("폐강");
                    classScheduleDAO.updateScheduleStatus(schedule);
                    logger.info("스케줄러 실행 폐강처리");
                }
            }

            // 종료 조건 추가
            if (today.isAfter(endDate)) {
                schedule.setStatus("종료");
                classScheduleDAO.updateScheduleStatus(schedule);
                logger.info("스케줄러 실행 종료처리");
            }
        }
    }
}
