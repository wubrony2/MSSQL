--單元一、建立資料庫
--一、 請將Schdb_1.mdf附加至執行個體(instance)中。請注意下列條件（5分)：1. 資料庫名稱『SchDB』
create database schDB on(name=a,filename='Schdb_1.mdf') for attach
--二、 請在該資料庫中新增1個檔案群組『G1』，並在該群組中新增1個資料檔『Schdb_2.ndf』，初始為20MB，自動成長50MB。（5分） 
alter database schDB add filegroup G1;alter database schDB add file (name=b,filename='C:\DB\Schdb_2.ndf',size=20MB,filegrowth=50mb) to filegroup G1
--三、『SchDB』資料庫關聯表(ERD)及作業需求如下：
alter table schDB..員工 alter column 身份證字號 char

alter table schDB..員工 add constraint b foreign key (身份證字號) references 教授
--單元二、基本查詢（單資料源）
select * from 員工
select * from 學生
select * from 課程
select * from 班級
--一、 查詢【學生】資料表的陳姓學生的學號、姓名和電話
use schDB
select 學號,姓名,電話 from 學生
--二、 計算每位員工的薪水淨額(收入-支出)，欄位需有名稱且計算至整數位

select cast(薪水-保險-扣稅 as int) '薪水淨額' from 員工
--三、 計算學生的年齡，若無資料請以『未提供』顯示
select ISNULL(cast(year(getdate())-YEAR(生日) as char),'未提供') '年齡' from 學生
--四、 找出薪水最高的前 3 名員工
select top(3) 姓名 from 員工 order by 薪水 desc
--五、 找出薪水最低的前10%名員工
select * from 員工 order by 薪水
select top 10 percent 姓名 from 員工 order by 薪水 
--六、 在【課程】資料表找出學分數最少的3筆課程記錄資料(含平手資料) 
select top 3 with ties * from 課程 ORDER BY 學分
--⬆只有顯示最低兩種學分的課程
select * from 課程 
--⬆此資料表只有三種學分數，故全部列出即可達到題目要求
select top 3 * from 課程 order by 學分 
--⬆如果只列三個資料的話
--七、在【學生】資料表找出所有女同學的資料。 
select * from 學生 where 性別 in ('女')
--八、 在【班級】資料表找出有幾位學生上CS203的課。
select * from 班級 order by 課程編號
select count(*) '位' from 班級 where 課程編號 in ('CS203')
--九、 在【班級】資料表找出教授 I002 共教幾門課。
select * from 班級 order by 教授編號
select count(*) '門' from 班級 where 教授編號 in ('I002')
--十、在【班級】資料表超過3位學生上課的課程。 
select 課程編號 from 班級  group by 課程編號 having count(*)>3
--十一、查詢【員工】資料表所有員工的保險總和與平均 
select sum(保險)'總和',avg(保險)'平均' from 員工
--十二、查詢【班級】資料表中，上課教室是在二樓的資料(教室第 2 碼代表樓層) 
select * from 班級 where 教室 like '_2%'
--十三、找出 1990年2月到1990年10月出生的學生 
select * from 學生 order by 生日
select * from 學生 where month(生日)>=2 and month(生日)<=10 and year(生日)=1990
