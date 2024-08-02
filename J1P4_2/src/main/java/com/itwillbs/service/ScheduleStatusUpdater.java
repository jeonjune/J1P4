package com.itwillbs.service;

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
import java.util.List;

@Component
public class ScheduleStatusUpdater {

    @Autowired
    private ClassScheduleDAO classScheduleDAO;

    @Autowired
    private ClassDAO classDAO;

    @Autowired
    private ClassAttendanceDAO classAttendanceDAO;

    @Autowired
    private RegistrationDAO registrationDAO;

    @Scheduled(cron = "0 0 0 * * ?")  // 매일 자정에 실행
//    @Scheduled(cron = "0 * * * * ?")  // 매일 매분에 실행
    public void updateScheduleStatus() {
        List<ClassScheduleVO> schedules = classScheduleDAO.getRecruitmentSchedules();
        LocalDate today = LocalDate.now();

        for (ClassScheduleVO schedule : schedules) {
            LocalDate startDate = schedule.getStartDate().toLocalDate();
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
                        attendance.setTotalClasses(1);  // 초기값 설정 필요
                        attendance.setAttendedClasses(0);  // 초기값 설정 필요
                        classAttendanceDAO.saveAttendance(attendance);
                    }
                } else {
                    schedule.setStatus("폐강");
                    classScheduleDAO.updateScheduleStatus(schedule);
                }
            }
        }
    }
}
