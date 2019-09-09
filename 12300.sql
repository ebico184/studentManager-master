drop database if exists stumanager;
create database stumanager;
use stumanager;

create table admin
(
	id int auto_increment comment '管理员id'
		primary key,
	username varchar(20) null comment '管理员账号',
	name varchar(20) null comment '管理员姓名',
	password varchar(20) null comment '密码'
)
;

create table course
(
	id int auto_increment comment '课程Id'
		primary key,
	name varchar(20) null comment '课程名称',
	courseType int null comment '课程类型',
	score varchar(20) null comment '课程学分'
)
;

create index FK_CourseType
	on course (courseType)
;

create table coursetype
(
	id int auto_increment comment '类型id'
		primary key,
	name varchar(20) null comment '类型名称'
)
;

alter table course
	add constraint FK_CourseType
		foreign key (courseType) references coursetype (id)
			on update cascade on delete cascade
;

create table stu_course
(
	id int auto_increment comment '选课Id'
		primary key,
	student_id int null comment '学生id',
	course_id int null comment '课程Id',
	score int null comment '课程成绩',
	constraint FK_CourseId
		foreign key (course_id) references course (id)
			on update cascade on delete cascade
)
;

create index FK_CourseId
	on stu_course (course_id)
;

create index FK_StudentId_course
	on stu_course (student_id)
;

create table student
(
	id int auto_increment comment '学生id'
		primary key,
	name varchar(20) null comment '学生姓名',
	idcard varchar(20) null comment '身份证',
	sex varchar(10) null comment '性别',
	phone varchar(20) null comment '电话',
	qq varchar(20) null comment 'QQ',
	email varchar(50) null comment '邮箱',
	address varchar(50) null comment '家庭住址',
	reset varchar(11) default '0' null comment '修改密码标志'
)
;

alter table stu_course
	add constraint FK_StudentId_course
		foreign key (student_id) references student (id)
			on update cascade on delete cascade
;

create table teacher
(
	id int auto_increment
		primary key,
	t_name varchar(50) not null comment '教师姓名',
	gender varchar(20) null comment '性别',
	phone_number varchar(20) null comment '电话号码',
	address varchar(50) null comment '地址',
	professional_title varchar(50) null comment '职称',
	constraint teacher_id_uindex
		unique (id)
)
;

create table user
(
	id int auto_increment comment '用户id'
		primary key,
	username varchar(20) null comment '用户名',
	password varchar(20) null comment '密码',
	stuId int null comment '学生id',
	constraint FK_StudentId_user
		foreign key (stuId) references student (id)
			on update cascade on delete cascade
)
;

create index FK_StudentId_user
	on user (stuId)
;

