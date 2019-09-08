package com.stu.user.dao;

import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


public interface GradeDao {
    int getTotalGrade(int stuId);

    List<Map<String,Object>> getGrade(int stuId, int begin, int rows);

    List<Map<String,Object>> getAllGrade(int stuId);
}
