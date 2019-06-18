drop table borough_neigh;
/

-- HW2 begining

select unique dfta.program_borough as Neighborhood, 
substr(neigh.community_board, 0, instr(community_board, 'CB') -2) as borough  
from neigh inner join dfta on neigh.neighborhoods 
like ('%' || dfta.program_borough || '%');



-- list board and neighborhoods
begin 
    for counter in (select * from neigh)
    loop
        dbms_output.put_line(counter.community_board ||' '||counter.neighborhoods);
    end loop;
end;
/


--  a) modified above, get more precise name

begin 
    for counter in (select * from neigh)
    loop
        dbms_output.put_line(
        substr(counter.community_board, 0, 
            instr(counter.community_board, 'CB')-2)  ||' '||
        substr(counter.neighborhoods, 0, instr(counter.neighborhoods, ',')-1));  
    end loop;
end;
/


-- b)
declare
    attr1 varchar(20); attr2 varchar(10); attr3 varchar(10);
    attr4 varchar(10); attr5 varchar(400);
    cursor test is select * from neigh;
begin
    open test;
    loop
        fetch test into attr1, attr2, attr3, attr4, attr5;
        if test%found
        then      
            --dbms_output.put_line(attr1 || ' '|| attr2 || ' ' || attr3 || ' ' 
            --                    || ' ' || attr4 || ' ' || attr5);
            --if attr1 = 'Bronx CB 5'  -- hint if want to do all bourogh
            --then 
                --dbms_output.put_line(attr1 || ' '|| attr2 || ' ' || attr3 || ' ' 
                --                      || ' ' || attr4 || ' ' || attr5);
                attr1 := substr(attr1, 0, instr(attr1, 'CB')-2);
                split_neighborhoods(attr1, attr5);
            --else 
                --dbms_output.put_line('Nothing');
            --end if;
        else 
            exit;
        end if;
    end loop;
    close test;
end;
/


-- c)

declare
    attr1 varchar(20); attr2 varchar(10); attr3 varchar(10);
    attr4 varchar(10); attr5 varchar(400);
    cursor test is select * from neigh;
begin
    open test;
    loop
        fetch test into attr1, attr2, attr3, attr4, attr5;
        if test%found
        then      
                attr1 := substr(attr1, 0, instr(attr1, 'CB')-2);
                split_neighborhoods(attr1, attr5);
        else 
            exit;
        end if;
    end loop;
    close test;
end;
/
-- create a procedure to process column
create or replace procedure split_neighborhoods(CB in varchar2, neighborhoods in varchar2)
as 
    pre_split varchar2(400);
    single_neigh varchar2(60);
    from_ number;
    comma_site number;
    len number;
begin
    len := length(neighborhoods);
    --dbms_output.put_line('String showed in the procedure split_neighborhoods, number of words: ' || len );
    --dbms_output.put_line(neighborhoods);
             
    from_ := 0;
    pre_split := neighborhoods;
    loop
        pre_split := substr(pre_split, from_, len);
        comma_site := instr(pre_split, ',');
        if comma_site =0
        then 
            single_neigh := substr(pre_split,0, length(pre_split));
            dbms_output.put_line(CB ||'     '|| single_neigh);
            
            insert into borough_neigh values(CB, single_neigh); -- e) insert new valures
            
            exit;
        else
            single_neigh := substr(pre_split, 0, comma_site-1);
            dbms_output.put_line(CB ||'     '|| single_neigh);
            
             insert into borough_neigh values(CB, single_neigh); -- e) insert new valures
            
        end if;
        from_ := comma_site+2;
        
    end loop;
end;
/

create table BOROUGH_NEIGH (
    borough varchar(20),
    neigh varchar(400) 
)
/

-- e) 
select borough, neigh from borough_neigh;
/

-- 3) Create a trigger TZNUMBERS
/*
create or replace trigger TZNUMBERS 
before insert on ZNUMBERS
for each row
begin
    dbms_output.put_line(:new.B);
end;
/
*/


--insert into ZNUMBERS (B) values (51);
--delete znumbers where B= 53;

/*
declare
    insert_num number;
    total_num number;
begin
    for insert_num in 51.. 53
    loop
        insert into ZNUMBERS (B) values (insert_num);
        total_num := 0;
        for counter in (select * from znumbers)
        loop   
            total_num := total_num + counter.b;
        end loop;
        dbms_output.put_line('Total number of B: ' || total_num);
    end loop;
end;
/
*/

-- 4) 
-- a)
Create type HORSE as object(
    Size1 number,
    Weight number,
    Color varchar2(30),
    MaximumSpeed number
)
/
-- b)
create table THEHORSES (
    AHORSE HORSE
)
/

-- c)

insert into THEHORSES values(HORSE(63, 800, 'brown', 20));
insert into THEHORSES values(HORSE(65, 880, 'black', 23));
insert into THEHORSES values(HORSE(59, 770, 'white', 18));


select AHORSE from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.Size1 from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.Weight from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.Color from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.MaximumSpeed from thehorses a where a.ahorse.Size1 = 63;

select AHORSE from thehorses a where a.ahorse.Size1 = 65;
select a.AHORSE.Size1 from thehorses a where a.ahorse.Size1 = 65;
select a.AHORSE.Weight from thehorses a where a.ahorse.Size1 = 65;
select a.AHORSE.Color from thehorses a where a.ahorse.Size1 = 65;
select a.AHORSE.MaximumSpeed from thehorses a where a.ahorse.Size1 = 65;

select AHORSE from thehorses a where a.ahorse.Size1 = 59;
select a.AHORSE.Size1 from thehorses a where a.ahorse.Size1 = 59;
select a.AHORSE.Weight from thehorses a where a.ahorse.Size1 = 59;
select a.AHORSE.Color from thehorses a where a.ahorse.Size1 = 59;
select a.AHORSE.MaximumSpeed from thehorses a where a.ahorse.Size1 = 59;

--select * from user_objects;
select a.ahorse from thehorses a ;

select AHORSE from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.Weight from thehorses a where a.ahorse.Size1 = 63;
select a.AHORSE.Weight from thehorses a;

