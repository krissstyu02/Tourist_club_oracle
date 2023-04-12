--1)Получить список и общее число туристов, 
--занимающихся в клубе, в указанной секции, группе, по половому признаку, году рождения, возрасту.

--в клубе
select  fio,COUNT(*) OVER() as "Count tourists" 
from tourist;

--в секции 1
select  distinct fio,direction 
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание';

select  direction, count(*) 
from (select  distinct fio,direction 
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание')
group by  direction;

-- в группе
select   fio,tm.name,COUNT(*) OVER() as "Count" 
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='лыжи1';

--по половому признаку

select  fio,gender
from tourist tr;

select  gender, count(*) 
from (select  fio,gender
from tourist tr)
group by  gender;


--год рождения
select  fio,extract(year from  tr.birthday_date)
from tourist tr;


select  extract(year from  birthday_date), count(*) 
from (select  fio,extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr)
group by  extract(year from  birthday_date);


--возраст

select  fio,2023-extract(year from  tr.birthday_date)
from tourist tr;

select  2023-extract(year from  birthday_date), count(*) 
from (select  fio,2023-extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr)
group by  2023-extract(year from  birthday_date);


--3)Получить перечень и общее число соревнований, в которых участвовали спортсмены из указанной секции, по всем секциям.
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

--2)Получить список и общее число тренеров указанной секции,
--по всем секциям, по половому признаку, по возрасту, по размеру заработной платы, специализации.

--указанная секция
select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section 
and sc.direction='плавание';

select  direction, count(*) 
from (select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section
and sc.direction='плавание')
group by  direction;


--по всем секциям
select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section ;

select  direction, count(*) 
from (select  DISTINCT fio, sc.direction
from tourist tr, tourist_group tg, team tm,section sc,trainer tra
where tra.id_tourist=tr.id_tourist and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section)
group by  direction;


--по половому признаку

select   fio,gender
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist ;

select  gender, count(*) as count
from (select   fio,gender
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by gender;

--возраст

select  fio,2023-extract(year from  tr.birthday_date)
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist;

select  2023-extract(year from  birthday_date) , count(*) as count
from (select  fio,2023-extract(year from  tr.birthday_date),tr.birthday_date
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by 2023-extract(year from  birthday_date);



--зп

select  fio, SUM(s) 
from (select  fio,salary*hours as s
from tourist tr, trainer tra,load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load )
group by fio;


--специализация
select  fio,tra.specialization
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist;

select  specialization , count(*) as count
from (select  fio,specialization
from tourist tr, trainer tra
where tra.id_tourist=tr.id_tourist )
group by specialization;


--4)Получить список тренеров, проводивших тренировки в указанной группе, за указанный период времени.
select  fio , tm.name,ls.date_lesson
from tourist tr, team tm,trainer tra,lesson ls
where tra.id_tourist=tr.id_tourist and ls.id_trainer=tra.id_trainer and ls.id_team=tm.id_team 
and ls.date_lesson >'10.01.23' and ls.date_lesson< '27.01.23' and tm.name='лыжи1' ;

--5)Получить список и общее число туристов из некоторой секции, группы, которые ходили в заданное количество походов, 
--ходили в указанный поход, ходили в поход в обозначенное время, ходили по определенному маршруту, 
--были в некоторой точке, имеют соответствующую категорию.

--в секции 

--список туристов которые ходили в 2 похода
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=2;

--число туристов которые ходили в 2 похода
select count(*) as count
from(
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=2);


-- указанный поход
--список
select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 ;
--количество
select count(*) as count
from(select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 );

