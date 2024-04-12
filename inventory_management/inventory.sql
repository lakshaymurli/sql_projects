create database inventory;

use inventory;

--supplier table

create table supplier
(sid char(5) primary key,
sname varchar(30) not null,
sadd varchar(30) not null,
scity varchar(20) default 'Delhi',
sphone char(15) unique,
email varchar(30));

select * from supplier;

--product table

create table product
(pid char(5) primary key,
pdesc varchar(30) not null,
price int check (price>0),
category char(2) check (category in ('IT','HA','HC')),
sid char(5) references supplier(sid));


select * from product;

--stock table

create table stock
(pid char(5) references product(pid),
sqty int check (sqty>=0),
rol int check (rol>0),
moq int check (moq>=5));

select * from stock;

--customer table

create table cust
(cid char(5) primary key,
cname varchar(30) not null,
address varchar(30) not null,
city varchar(20) not null,
phone char(15) not null,
email varchar(30) not null,
dob date check (dob<'2000-01-01'));

select * from cust;

--orders table

create table orders
(oid char(5) primary key,
odate date,
pid char(5) references product(pid),
cid char(5) references cust(cid),
oqty int check (oqty>=1));


select * from orders;

insert into supplier(sid,sname,sadd,sphone,email)
values('S0001','Shubham Kumar','A-Block,Janakpuri','9899958404','shubham.kumar@gmail.com');

insert into supplier(sid,sname,sadd,sphone,email)
values('S0002','Rajat Kapoor','C-Block,Janakpuri','9891894436','krajat@yahoo.com');

insert into supplier
values('S0003','Rajveer Singh','Sky View Appts','Bengaluru','8595763010','rajveersingh87@gmail.com');

insert into supplier
values('S0004','Ashok Jain','Banjara Hills','Hyderabad','8810809956','ashokjain@gmail.com');

insert into supplier
values('S0005','Garv Ahluwalia','Anjanapura','Bengaluru','9910608558','gwalia@gmail.com');

insert into supplier
values('S0006','Aman Kapoor','Krishnagiri','Tamil Nadu','8899103966','akapoor@yahoo.com');

insert into supplier(sid,sname,sadd,sphone,email)
values('S0007','Arshil Khan','Vasant Kunj','9991088995','ak.arshilkhan@yahoo.com');

insert into supplier(sid,sname,sadd,sphone,email)
values('S0008','Vikas Gulia','Model Town','9988106655','vgulia95@gmail.com');

insert into supplier(sid,sname,sadd,sphone,email)
values('S0009','Mayank Gahlot','Bannerghatta Road','Bengaluru','8595866660','gahlotmayank@gmail.com');

insert into supplier(sid,sname,sadd,sphone,email)
values('S0010','Shobhit Nirwan','Sec-34,Noida','8195392377','shobhitn89@gmail.com');

--delete from supplier
--where sid='S0003';

insert into product(pid,pdesc,price,category,sid)
values('P0001','Pollution Mask',75,'HC','S0008');

--delete from product
--where pid='P0001';

insert into product(pid,pdesc,price,category,sid)
values('P0002','Keyboard',2500,'IT','S0009');

insert into product(pid,pdesc,price,category,sid)
values('P0003','Pen Drive',4000,'IT','S0001');

insert into product(pid,pdesc,price,category,sid)
values('P0004','Refrigerator',18000,'HA','S0005');

insert into product(pid,pdesc,price,category,sid)
values('P0005','Microwave',3200,'HA','S0006');

insert into product(pid,pdesc,price,category,sid)
values('P0006','Mouse',2800,'IT','S0010');

insert into product(pid,pdesc,price,category,sid)
values('P0007','Hard Disk',5000,'IT','S0009');

insert into product(pid,pdesc,price,category,sid)
values('P0008','Syringes',1200,'HC','S0008');

insert into product(pid,pdesc,price,category,sid)
values('P0009','Antiseptic Liquid',50,'HC','S0004');

insert into product(pid,pdesc,price,category,sid)
values('P0010','Water Heater',1200,'HA','S0006');

insert into product(pid,pdesc,price,category,sid)
values('P0011','Multivitamin Tablets',430,'HC','S0002');

insert into product(pid,pdesc,price,category,sid)
values('P0012','Calcium Tablets',380,'HC','S0002');

insert into product(pid,pdesc,price,category,sid)
values('P0013','Iphone 15',60000,'IT','S0004');

insert into product(pid,pdesc,price,category,sid)
values('P0014','Earphones',4500,'IT','S0007');

insert into product(pid,pdesc,price,category,sid)
values('P0015','Airfryer',2800,'HA','S0007');

insert into stock(pid,sqty,rol,moq)
values('P0011',35,5,15);

insert into stock
values('P0007',50,12,25);

insert into stock
values('P0001',100,25,50);

insert into stock
values('P0004',30,8,15);

insert into stock
values('P0008',500,150,250);

insert into stock
values('P0013',250,25,175);

