package com.stu.admin.controller;

import com.stu.admin.service.TeaManagerService;
import com.stu.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/stu/teaManager", method = {RequestMethod.POST,RequestMethod.GET})
public class TeaManagerController {

    @Autowired
    private TeaManagerService teaManagerService;


    /**
     *  获取全部教师的信息
     * @param keywords
     * @param page
     * @param rows
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/getAllTeacher.do",method = {RequestMethod.POST,RequestMethod.GET})
    public void getAllTeacher(String keywords, int page, int rows , HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        Map<String, Object> data = new HashMap<String, Object>();
        data = teaManagerService.getAlltea(keywords, page, rows);
        ResponseUtil.returnJson(data, response);
    }

    /**
     * 添加教师
     * @param addT_name
     * @param addGender
     * @param addPhone_number
     * @param addAddress
     * @param addProfessioanl_title
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/addTeacher.do", method = {RequestMethod.POST,RequestMethod.GET})
    public void addTeacher(String addT_name, String addGender, String addPhone_number, String addAddress, String addProfessioanl_title, HttpServletRequest request, HttpServletResponse response)throws IOException
    {
        Map<String, Object> data = new HashMap<String, Object>();
        data = teaManagerService.addTeacher(addT_name, addGender, addPhone_number, addAddress, addProfessioanl_title);
        ResponseUtil.returnJson(data, response);
    }


    /**
     * 删除教师信息
     * @param id
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping(value = "/delTeacher.do", method ={RequestMethod.POST, RequestMethod.GET})
    public void delTeacher(String id, HttpServletResponse response, HttpServletRequest request)throws IOException
    {
        Map<String, Object> data = new HashMap<String, Object>();
        data = teaManagerService.delStudent(id);
        ResponseUtil.returnJson(data, response);
    }

    @RequestMapping(value = "/delMoreTeacher.do", method = {RequestMethod.POST, RequestMethod.GET})
    public void delMoreTeacher(String[] ids,HttpServletRequest request, HttpServletResponse response)throws IOException
    {
        Map<String, Object> data = new HashMap<String, Object>();
        data = teaManagerService.delMoreTeacher(ids);
        ResponseUtil.returnJson(data, response);
    }

    /**
     * 根据教师id查找教师
     * @param id
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping(value = "/getTeacher.do",method = {RequestMethod.POST,RequestMethod.GET})
    public void getTeacher(String id, HttpServletResponse response, HttpServletRequest request)throws IOException
    {
        Map<String, Object>data = new HashMap<String, Object>();
        data = teaManagerService.getTeacher(id);
        ResponseUtil.returnJson(data, response);
    }

    /**
     *  修改教师信息
     * @param updateT_name
     * @param updateGender
     * @param updatePhone_number
     * @param updateAddress
     * @param updateProfessioanl_title
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value ="/updateTeacher.do" , method = {RequestMethod.POST, RequestMethod.GET})
    public void updateTeacher(String updateT_name, String updateGender, String updatePhone_number, String updateAddress, String updateProfessioanl_title,HttpServletRequest request ,HttpServletResponse response)throws IOException
    {
        Map<String, Object> data = new HashMap<String, Object>();
        data = teaManagerService.updateTeacher( updateT_name,  updateGender,  updatePhone_number, updateAddress, updateProfessioanl_title);
        ResponseUtil.returnJson(data, response);
    }





}
