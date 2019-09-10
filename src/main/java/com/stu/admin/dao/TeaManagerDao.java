package com.stu.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface TeaManagerDao {

    int getCountTeacher(String keywords);

    List<Map<String,Object>> getAllTeacher(String keywords, int begin, int rows);

    void addTeacher(String addT_name, String addGender, String addPhone_number, String addAddress, String addProfessioanl_title);

    void delTeacher(String id);

    Map<String,Object> getTeacher(String id);

    void updateTeacher(String updateT_name, String updateGender, String updatePhone_number, String updateAddress, String updateProfessioanl_title, String updateId);

    void delMoreTeacher(List<String> idList);
}
