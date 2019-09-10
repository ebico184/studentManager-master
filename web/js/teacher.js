$(document).ready(function(){
    //checkAdminLogin();
	initSwitch();
	initDataGrid();
	initClick();
});

/*var checkAdminLogin = function(){
    $.ajax({
        url:"/stu/stuManager/getAdminLoginStatus.do",
        type:"POST",
        data:{

        },
        success:function(result){
            if(result.code){
                //已经登陆
                //什么也不做
            }else{
                alert("请先登录!");
                //跳转
                window.location.href='/login.jsp';
            }
        }
    });
};*/

var selectedUser;

//初始化按钮开关
var initSwitch = function(){
    $("#studentSwitch").bootstrapSwitch({
        onText:"开放",
        offText:"关闭",
        onColor:"primary",
        offColor:"default",
        size:"small",
        onInit:function(){
            $.ajax({
                url:"/stu/teaManager/getSwitch.do",
                type:"POST",
                data:{
                    name:"teacherSwitch"
                },
                success:function (result) {
                    if(result.data==1){
                        $("#studentSwitch").bootstrapSwitch('toggleState');
                    }
                }
            });
        },
        onSwitchChange:function(event,state){
            changeSwitchState(state);
        }
    });
};

//设置switch状态
var changeSwitchState = function(state){
    $.ajax({
        url:"/stu/teaManager/setSwitch.do",
        type:"POST",
        data:{
            name:"teacherSwitch",
            state:state
        },
        success:function (result) {
            //DONOTING
        }
    });
};

//初始化datagrid
var initDataGrid = function(){
	$("#content").datagrid({
		url:"/stu/teaManager/getAllTeacher.do",
		width:'auto',   //表格宽度
		height:'500px',
		columns:[[
			{field:'id',title:'编号',width:'auto',hidden:'true'},
			{field:'t_name',title:'姓名',width:'80',align : 'center'},
			{field:'gender',title:'性别',width:'80',align : 'center'},
            {field:'professional_title',title:'职称',width:'140',align : 'center'},
            {field:'phone_number',title:'联系电话',width:'200',align : 'center'},
			{field:'address',title:'联系地址',width:'350',align : 'center'},
			{field:'opt',title:'操作',width:'100',align:'center',
				formatter:function(value, row, index){
                var str = '<a href="javascript:;" onclick="showUpdateBox(\''+row.id+'\')" name="update" class="easyui-linkbutton" ></a>';
                str += '<a href="javascript:;" onclick="del(\''+row.id+'\')" name="del" class="easyui-linkbutton" ></a>';
                return str; }
			}
		]],
        onLoadSuccess:function(data){
            $("a[name='update']").linkbutton({text:'修改',plain:true,iconCls:'icon-edit'});
            $("a[name='del']").linkbutton({text:'删除',plain:true,iconCls:'icon-remove'});
        },
        border:false,
		pagination:true,
		pageList:[18,25,30,40,50],
		pageSize:18,
		striped:true,
		nowrap:true,
		autoRowHeight:true,
		checkOnSelect:true,
		fitColumns:true,
		loadMsg:'怕是等一下哦',
		toolbar:"#toolBar",
        queryParams:{
            keywords:""
		}
	});
};

