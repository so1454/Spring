
-- 게시판 테이블
create table board(
   num int not null auto_increment,  -- 자동 증가조건
   username varchar(100) not null,
   title varchar(100) not null,
   content varchar(2000) not null,
   writer varchar(100) not null,  
   indate datetime default now(),  -- oracle의 sysdate랑 같은게 mysql now
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


-- 회원 로그인 테이블
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

-- 답변 테이블
create table reply(
   num int not null auto_increment,
   username varchar(100) not null,
   title varchar(100) not null,
   content varchar(2000) not null,
   writer varchar(100) not null,  
   indate datetime default now(),
   count int default 0,
   bgroup int, -- 원글(부모글)과 답글(자식글)을 하나로 묶는 필드
   bseq int , -- 답글의 순서 결정(시퀀스 bseq = 1)
   blevel int, -- 답글의 들여쓰기 = 대댓글 (blevel = 1 한번만 들여쓰기/2면 두번들여쓰기)
   bdelete int, -- 삭제 여부를 판단하는 필드( bdelete = 0 (정상글),bdelete = 1(원게시글이 삭제된 곳의 댓글 => 원글이 삭제된 게시글입니다 요런식으로 거기에 답글이 달린거) )
   primary key(num)
);

select * from reply;

select IFNULL(max(bgroup)+1, 0) as bgroup from reply;  -- 가장 큰값에 +1씩 해주기











