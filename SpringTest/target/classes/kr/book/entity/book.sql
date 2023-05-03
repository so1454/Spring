create table book(
	num int auto_increment primary key,
	title varchar(50) not null unique,
	author varchar(30) not null ,
	company varchar(50) not null,
	lsbn varchar(30) not null ,
	count int not null
);


insert into book(title, author,company,lsbn,count)
values('스프링','구소현','smhrd','9999999',10);
insert into book(title, author,company,lsbn,count)
values('JSP','가소현','smhrd1','8888888',5);
insert into book(title, author,company,lsbn,count)
values('파이썬','나소현','smhrd2','777777',4);
insert into book(title, author,company,lsbn,count)
values('C++','다소현','smhrd3','5555555',11);
insert into book(title, author,company,lsbn,count)
values('Java','라소현','smhrd4','222222',6);

select * from book order by num desc ;


select * from book;