create table 訂單(
	訂單編號	int primary key,
	下單日期	datetime null default getdate(),
	客戶編號 nchar(3))
go
insert 訂單 values (1,'2023/10/14 14:53:53','C01')
insert 訂單 (訂單編號,客戶編號) values(2,'C01')
insert 訂單 values(3,default,'C01')
insert 訂單 values(4,null,'C01')
select * from 訂單
select GETDATE()
--unique設定，具有primary的特性，但允許一個null值
create table 客戶(客戶編號 int	primary key,
	身分證號	nchar(10) UNIQUE,
	地址	nvarchar(30),
	電話	nvarchar(15))go
--cheak設定，客戶資料表中地址與電話至少輸入一項
drop table 客戶
create table 客戶(客戶編號 int primary key,
	身分證號	nchar(10)unique,
	地址	nvarchar(30),
	電話	nvarchar(15))go
drop table 訂單
--foreign key設定
create table 訂單(訂單標號	int primary key,
	下單日期	datetime not null,
	客戶編號	int
	constraint a foreign key(客戶編號) references 客戶(客戶編號))go
drop table 客戶
select * from 客戶
select * from 訂單
insert 訂單 values(1,GETDATE(),3)
insert 訂單 values(2,GETDATE(),5)
delete 客戶 where 客戶編號=3
delete 客戶 where 客戶編號=1
--客戶地址長度改為50
alter table 客戶 alter column 地址 nvarchar(50)
--增加客戶名稱 nvarchar(30)
alter table 客戶 add 名稱 nvarchar(30)
--刪除名稱欄位
alter table 客戶 drop column 電話
--重建客戶資料表
create table 客戶(客戶編號 int IDENTITY ,
地址 nvarchar(50),
電話 nvarchar(15))

insert 客戶 values('黑鐵宮','00000000')
go 48763

select * from 客戶
--客戶資料表新增名稱欄位，字串長度為30，(且不允許null)
alter table 客戶 add 名稱 nvarchar(30)
--新增名稱欄位cheak條件約束，不允許null
alter table 客戶 with nocheck add constraint b check (名稱 is not null) 
insert 客戶 values('74層','487631016','桐人')
--新增資料為null時，則無法新增
insert 客戶 values ('無名','000000000',null)
--訊息 547，層級 16，狀態 0，行 57
--INSERT 陳述式與 CHECK 條件約束 "a" 衝突。衝突發生在資料庫 "master"，資料表 "dbo.客戶", column '名稱'。
--建立客戶資料的主鍵
alter table 客戶 add constraint s primary key (客戶編號)
--建立客戶與訂單的外來鍵

