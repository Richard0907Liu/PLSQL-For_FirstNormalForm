-- Create a procedure to process columns for neighborhoods.csv
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
                                                       
-- a)
-- it sends to the screen the whole information from the last column of NEIGH in a normalized format
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
            dbms_output.put_line(attr1 || ' '|| attr2 || ' ' || attr3 || ' ' 
                                || ' ' || attr4 || ' ' || attr5);
            if attr1 = 'Bronx CB 5'  -- hint if want to do all bourogh
            then 
                dbms_output.put_line(attr1 || ' '|| attr2 || ' ' || attr3 || ' ' 
                                      || ' ' || attr4 || ' ' || attr5);
                attr1 := substr(attr1, 0, instr(attr1, 'CB')-2);
                split_neighborhoods(attr1, attr5);
            else 
                dbms_output.put_line('Nothing');
            end if;
        else 
            exit;
        end if;
    end loop;
    close test;
end;
/

-- b)
-- it does not send the whole information to the screen  from the last column of NEIGH in a normalized format
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


create table BOROUGH_NEIGH (
    borough varchar(20),
    neigh varchar(400) 
)
/

-- c) 
select borough, neigh from borough_neigh;
/