--в обозначенное время 
--список
select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' ;
--количество
select count(*) as count
from(select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' );

--по определенному маршруту
--список
select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='Подмосковье.Лыжный' ;
--количество
select count(*) as count
from(select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='Подмосковье.Лыжный' );

--были в некоторой точке 
--список
select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' ;
--количество
select count(*) as count
from(select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' );

--имеет категорию 2
--список
select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and tr.dif_category=2  ;
--количество
select count(*) as count
from(select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm,section sc
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание'
and tr.dif_category=2  );



-- в группе

--список туристов которые ходили в 3 похода 
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='сноуборд1' 
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=3;

--число туристов которые ходили в 2 похода
select count(*) as count
from(
select fio,count as count_hike
from(select  fio , count(*) as count
from (select   DISTINCT fio,hk.id_hike
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='сноуборд1' 
and hk.id_tourist=tr.id_tourist ) 
group by fio) where count=3);


-- указанный поход
--список
select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1' 
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 ;
--количество
select count(*) as count
from(select   DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1' 
and hk.id_tourist=tr.id_tourist  and hk.id_hike=1 );

--в обозначенное время 
--список
select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23' ;
--количество
select count(*) as count
from(select  DISTINCT fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and h.date_hike >'11.01.23' and h.date_hike< '07.03.23'  );

--по определенному маршруту
--список
select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='Подмосковье.Лыжный' ;
--количество
select count(*) as count
from(select  DISTINCT fio,r.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and r.name='Подмосковье.Лыжный'  );

--были в некоторой точке 
--список
select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' ;
--количество
select count(*) as count
from(select  DISTINCT fio,c.location
from tourist tr, tourist_group tg, team tm,hike_tourist hk,hike h,route r,camp c
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and hk.id_tourist=tr.id_tourist  and h.id_hike=hk.id_hike and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' );

--имеет категорию 2
--список
select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and tr.dif_category=3  ;
--количество
select count(*) as count
from(select  DISTINCT fio,tr.dif_category
from tourist tr, tourist_group tg, team tm
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.name='сноуборд1'
and tr.dif_category=3 );

--6)Получить перечень руководителей секций полностью, 
--по размеру заработной платы, по году рождения, возрасту, году поступления на работу

--перечень руководителей
select  fio
from head_section  ;

--по зп
select  fio,salary
from head_section  ;

--год рождения
select  fio,extract(year from  birthday_date) as birthday_year
from head_section;

--возрасту
select  fio,2023-extract(year from  birthday_date) as age
from head_section;

--год поступления на работу
select  fio,date_start
from head_section;

--7)Получить нагрузку тренеров (вид занятий, количество часов), 
--ее объем по определенным видам занятий и общую нагрузку за указанный период времени для данного тренера 
--или указанной секции.

--нагрузка тренеров
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load;

--опр вид
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and l.type='поход 1 сл';

--за период для тренера 
select  fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and ld.date_est>='01.01.2023' 
and ld.id_trainer=1;

--для секции
select  DISTINCT fio,type,ld.hours
from tourist tr, trainer tra, load_trainer ld,load l,tourist_group tg, team tm,section sc
where tra.id_tourist=tr.id_tourist and ld.id_trainer=tra.id_trainer and l.id_load=ld.id_load and ld.date_est>='01.01.2023' 
and ld.id_trainer=1 and tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team 
and tm.id_section=sc.id_section and direction='сноуборд';

--8)Получить перечень и общее число маршрутов, по которым ходили туристы из указанной секции, 
--в обозначенный период времени, по которым водил свои группы данный инструктор,
--по которым прошло указанное количество групп.

--из секции список
select  DISTINCT r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='сноуборд'
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route;
--количество
select count(*) as count_route
from(select  DISTINCT r.name
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='сноуборд'
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route);

--в период времени
select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.date_hike>='11.01.23' and h.date_hike<'07.03.23';

select count(*) as count_time
from(select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.date_hike>='11.01.23' and h.date_hike<'07.03.23');

--конкретный инструктор
--список
select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.id_inst=2 ;
--количество
select count(*) as count_inst
from(select  DISTINCT r.name
from tourist tr,hike_tourist hk, hike h,route r
where  hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route
and h.id_inst=2 );

--указанное количество групп
--список
select name_route,count_team
from(
select name_route, count(*) as count_team
from(select DISTINCT  rt.name as name_route,tm.name
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route rt 
where  tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=rt.id_route)
group by name_route)
where count_team=7;

--количество
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

--9)Получить перечень и общее число маршрутов, которые проходят через некоторую точку,
--имеют длину больше указанной, могут удовлетворять заданной категории сложности.

--проходят через точку Лялин луг
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r,camp c
where  h.id_route=r.id_route and c.id_route=r.id_route
and  c.location='Лялин Луг' ;

--имеют длину больше указанной
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r
where  h.id_route=r.id_route and r.length>10;

--удовлетворяют категории сложности
select  DISTINCT r.name,COUNT(*) OVER() as "Count" 
from  hike h,route r
where  h.id_route=r.id_route and r.dif_level>=2;

--10)Получить перечень и общее число туристов из указанной секции, группы, которые могут ходить в указанные типы походов.

--в походы категории<3
--секция 
select  distinct fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3 ;

--количество
select  count(*) as count
from (select  distinct fio
from tourist tr, tourist_group tg, team tm,section sc,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team and tm.id_section=sc.id_section and direction='плавание' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3);

-- в группе
select  distinct fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='лыжи1' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3;

