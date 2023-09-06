drop database cteam;

create database cteam;

use cteam;

create table user
(
id varchar(20) primary key comment '���̵�',
pw varchar(200) comment '��й�ȣ',
name varchar(50) comment '�̸�',
nick varchar(6) comment '�г���',
team varchar(4) comment '��',
position varchar(3) comment '������',
email varchar(50) comment '�̸���',
joindate datetime default now() comment '��������',
userdiv varchar(1) comment 'ȸ������'
);

create table board
(
bno int primary key auto_increment comment '�۹�ȣ', 
btitle varchar(40) comment '����',
bnote text comment '����',
id varchar(20) comment '���̵�',
wdate datetime default now() comment '�ۼ���',
hit int default 0 comment '��ȸ��',
gcount int default 0 comment '��õ',
blcount int default 0 comment '�Ű�',
bfname varchar(200) comment '�����ϸ�',
bpname varchar(200) comment '�������ϸ�',
menu varchar(1) comment '�޴�',
youtube varchar(11) comment '������ID',
newslink varchar(100) comment '������ũ',
foreign key(id) references user(id)
);

create table reply
(
rno int primary key auto_increment comment '��۹�ȣ',
bno int comment '�Խù���ȣ',
id varchar(20) comment '�ۼ��� ���̵�',
rnote text comment '��۳���',
rblcount int default 0 comment '��۽Ű�',
foreign key(id) references user(id),
foreign key(bno) references board(bno)
);

create table service
(
sno int primary key auto_increment comment '�Ű��ȣ',
id varchar(20) comment '���̵�',
sdiv varchar(1) comment '�Ű���',
bno int comment '�� ��ȣ',
rno int comment '��� ��ȣ',
foreign key(id) references user(id),
foreign key(bno) references board(bno),
foreign key(rno) references reply(rno)
);

create table chat
(
cno int primary key auto_increment comment 'ä�ù�ȣ',
id varchar(20) comment '���̵�',
cnote text comment 'ä�ó���',
foreign key(id) references user(id)
);
