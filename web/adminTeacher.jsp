<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    if(request.getSession().getAttribute("adminName")==null)
    {
        out.print("<script type=\"text/javascript\"> alert(\"请先登陆!\");window.location=\"/login.jsp\" </script>");
    }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>教育信息管理系统--管理员</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <link href="css/dcalendar.picker.css" rel="stylesheet">
    <![endif]-->
    <link href="css/mycss.css" rel="stylesheet">
    <link href="plugin/easyui/themes/icon.css" rel="stylesheet">
    <link href="plugin/easyui/themes/bootstrap/easyui.css" rel="stylesheet">
    <link href="css/bootstrap-switch.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="#">教育信息管理系统--管理员</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">欢迎您：管理员<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="index.jsp">学生信息管理</a></li>
                            <li><a href="adminTeacher.jsp">教师信息管理</a></li>
                            <li><a href="adminCourseManager.jsp">课程信息管理</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="/stu/user/adminLogout.do">退出系统</a></li>
                            <li><a href="adminChangePassword.jsp">修改密码</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <div class="container-fluid">
        <div class="col-md-2">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="index.jsp">学生信息管理</a></li>
                <li role="presentation" class="active"><a href="adminTeacher.jsp">教师信息管理</a></li>
                <li role="presentation"><a href="adminCourseManager.jsp">课程信息管理</a></li>
            </ul>
        </div>
        <div class="col-md-10">
            <div>
                <ol class="breadcrumb">
                    <li><a href="javascript:void(0)">首页</a></li>
                    <li class="active">教师信息管理</li>
                </ol>
            </div>
            <div id="content">
            </div>
            <div id="toolBar" class="form-horizontal" style="width:100%; margin-bottom:0;vertical-align: middle;">
                <div id="toolBar_btn" class="form-group col-lg-8 col-md-8"  style="margin-bottom:0;">
                    <button class="btn btn-default btn-sm" id="del-btn">多选删除</button>
                    <button class="btn btn-default btn-sm" id="showAll-btn">查询所有</button>
                    <button class="btn btn-default btn-sm" id="add-btn">添加教师</button>
                    <%--<div class="switch" style="display: inline-block">--%>
                    <%--<input type="checkbox" name="my-checkbox" id="studentSwitch">--%>
                    <%--</div>--%>
                    <button class="btn btn-default btn-sm" id="checkAll-btn">全部选择</button>
                    <button class="btn btn-default btn-sm" id="unCheckAll-btn">取消选择</button>
                </div>
                <div id="searchBar" class="form-group" style="margin-bottom:0;">
                    <div class="form-group col-lg-4 col-md-4" style="margin-bottom:0;">
                        <input type="text" class="form-control form-inline input-sm" placeholder="姓名、性别、电话、职称、住址" id="searchBarText">
                    </div>
                    <button id="searchBarBtn" class="btn btn-default btn-sm">搜索</button>
                </div>
            </div>

            <div id="dd" style="padding: 20px;display: none">
                <div class="form-horizontal" id="addForm">
                    <div class="form-group">
                        <label for="add-name" class="col-md-3 control-label">姓名:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="add-name" name="addName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">性别:</label>
                        <div class="col-md-8">
                            <label class="radio-inline">
                                <input type="radio" id="add-radio1" name="addSex" value="男" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" id="add-radio2" name="addSex" value="女"> 女
                            </label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="add-professionalTitle" class="col-md-3 control-label">职称:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="add-professionalTitle" name="addProfessionalTitle">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add-phone" class="col-md-3 control-label">电话:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="add-phone" name="addPhone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add-address" class="col-md-3 control-label">地址:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="add-address" name="addAddress">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-5">
                            <button id="subAddBtn" class="btn btn-primary">提交</button>
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </div>
                </div>
            </div>


            <div id="updateBox" style="padding: 20px;display: none">
                <div class="form-horizontal" id="updateForm">
                    <div class="form-group">
                        <label for="update-name" class="col-md-3 control-label">姓名:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="update-name" name="updateName">
                            <input type="hidden" class="form-control" id="update-hiddenID" name="id">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">性别:</label>
                        <div class="col-md-8">
                            <label class="radio-inline">
                                <input type="radio" id="update-radio1" name="updateSex" value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" id="update-radio2" name="updateSex" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update-professionalTitle" class="col-md-3 control-label">职称:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="update-professionalTitle" name="updateProfessionalTitle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update-phone" class="col-md-3 control-label">电话:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="update-phone" name="updatePhone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update-address" class="col-md-3 control-label">地址:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="update-address" name="updateAddress">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-5">
                            <button id="subUpdateBtn" class="btn btn-primary">提交</button>
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-2.1.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap-switch.min.js"></script>
    <script src="plugin/easyui/jquery.easyui.min.js"></script>
    <script src="plugin/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="js/teacher.js"></script>
    <script src="js/dcalendar.picker.js"></script>

    <script type="text/javascript">
        $('#rewardTime').dcalendarpicker({
            format:'yyyy-mm-dd'
        });

        $('#punishTime').dcalendarpicker({
            format:'yyyy-mm-dd'
        });

        $('#qualityTime').dcalendarpicker({
            format: 'yyyy-mm-dd'
        });
    </script>
</body>
</html>