--количество
select  count(*) as count
from (select  distinct fio
from tourist tr, tourist_group tg, team tm,hike_tourist hk, hike h,route r
where tg.id_tourist=tr.id_tourist and tm.id_team=tg.id_team  and tm.name='лыжи1' 
and hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and h.id_route=r.id_route 
and tr.dif_category>r.dif_level and r.dif_level<3);

--11)Получить перечень и общее число инструкторов, инструкторов-спортсменов, инструкторов-тренеров, 
--которые имеют определенную категорию, которые ходили в указанное количество походов, 
--ходили в определенный поход, ходили по некоторому маршруту, были в указанной точке

--список инструкторов
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist;

--имеют категорию
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5;

--ходили в 2 похода
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst ) 
group by fio) where count=2;

--ходили в определенный поход
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=1 ;

--ходили по маршруту 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='Подмосковье.Лыжный' ;

--были в точке
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' ;

--инструкторы-спорстмены
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.ranking='спортсмен';

--имеют категорию
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5 and tr.ranking='спортсмен';

--ходили в 2 похода
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and tr.ranking='спортсмен' ) 
group by fio) where count=2 ;

--ходили в определенный поход
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=1 and tr.ranking='спортсмен';

--ходили по маршруту 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='Подмосковье.Полный' and tr.ranking='спортсмен';

--были в точке
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Лялин Луг' and tr.ranking='спортсмен';

--иснструкторы-тренеры
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.ranking='тренер';

--имеют категорию
select fio,COUNT(*) OVER() as "Count" 
from tourist tr, hike_instructor hk
where hk.id_tourist=tr.id_tourist and tr.dif_category=5 and tr.ranking='тренер';

--ходили в 2 похода
select fio,count as count_hike,COUNT(*) OVER() as "Count" 
from(select  fio , count(*) as count
from (select   DISTINCT fio,h.id_hike
from tourist tr, hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and tr.ranking='тренер' ) 
group by fio) where count=1 ;

--ходили в определенный поход
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and h.id_hike=3 and tr.ranking='тренер';

--ходили по маршруту 
select  DISTINCT tr.fio,COUNT(*) OVER() as "Count" 
from tourist tr,  hike_instructor hk,hike h,route r
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and r.name='Подмосковье.Лыжный' 
and tr.ranking='тренер';

--были в точке
select  DISTINCT tr.fio
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Тверь' and tr.ranking='тренер';

select count(*)
from tourist tr,  hike_instructor hk,hike h,route r,camp c
where hk.id_tourist=tr.id_tourist and h.id_inst=hk.id_inst and r.id_route=h.id_route and c.id_route=r.id_route 
and c.location='Тверь' and tr.ranking='тренер';

--12)Получить список туристов из указанной секции, группы, которые ходили в походы со своим тренером в качестве инструктора.

--cекция
select DISTINCT fio
from tourist tr, hike_tourist hk,hike h,tourist_group tg, team t,section sc
where hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and tr.id_tourist=tg.id_tourist and t.id_team=tg.id_team
and t.id_trainer=h.id_inst and t.id_section=sc.id_section and direction='плавание';


-- в группе
select DISTINCT fio
from tourist tr, hike_tourist hk,hike h,tourist_group tg, team t
where hk.id_tourist=tr.id_tourist and h.id_hike=hk.id_hike and tr.id_tourist=tg.id_tourist and t.id_team=tg.id_team
and t.id_trainer=h.id_inst and t.name='лыжи1';

--13)Получить список туристов из некоторой секции, группы, которые ходили по всем маршрутам, по указанным маршрутам.

--секция
--по указанному маршруту
select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='плавание' 
and r.name='Северо-Запад';

--количсетво маршрутов 
select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='плавание')
group by fio;
--По всем маршрутам
select fio,count(*) as count_route
from(select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, section s,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team and s.id_section=t.id_section
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and direction='плавание')
group by fio)
where count_route=5 group by fio;

--группа
--опр маршрут
select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t,hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and t.name='сноуборд1' 
and r.name='Северо-Запад';

--По всем маршрутам
select fio,count(*) as count_route
from(select fio, count(*) as count_route
from(select  DISTINCT fio,r.name
from tourist tr,tourist_group tg, team t, hike_tourist ht, hike h, route r
where tg.id_tourist=tr.id_tourist and t.id_team=tg.id_team 
and ht.id_tourist=tr.id_tourist and h.id_hike=ht.id_hike and r.id_route=h.id_route and t.name='сноуборд1')
group by fio)
where count_route=5 group by fio;





