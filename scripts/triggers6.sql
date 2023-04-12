--триггеры
--добавление или изменение записей в таблице 

--проверка даты рождения руководителя секции
create or replace trigger HeadBirthdayy
    after insert or update on head_section
    for each row
begin 
    if :NEW.birthday_date > current_date
    then raise_application_error (-20001, 'No way!');
    end if;
end;

--проверка даты рождения туриста 
create or replace trigger TouristBirthdayy
    after insert or update on tourist
    for each row
begin 
    if :NEW.birthday_date > current_date
    then raise_application_error (-20001, 'No way!');
    end if;
end;

   
--триггер проверки категории сложности
create or replace trigger CheckCategoryy
    after insert or update on hike_tourist
    for each row
begin 
    for vv in (select  t.id_tourist as  cc from  tourist t, hike_tourist hk ,hike h,route r
    where hk.id_tourist=t.id_tourist and h.id_hike=hk.id_hike and r.id_route=h.id_route and  r.dif_level > t.dif_category)
    loop
    
    if vv.cc  is not null 
    then raise_application_error (-20001, 'No way!');
    end if;
    end loop;
end;

---в походе 5-15 человек
create or replace trigger CheckCountt
    after insert or update on hike_tourist
    for each row
begin 
    for vv in (select id_hike as cc from(select id_hike, count(*) as count_tourist from hike_tourist
    group by id_hike)
    where count_tourist>15)
    loop

    if vv.cc  is not null 
    then raise_application_error (-20001, 'No way!');
    end if;
    end loop;
end;

--проверка на уровень сложности у инструктора 
create or replace trigger CheckInstructorr
    after insert or update on hike_tourist
    for each row
begin 
    for vv in (select  t.id_tourist as  cc from  tourist t, hike_instructor hi ,hike h,route r
    where hi.id_tourist=t.id_tourist and h.id_inst=hi.id_inst and r.id_route=h.id_route and  r.dif_level > t.dif_category)
    loop
    
    if vv.cc  is not null 
    then raise_application_error (-20001, 'No way!');
    end if;
    end loop;
end;

---------------------------------------------------------------
--Процедуры
--по тренеру и нагрузке выводит количество часов 
create or replace function COUNT_HOUR(trainer in int, load in int)
return number is contype number;
cursor cont is 
 select hours from load_trainer where  id_load = load and id_trainer = trainer;
 begin 
 open cont;
 fetch cont into contype;
 close cont;
 return contype;
 EXCEPTION	 	 
WHEN OTHERS THEN	 	 
 raise_application_error(-20001,'An error was encountered: '||SQLCODE||' ERROR: '||SQLERRM);

 end;
 


