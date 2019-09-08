package com.stu.user.dao;

import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


@Component
public interface StuCourseDao {
    int getTotalCourse();

    List<Map<String,Object>> getAllCourse(String keywords, int begin, int rows);

    List<Integer> getStuCourse(int stuId);

    int getCanGetCourse();

    void getCourse(int stuId, int courseId);
}