insert into stock
values('P0010',200,50,80);

insert into stock
values('P0005',300,10,150);

insert into stock
values('P0003',1000,550,800);

insert into stock
values('P0015',150,50,75);

--drop table supplier;

insert into cust(cid,cname,address,city,phone,email,dob)
values('C0001','Abhishek Jain','Basavanagudi','Bengaluru','8509174474','abhi.jain96@gmail.com','1996-06-09');

insert into cust
values('C0002','Amit Kumar Verma','Defence Colony','Delhi','9009648499','amitverma@yahoo.com','1985-10-15');

insert into cust
values('C0003','Avinash Patil','East Of Kailash','Delhi','8386489686','avipatil98@gmail.com','1998-09-18');

insert into cust
values('C0004','Nameera Khan','Badshahpur','Haryana','7527809189','nameerak@yahoo.com','1999-01-01');

insert into cust
values('C0005','Partha Pratim Das','Kalkaji','Delhi','9236315415','pratimdas95@gmail.com','1995-11-05');

insert into cust
values('C0006','Sanket Maity','Dhankot','Haryana','8819052944','smaity.76@yahoo.com','1976-06-28');

insert into cust
values('C0007','Ansh Gupta','Chandapura','Bengaluru','9708729721','gupta.ansh@gmail.com','1991-04-24');

insert into cust
values('C0008','Nuaa Rawat','Farrukh Nagar','Haryana','8215961141','nuaarawat@gmail.com','1994-08-03');

insert into cust
values('C0009','Monika Saini','Lodi Road','Delhi','9916141251','saini.monika@gmail.com','1989-07-26');

insert into cust
values('C0010','Ashwarya','Ankushapur','Hyderabad','9791919267','ash.85@gmail.com','1985-05-11');

insert into orders(oid,odate,pid,cid,oqty)
values('O0001','2021-09-18','P0013','C0008',1);

insert into orders
values('O0002','2023-10-01','P0009','C0003',12);

insert into orders
values('O0003','2018-08-10','P0007','C0005',2);

insert into orders
values('O0004','2019-11-24','P0009','C0003',15);

insert into orders
values('O0005','2014-02-21','P0008','C0010',28);

--q1

select pid,pdesc,category,sname,scity 
from product as p1
join supplier as s1
on p1.sid=s1.sid;

--q2

select oid,odate,cname,address as 'caddress',phone as 'cphone',pdesc,price,oqty,(price*oqty) as 'amt'
from orders as o1
join cust as c1
on o1.cid=c1.cid
join product as p1
on p1.pid=o1.pid;

create view bill 
as
select o.oid,o.odate, c.cname, c.address, c.phone, p.pdesc, p.price, o.oqty,( p.price * o.oqty) as 'amount'
from orders as o
join cust as c 
on o.cid = c.cid
join product as p 
on o.pid = p.pid;

select * from bill;


select oid, odate, cname, address, phone, pdesc, price, oqty,( price * oqty) as 'amount'
from orders 
join cust  
on orders.cid = cust.cid
join product  
on orders.pid = product.pid;

--assignment 8

create procedure addsupplier @id as char(5), @n as varchar(30), @adr as varchar(30), @c as varchar(30), @ph as char(15), @em as varchar(30)
as
begin
	insert into supplier
	values(@id, @n ,@adr, @c, @ph, @em);

	select * from supplier where sid = @id;
end;

addsupplier 'S0011', 'Abhilash Garg', 'Sec-22,Gurgaon', 'Gurgaon', '9999167998', 'ab.garg@gmail.com';

delete from supplier
where sid='S0011';

--drop procedure addsupplier;

select * from supplier;

--assignment 9

create sequence sseq
as int
start with 11
increment by 1;

--drop sequence sseq;

select next value for sseq;

create procedure addsupplier @sn as varchar(30), @adr as varchar(30), @c as varchar(30), @ph as char(15), @em as varchar(30)
as
begin
	declare @i as int;
	declare @id as char(5);
	set @i = (next value for sseq);
	
	set @id = dbo.supp_id ('s', @i);
	
	insert into supplier
	values(@id, @sn, @adr, @c, @ph, @em);

	select * from supplier;
end;

--drop function supp_id;

create function supp_id (@s as char(1), @i as int)
returns char(5)
as
begin
	declare @id as char(5);
	    if @i < 100
		set @id = concat(@s,'00', @i);
	else if @i < 1000
		set @id = concat(@s,'0', @i);
	else if @i < 10000
		set @id = concat(@s, @i);
	else
		set @id = 'na';
	return @id;
end;

addsupplier 'Abhilash Garg', 'Sec-22,Gurgaon', 'Gurgaon', '9999167998', 'ab.garg@gmail.com';

create sequence pseq
as int
start with 16
increment by 1;

create procedure addpro @pd as varchar(30), @p as int, @c as char(2), @sid as char(5)
as
begin
	declare @i as int;
	declare @id as char(5);
	set @i = (next value for pseq);
	
	set @id = dbo.prod_id ('p', @i);
	
	insert into product
	values(@id, @pd, @p, @c, @sid);

	select * from product;
