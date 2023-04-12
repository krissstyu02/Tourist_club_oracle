--1)�������� ������ � ����� ����� ��������, 
--������������ � �����, � ��������� ������, ������, �� �������� ��������, ���� ��������, ��������.

--� �����
select  fio,COUNT(*) OVER() as "Count tourists" 
from tourist;

--� ������ 1
select  distinct fio,direction 
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������';

select  direction, count(*) 
from (select  distinct fio,direction 
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������')
group by  direction;

-- � ������
select   fio,tm.name,COUNT(*) OVER() as "Count" 
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='����1';

--�� �������� ��������

select  fio,gender
from tourist tr;

select  gender, count(*) 
from (select  fio,gender
from tourist tr)
group by  gender;


--��� ��������
select  fio,extract(year from  tr.birthday_date)
from tourist tr;


select  extract(year from  birthday_date), count(*) 
from (select  fio,extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr)
group by  extract(year from  birthday_date);


--�������

select  fio,2023-extract(year from  tr.birthday_date)
from tourist tr;

select  2023-extract(year from  birthday_date), count(*) 
from (select  fio,2023-extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr)
group by  2023-extract(year from  birthday_date);


--3)�������� �������� � ����� ����� ������������, � ������� ����������� ���������� �� ��������� ������, �� ���� �������.
select DISTINCT sc.direction,cp.type,cp.stage,cp.location
from tourist tr, tourist_group tg, team tm,section sc,sportsman sp,competition_sportcman cs, competition cp
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and sp.id_tourist=tr.id_tourist 
and cs.id_sportsman=sp.id_sportsman and cp.id_competition=cs.id_competition   ;

select  direction, count(*) 
from (select DISTINCT sc.direction,cp.type,cp.stage,cp.location
from tourist tr, tourist_group tg, team tm,section sc,sportsman sp,competition_sportcman cs, competition cp
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and sp.id_tourist=tr.id_tourist 
and cs.id_sportsman=sp.id_sportsman and cp.id_competition=cs.id_competition )
group by  direction;

--2)�������� ������ � ����� ����� �������� ��������� ������,
--�� ���� �������, �� �������� ��������, �� ��������, �� ������� ���������� �����, �������������.

--��������� ������
select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section 
and sc.direction='��������';

select  direction, count(*) 
from (select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section
and sc.direction='��������')
group by  direction;


--�� ���� �������
select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section ;

select  direction, count(*) 
from (select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section)
group by  direction;


--�� �������� ��������

select   fio,gender
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist ;

select  gender, count(*) as count
from (select   fio,gender
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by gender;

--�������

select  fio,2023-extract(year from  tr.birthday_date)
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist;

select  2023-extract(year from  birthday_date) , count(*) as count
from (select  fio,2023-extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by 2023-extract(year from  birthday_date);



--��

select  fio, SUM(s) 
from (select  fio,salary*hours as s
from tourist tr, trainer tra,load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load )
group by fio;


--�������������
select  fio,tra.specialization
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist;

select  specialization , count(*) as count
from (select  fio,specialization
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by specialization;


--4)�������� ������ ��������, ����������� ���������� � ��������� ������, �� ��������� ������ �������.
select  fio , tm.name,ls.date_lesson
from tourist tr, team tm,trainer tra,lesson ls
where tra.id_tourist=tr.id_tourist and ls.id_trainer=tra.id_trainer and ls.id_team=tm.id_team 
and ls.date_lesson >'10.01.23' and ls.date_lesson< '27.01.23' and tm.name='����1' ;

--5)�������� ������ � ����� ����� �������� �� ��������� ������, ������, ������� ������ � �������� ���������� �������, 
--������ � ��������� �����, ������ � ����� � ������������ �����, ������ �� ������������� ��������, 
--���� � ��������� �����, ����� ��������������� ���������.

--� ������ 

--������ �������� ������� ������ � 2 ������
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=2;

--����� �������� ������� ������ � 2 ������
select count(*) as count
from(
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=2);


-- ��������� �����
--������
select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 ;
--����������
select count(*) as count
from(select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 );

--� ������������ ����� 
--������
select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' ;
--����������
select count(*) as count
from(select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' );

--�� ������������� ��������
--������
select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='�����������.������' ;
--����������
select count(*) as count
from(select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='�����������.������' );

--���� � ��������� ����� 
--������
select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' ;
--����������
select count(*) as count
from(select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' );

--����� ��������� 2
--������
select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and tr.dif_category=2  ;
--����������
select count(*) as count
from(select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and tr.dif_category=2  );



-- � ������

--������ �������� ������� ������ � 3 ������ 
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='��������1' 
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=3;

--����� �������� ������� ������ � 2 ������
select count(*) as count
from(
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='��������1' 
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=3);


-- ��������� �����
--������
select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1' 
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 ;
--����������
select count(*) as count
from(select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1' 
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 );

--� ������������ ����� 
--������
select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' ;
--����������
select count(*) as count
from(select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23'  );

--�� ������������� ��������
--������
select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='�����������.������' ;
--����������
select count(*) as count
from(select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='�����������.������'  );

--���� � ��������� ����� 
--������
select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' ;
--����������
select count(*) as count
from(select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' );

--����� ��������� 2
--������
select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and tr.dif_category=3  ;
--����������
select count(*) as count
from(select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='��������1'
and tr.dif_category=3 );

--6)�������� �������� ������������� ������ ���������, 
--�� ������� ���������� �����, �� ���� ��������, ��������, ���� ����������� �� ������

--�������� �������������
select  fio
from head_section  ;

--�� ��
select  fio,salary
from head_section  ;

--��� ��������
select  fio,extract(year from  birthday_date) as birthday_year
from head_section;

--��������
select  fio,2023-extract(year from  birthday_date) as age
from head_section;

--��� ����������� �� ������
select  fio,date_start
from head_section;

--7)�������� �������� �������� (��� �������, ���������� �����), 
--�� ����� �� ������������ ����� ������� � ����� �������� �� ��������� ������ ������� ��� ������� ������� 
--��� ��������� ������.

--�������� ��������
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load;

--��� ���
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and l.type='����� 1 ��';

--�� ������ ��� ������� 
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and ld.date_est>='01.01.2023' 
and ld.id_trainer=1;

--��� ������
select  DISTINCT fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l,tourist_group tg, team tm,section sc
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and ld.date_est>='01.01.2023' 
and ld.id_trainer=1 and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team 
and tm.id_section=sc.id_section and direction='��������';

--8)�������� �������� � ����� ����� ���������, �� ������� ������ ������� �� ��������� ������, 
--� ������������ ������ �������, �� ������� ����� ���� ������ ������ ����������,
--�� ������� ������ ��������� ���������� �����.

--�� ������ ������
select  DISTINCT r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route;
--����������
select count(*) as count_route
from(select  DISTINCT r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������'
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route);

--� ������ �������
select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.date_hike>='11.01.23' and h.date_hike<'07.03.23';

select count(*) as count_time
from(select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.date_hike>='11.01.23' and h.date_hike<'07.03.23');

--���������� ����������
--������
select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.id_inst=2 ;
--����������
select count(*) as count_inst
from(select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.id_inst=2 );

--��������� ���������� �����
--������
select name_route,count_team
from(
select name_route, count(*) as count_team
from(select DISTINCT  rt.name as name_route,tm.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route rt 
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=rt.id_route)
group by name_route)
where count_team=7;

--����������
select count(*)
from(
select name_route,count_team
from(
select name_route, count(*) as count_team
from(select DISTINCT  rt.name as name_route,tm.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route rt 
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=rt.id_route)
group by name_route)
where count_team=7);

--9)�������� �������� � ����� ����� ���������, ������� �������� ����� ��������� �����,
--����� ����� ������ ���������, ����� ������������� �������� ��������� ���������.

--�������� ����� ����� ����� ���
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r,camp c
where  h.id_route=r.id_route and c.id_route=r.id_route
and  c.location='����� ���' ;

--����� ����� ������ ���������
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r
where  h.id_route=r.id_route and r.length>10;

--������������� ��������� ���������
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r
where  h.id_route=r.id_route and r.dif_level>=2;

--10)�������� �������� � ����� ����� �������� �� ��������� ������, ������, ������� ����� ������ � ��������� ���� �������.

