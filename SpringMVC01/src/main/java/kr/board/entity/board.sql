 -- 자동 증가조건
create table board(
   num int not null auto_increment,
   username varchar(100) not null,
   title varchar(100) not null,
   content varchar(2000) not null,
   writer varchar(100) not null,  
   indate datetime default now(),  --oracle의 sysdate랑 같은게 mysql now
   count int default 0,
   primary key(num)
);



drop table board;

insert into board(title, content, writer)
values('게시판 연습','게시판 연습','관리자');

insert into board(title, content, writer)
values('게시판 연습','게시판 연습','가나다');

insert into board(title, content, writer)
values('게시판 연습','게시판 연습','라마바');

select * from board;


create table Member(
	id int auto_increment primary key,
	username varchar(255) not null unique,
	password varchar(255) not null ,
	name varchar(255) not null,
	email varchar(255) not null unique
);



insert into Member(username,password,name,email)
values('smhrd01','12345','관리자','admin@naver.com');

insert into Member(username,password,name,email)
values('smhrd02','12345','감자','admin01@naver.com');

insert into Member(username,password,name,email)
values('smhrd03','12345','고구마','admin02@naver.com');

commit;
select * from Member;








