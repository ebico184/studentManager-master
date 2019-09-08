package com.stu.admin.dao;

import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


@Component
public interface AFLManagerDao {


    List<Map<String,Object>> getAllStuAFL(String keyword, int begin, int rows);

    int getTotalAFL(String keyword);

    void delStuAFL(int stuId,int aflId);

    void approveStuAFL(int stuId,int aflId);




}