//绑定点击事件
var initClick = function(){
	//全选按钮
	$("#checkAll-btn").click(function(){
        $("#content").datagrid("selectAll");
	});
	//取消选择按钮
    $("#unCheckAll-btn").click(function(){
        $("#content").datagrid("unselectAll");
    });
	//搜索按钮
	$("#searchBarBtn").click(function(){
		var keywords = $("#searchBarText").val();
        $("#content").datagrid("load",{keywords:keywords});
	});
	//显示全部按钮
	$("#showAll-btn").click(function(){
        $("#content").datagrid("load",{keywords:""});
	});
	//添加按钮
	$("#add-btn").click(function(){
        $("#dd").dialog({
            title:"添加教师",
			width:400,
			height:'auto'
        });
	});

	//添加教师
	$("#subAddBtn").click(function(){
	    var name = $("#add-name").val();
	    var professionalTitle = $("#add-professionalTitle").val();
	    var sex = $("input[name='addSex']:checked").val();
        var phone = $("#add-phone").val();
        var address = $("#add-address").val();


        if(name=='' || name.length<2 || name.length>10)
        {
            $.messager.alert({
                title:"提示",
                icon:"error",
                msg:"请填写正确格式的名字！长度在2~10个字符间"
            });
            return
        }

        $.ajax({
            url:"/stu/teaManager/addTeacher.do",
            type:"POST",
            data:{
                addT_name:name,
                addGender:sex,
                addPhone_number:phone,
                addAddress:address,
                addProfessioanl_title:professionalTitle
            },

            success:function(){
					$.messager.confirm("提示","添加成功!",function(r){
						if(r){
                            $("#dd").dialog('close');
                            $("#content").datagrid("load");
						}else{
                            $("#dd").dialog('close');
                            $("#content").datagrid("load");
						}
                });
            },
            error:function(){
                $.messager.alert({
                    title:"提示消息",
                    icon:"error",
                    msg:"添加失败！"
                });
            }
        });
    });

	//多选删除
	$("#del-btn").click(function(){
        var selectedRow = $("#content").datagrid("getSelections");
        var ids = [];
        for(var i=0;i<selectedRow.length;i++){
            ids.push(selectedRow[i].id);
        }
        $.messager.confirm("提示","您确定要删除这几条教师信息吗？",function(r){
			if(r){
                $.ajax({
                    url:"/stu/teaManager/delMoreTeacher.do",
                    type:"POST",
                    data:{
                        ids:ids
                    },
                    cache:false,
                    dataType:"json",
                    traditional: true,
                    success:function(data){
                        if(data.code){
                            $.messager.confirm("提示",data.msg,function(r){
                                if(r){
                                    $("#content").datagrid("load");
                                }else{
                                    $("#content").datagrid("load");
                                }
                            });
                        }else{
                            $.messager.confirm("提示",data.msg,function(r){
                                if(r){
                                    //DO NOTING
                                }
                            });
                        }
                    },
                    error:function(){
                        $.messager.alert({
                            title:"提示",
                            icon:"error",
                            msg:"删除失败！"
                        });
                    }
                });
			}
		});
	});
    //修改教师信息

    $("#subUpdateBtn").click(function(){
        var id = $("#update-hiddenID").val();
        var name = $("#update-name").val();
        var professionalTitle = $("#update-professionalTitle").val();
        var sex = $("input[name='updateSex']:checked").val();
        var phone = $("#update-phone").val();
        var address = $("#update-address").val();

        if(name=='' || name.length<2 || name.length>10)
        {
            $.messager.alert({
                title:"提示",
                icon:"error",
                msg:"请填写正确格式的名字！"
            });
            return
        }

        if(phone.length!=11)
        {
            $.messager.alert({
                title:"提示",
                icon:"error",
                msg:"电话号码长度错误！"
            });
            return
        }

        var p = /[a-z A-Z]/i;

        if(p.test(phone)==true)
        {
            $.messager.alert({
                title:"提示",
                icon:"error",
                msg:"电话号码包含非法字符！"
            });
            return
        }

        $.ajax({
            url:"/stu/teaManager/updateTeacher.do",
            type:"POST",
            data:{
                updateId:id,
                updateT_name:name,
                updateGender:sex,
                updatePhone_number:phone,
                updateAddress:address,
                updateProfessioanl_title:professionalTitle
            },
            success:function(data){
                if(data.code){
                    $.messager.confirm("提示",data.msg,function(r){
                        if(r){
                            $("#updateBox").dialog("close");
                            $("#content").datagrid("load");
                        }else{
                            $("#updateBox").dialog("close");
                            $("#content").datagrid("load");
                        }
                    });
                }else{
                    $.messager.confirm("提示",data.msg,function(r){
                        if(r){
                            //DO NOTING
                        }
                    });
                }
            },
            error:function(e){
                $.messager.alert({
                    title:"提示",
                    icon:"error",
                    msg:"修改失败！"
                });
            }
        });

    });


    //显示全部按钮
    $("#showAllQualityBtn").click(function(){
        var teacherId = $("#teacherHiddenId").val();
        $("#qualityDatagrid").datagrid("reload",{id:teacherId,keywords:""});
    });
};

//显示修改教师信息对话框
var showUpdateBox = function(id){
	$.ajax({
		url:"/stu/teaManager/getTeacher.do",
        type:"POST",
        data:{
            id:id
        },
		success:function(data){
			if(data.code){
				$("#update-hiddenID").val(data.data.id);
                $("#update-name").val(data.data.t_name);
                $("#update-professionalTitle").val(data.data.professional_title);
				$(":radio[name='updateSex'][value='" + data.data.gender + "']").prop("checked", "checked");
                $("#update-phone").val(data.data.phone_number);
                $("#update-address").val(data.data.address);
                $("#updateBox").dialog({
                    title:"修改信息",
                    width:400,
                    height:460
                });
			}else{
                $.messager.alert("提示","信息加载失败");
			}
		},
		error:function(){
			$.messager.alert("提示","信息加载失败");
		}
	});

};

//删除教师信息
var del = function(id){
	$.messager.confirm("确认信息","您确定要删除这条学生信息吗？",function(r){
		if(r){
			$.ajax({
				url:"/stu/teaManager/delTeacher.do",
				type:"POST",
				data:{
					id:id
				},
				success:function(data){
					if(data.code){
                        $.messager.confirm("提示",data.msg,function(r){
                            if(r){
                                $("#content").datagrid("load");
                            }else{
                                $("#content").datagrid("load");
                            }
                        });
					}else{
                        $.messager.confirm("提示",data.msg,function(r){
                            if(r){
                                //DO NOTING
                            }
                        });
					}
				},
				error:function(){
                    $.messager.alert({
                        title:"提示",
                        icon:"error",
                        msg:"删除失败！"
                    });
				}
			});
		}
	});
};