end;

--drop function prod_id;

create function prod_id (@p as char(1), @i as int)
returns char(5)
as
begin
	declare @id as char(5);
	    if @i < 100
		set @id = concat(@p,'00', @i);
	else if @i < 1000
		set @id = concat(@p,'0', @i);
	else if @i < 10000
		set @id = concat(@p, @i);
	else
		set @id = 'na';
	return @id;
end;

addpro 'Hard Disk 2TB', 8000, 'IT', 'S0001';


create sequence cseq
as int
start with 11
increment by 1;

--drop sequence cseq;

create procedure addcust @cn as varchar(30), @adr as varchar(30), @c as varchar(30), @ph as char(15), @em as varchar(30), @db as date
as
begin
	declare @i as int;
	declare @id as char(5);
	set @i = (next value for cseq);
	
	set @id = dbo.cust_id ('c', @i);
	
	insert into cust
	values(@id, @cn, @adr, @c, @ph, @em, @db);

	select * from cust;
end;

--drop procedure addcust;

create function cust_id (@c as char(1), @i as int)
returns char(5)
as
begin
	declare @id as char(5);
	     if @i < 10
		set @id = concat(@c,'000', @i);
    else if @i < 100
		set @id = concat(@c,'00', @i);
	else if @i < 1000
		set @id = concat(@c,'0', @i);
	else if @i < 10000
		set @id = concat(@c, @i);
	else
		set @id = 'na';
	return @id;
end;

--drop function cust_id;

addcust 'Ranvijay Singh', 'Gurgaon', 'Haryana', '9899911188', 'ranvjsingh@gmail.com', '1999-02-18';

--delete from cust
--where cid='na';

create sequence oseq
as int
start with 6
increment by 1;

--drop sequence cseq;

create procedure addorder @pid as char(5), @cid as char(5), @oqt as int
as
begin
    declare @od as date = getdate();
	declare @i as int;
	declare @id as char(5);
	set @i = (next value for oseq);
	
	set @id = dbo.order_id ('o', @i);
	
	insert into orders
	values(@id, @od, @pid, @cid, @oqt);

	select * from orders;
end;

--drop procedure addorder;

create function order_id (@o as char(1), @i as int)
returns char(5)
as
begin
	declare @id as char(5);
	     if @i < 10
		set @id = concat(@o,'000', @i);
    else if @i < 100
		set @id = concat(@o,'00', @i);
	else if @i < 1000
		set @id = concat(@o,'0', @i);
	else if @i < 10000
		set @id = concat(@o, @i);
	else
		set @id = 'na';
	return @id;
end;

addorder 'P0006', 'C0004', 10;

---------

create table purchase(pid char(5),sid char(5), pqty int, dop date not null);

alter table purchase
add constraint fk_pid foreign key (pid) references product(pid);

alter table purchase
add constraint fk_sid foreign key (sid) references supplier(sid);


select * from orders;

select * from stock;

select * from purchase;

--update stock set sqty=20
--where pid='P0004';

create trigger inventory_check
on orders
for insert
as
begin
	declare @qr as int;
	declare @qs as int;
	declare @rol as int;
	declare @pqty as int;
	declare @pid as char(5);
	declare @sid as char(5);
	declare @dop as date;

	set @qr= (select oqty from inserted);
	set @qs=(select sqty from stock where pid= (select pid from inserted));
	set @rol=(select rol from stock where pid=(select pid from inserted));
	set @pqty=(select moq from stock where pid=(select pid from inserted));
	set @pid= (select pid from inserted);
	set @sid= (select sid from products where pid =(select pid from inserted));
	set @dop =convert(varchar(10), getdate(), 111);

	if (@qs>=@qr)
		begin
			update stock set sqty= sqty-@qr
			where pid=(select pid from inserted)
	
			print('order accepted!!')
			if ((@qs-@qr)<@rol)
				begin
					insert into purchase
					values(@pid,@sid,@pqty,@dop);

					update stock set sqty=sqty+@pqty
					where pid=(select pid from inserted);

				end;
			commit;
		end;
	else
		begin
			rollback;
			print('insufficient quantity, order rejected.')
		end;
end;

--drop trigger inventory_check;

create trigger stock_update
on orders
for update
as
begin
	declare @oq as int;
	declare @nq as int;
	declare @qs as int;

	set @oq= (select oqty from deleted);
	set @nq= (select oqty from inserted);
	set @qs=(select sqty from stock where pid=(select pid from inserted));

	if (@qs>=@nq)
		begin
			update stock set sqty= sqty+@oq-@nq
			where pid= (select pid from inserted);
			commit;
			print('order updated successfully')
		end;
	else
		begin
			rollback;
			print('order rejected due to insufficient stock')
		end;
end;

--drop trigger stock_update;

update orders set oqty=10
where oid='O0001';