--2023年10月31號
--使用mydb資料庫：1.「客戶」資料表新增「手機」欄位：長度15
alter table 客戶 add 手機 nvarchar(30)
--2.「手機」欄位長度改為20
alter table 客戶 alter column 手機 nvarchar(20)
--3.變更地址欄位為not null
alter table 客戶 add constraint 地址 check (地址 is not null)
--4.原「ck_客戶_名稱」規則改為檢查地址與電話不可同時為null
alter table 客戶 with nocheck add constraint c check (地址 is not null or 電話 is not null)
--5.新增「備註」欄位，預設值「無」
alter table 客戶 add 備註 char default '無'
--重新建立「testdb」資料庫，該資料庫有2個檔案群組：Primary和G1；其中「primary」群組有2個資料檔，「G1」群組有1個資料檔，資料檔用預設值設定即可
create database testdb on (name=ㅤ,filename='ㅤ.db')
create database testdb on (name=a,filename='a.db') for attach
exec sp_detach_db testdb
--alter database testdb { (name=ㅤ,filename='C:\python_train\陳紀彰(資料庫)\ㅤㅤ.db') 
create database a on (filename='NorthwindC.mdf') for attach
use a
select * from 供應商
where 行政區 in ('台北','新竹','苗栗')
select 員工編號,姓名,isnull(相片,'ㅤ') ㅤ from 員工
select 員工編號,姓名,isnull(相片,'ㅤ') as ㅤ from 員工
select SUM(數量)'sum', COUNT(訂單號碼)'count',avg(數量)'avg',min(數量)'min',max(數量)'max' from a..訂貨明細 where 產品編號 in(51,52)
select SUM(數量)'sum', COUNT(訂單號碼)'count',avg(數量)'avg',min(數量)'min',max(數量)'max' from a..訂貨明細 where 產品編號=51
select 職稱,count(*) from a..員工 group by 職稱 having count(*)>4 
--group sets：使用者自行定義傳回哪些欄位的聚合統計資料(group by 欄位,小記欄位,總計)
select 產品編號,單價,sum(數量)[總數量] from a..訂貨明細 where 產品編號 in(50,51) group by GROUPING sets((產品編號,單價),產品編號)
select * from 訂貨主檔 order by 3
select top 3 with ties * from 訂貨主檔 order by 客戶編號
select * from a..訂貨主檔 cross join a..訂貨明細 
--請列出訂單10248、10249、10250的訂購產品名稱
use a
select 訂單號碼,產品 from 訂貨明細  join 產品資料 on  訂貨明細.產品編號=產品資料.產品編號 where 訂單號碼 in(10248,10249,10250) order by 1
--請統計第二銀行的消費金額
select sum(單價*數量*(1-折扣))'第二銀行有多盤' from 客戶 join 訂貨主檔  on 客戶.客戶編號=訂貨主檔.客戶編號 join 訂貨明細 on 訂貨主檔.訂單號碼=訂貨明細.訂單號碼 where 客戶.公司名稱='第二銀行'
--請列出每個業務的主管
select 員工.職稱,員工.姓名'主管' from 員工 as 主管id join 員工 on 主管id.主管=員工.員工編號 where 員工.職稱 like'%業務%' order by 1

use a

select * from 產品資料
select * from 產品類別
select * from 客戶 order by 1
select * from 訂貨主檔
select * from 訂貨明細
select * from 貨運公司
select count(select * from 貨運公司) from 貨運公司
--1.請提供台中市的供應商名稱、連絡人及連絡地址等資料
select 供應商 as 供應商名稱,連絡人,地址 as 連絡地址 from 供應商 where 城市 in ('台中市')
--2.請提供仍在銷售的飲料、日用品及特製品產品，其庫存量低於安全存量的產品
select 產品 from 產品資料 join 產品類別 on 產品資料.類別編號=產品類別.類別編號 where 產品類別.類別名稱 in ('飲料','日用品','特製品') and 產品資料.庫存量<=產品資料.安全存量 and 不再銷售=0 
--3.找出從沒有下過訂單的客戶
select * from 客戶 where 客戶編號 in (select 客戶編號 from 客戶 except select 客戶編號 from 訂貨主檔)
--4.屏東的電話為"08"，請找出電話錯誤的客戶連絡方式(含編號,公司名稱,連絡人,職稱,電話)
select 客戶編號 as '編號',公司名稱,連絡人,連絡人職稱 as '職稱',電話 from 客戶 where 城市 like '%屏東%' and not 電話 like '(08)%'  
--5.計算1997年每個客戶使用送貨方式為"郵寄"的次數，未使用過則為0(含未下訂單)
select 公司名稱,count(*) as 次數 from 客戶 join 訂貨主檔 on 客戶.客戶編號=訂貨主檔.客戶編號 join 貨運公司 on 訂貨主檔.送貨方式=貨運公司.貨運公司編號 where 貨運公司.貨運公司名稱='郵寄' and year(訂貨主檔.訂單日期)=1997 group by 公司名稱
select 公司名稱,(select count(*) from 客戶 join 訂貨主檔 on 客戶.客戶編號=訂貨主檔.客戶編號 join 貨運公司 on 訂貨主檔.送貨方式=貨運公司.貨運公司編號 where 貨運公司.貨運公司名稱='郵寄' and year(訂貨主檔.訂單日期)=1997) as 次數 from 客戶
select count(*) as 次數 from 客戶 join 訂貨主檔 on 客戶.客戶編號=訂貨主檔.客戶編號 join 貨運公司 on 訂貨主檔.送貨方式=貨運公司.貨運公司編號 where 貨運公司.貨運公司名稱='郵寄' and year(訂貨主檔.訂單日期)=1997
select 公司名稱,count(*) as 次數 from 客戶 join 訂貨主檔 on 客戶.客戶編號=訂貨主檔.客戶編號 group by 公司名稱