--� ������ ���������<3
--������ 
select  distinct fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3 ;

--����������
select  count(*) as count
from (select  distinct fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='��������' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3);

-- � ������
select  distinct fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='����1' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3;

--����������
select  count(*) as count
from (select  distinct fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='����1' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3);

--11)�������� �������� � ����� ����� ������������, ������������-�����������, ������������-��������, 
--������� ����� ������������ ���������, ������� ������ � ��������� ���������� �������, 
--������ � ������������ �����, ������ �� ���������� ��������, ���� � ��������� �����

--������ ������������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist;

--����� ���������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5;

--������ � 2 ������
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst ) 
group by fio) where count=2;

--������ � ������������ �����
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=1 ;

--������ �� �������� 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='�����������.������' ;

--���� � �����
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' ;

--�����������-����������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.ranking='���������';

--����� ���������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5 and tr.ranking='���������';

--������ � 2 ������
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and tr.ranking='���������' ) 
group by fio) where count=2 ;

--������ � ������������ �����
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=1 and tr.ranking='���������';

--������ �� �������� 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='�����������.������' and tr.ranking='���������';

--���� � �����
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='����� ���' and tr.ranking='���������';

--������������-�������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.ranking='������';

--����� ���������
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5 and tr.ranking='������';

--������ � 2 ������
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and tr.ranking='������' ) 
group by fio) where count=1 ;

--������ � ������������ �����
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=3 and tr.ranking='������';

--������ �� �������� 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='�����������.������' 
and tr.ranking='������';

--���� � �����
select  DISTINCT tr.fio
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='�����' and tr.ranking='������';

select count(*)
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='�����' and tr.ranking='������';

--12)�������� ������ �������� �� ��������� ������, ������, ������� ������ � ������ �� ����� �������� � �������� �����������.

--c�����
select DISTINCT fio
from tourist tr, hike_tourist hk,hike h,tourist_group tg, team t,section sc
where hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and tr.id_tourist=tg.id_tourist and t.id_team=tg.id_team
and t.id_trainer=h.id_inst and t.id_section=sc.id_section and direction='��������';


-- � ������
select DISTINCT fio
from tourist tr, hike_tourist hk,hike h,tourist_group tg, team t
where hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and tr.id_tourist=tg.id_tourist and t.id_team=tg.id_team
and t.id_trainer=h.id_inst and t.name='����1';

--13)�������� ������ �������� �� ��������� ������, ������, ������� ������ �� ���� ���������, �� ��������� ���������.

--������
--�� ���������� ��������
select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='��������' 
and r.name='������-�����';

--���������� ��������� 
select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='��������')
group by fio;
--�� ���� ���������
select fio,count(*) as count_route
from(select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='��������')
group by fio)
where count_route=5 group by fio;

--������
--��� �������
select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and t.name='��������1' 
and r.name='������-�����';

--�� ���� ���������
select fio,count(*) as count_route
from(select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team 
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and t.name='��������1')
group by fio)
where count_route=5 group by fio;





