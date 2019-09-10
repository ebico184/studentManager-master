package com.stu.admin.service;

import com.stu.admin.dao.TeaManagerDao;
import com.sun.javafx.collections.MappingChange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class TeaManagerService {
    @Autowired
    private TeaManagerDao teaManagerDao;

    /**
     * 获取教师全部信息
     * @return
     */
    public Map<String, Object> getAlltea(String keywords,int page,int rows){
        Map<String, Object> result = new HashMap<String, Object>();
        List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
        if(keywords == null || keywords == "null"){
            keywords = "";
        }

        int begin = (page-1)*rows;
        int total = teaManagerDao.getCountTeacher(keywords);
        data = teaManagerDao.getAllTeacher(keywords,begin,rows);
        result.put("total", total);
        result.put("rows", data);
        return result;
    }

    /**
     * 添加学生
     * @param addT_name
     * @param addGender
     * @param addPhone_number
     * @param addAddress
     * @param addProfessioanl_title
     * @return
     */
    public Map<String,Object> addTeacher(String addT_name, String addGender, String addPhone_number, String addAddress, String addProfessioanl_title) {
        Map<String,Object> result = new HashMap<String,Object>();
        teaManagerDao.addTeacher(addT_name,addGender,addPhone_number,addAddress,addProfessioanl_title);

        result.put("code",true);
        result.put("msg","添加成功!");
        return result;
    }

    /**
     * 删除教师信息
     * @param id
     * @return
     */
    public Map<String,Object> delStudent(String id) {
        Map<String,Object> result = new HashMap<String,Object>();
        //删除教师表中数据
        teaManagerDao.delTeacher(id);
        result.put("code",true);
        result.put("msg","删除成功!");
        return result;
    }

    /**
     * 根据教师ID查找教师
     * @param id
     * @return
     */
    public Map<String, Object> getTeacher(String id){
        Map<String , Object> result = new HashMap<String, Object>();
        Map<String, Object> data = new HashMap<String, Object>();

        if(id != null && id !="null" && id != ""){
            data = teaManagerDao.getTeacher(id);
            result.put("code", true);
            result.put("data", data);
            return  result;
        }

        result.put("code", false);
        result.put("msg", "查找失败");
        return result;
    }

    /**
     * 更新教师的信息
     * @param updateT_name
     * @param updateGender
     * @param updatePhone_number
     * @param updateAddress
     * @param updateProfessioanl_title
     */
    public Map<String,Object> updateTeacher(String updateT_name, String updateGender, String updatePhone_number, String updateAddress, String updateProfessioanl_title, String updateId){
        Map<String, Object> result = new HashMap<String, Object>();

        if(updateT_name == null){
            updateT_name = "";
        }

        if(updateGender == null){
            updateGender = "";
        }

        if(updatePhone_number == null){
            updatePhone_number = "";
        }

        if(updateAddress == null){
            updateAddress = "";
        }

        if(updateProfessioanl_title == null){
            updateProfessioanl_title = "";
        }
        teaManagerDao.updateTeacher(updateT_name, updateGender,updatePhone_number, updateAddress, updateProfessioanl_title, updateId);
        result.put("code", true);
        result.put("msg", "修改成功");
        return result;
    }

    /**
     * 多选删除
     * @param ids
     * @return
     */
    public Map<String,Object> delMoreTeacher(String[] ids) {
        Map<String, Object> result = new HashMap<String, Object>();

        if(ids == null){
            result.put("code", false);
            result.put("msg", "未选择");
            return result;
        }

        List<String> idList = new ArrayList<>();
        for (String str :ids){
            idList.add(str);
        }

        teaManagerDao.delMoreTeacher(idList);
        result.put("code", true);
        result.put("msg", "删除成功");
        return result;
    }
}
