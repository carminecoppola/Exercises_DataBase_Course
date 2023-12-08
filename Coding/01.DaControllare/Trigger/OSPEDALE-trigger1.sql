/*  Un medico può partecipare ad un intervento solo se ha già effettuato altri due interventi 
    dello stesso tipo oppure almeno uno degli altri medici coinvolti nello stesso intervento ha
    già effettuato altri due interventi dello stesso tipo. 
    Egli NON può svolgere più di 3 interventi nello stesso giorno. 
    Eccezioni: 
        unexperienced_doctor, unexperienced_team, doctor_overloaded.   
*/

create or replace trigger controlloMedici before insert on effettua
for each row
declare
	
    num_int					      number(2,0);
	tipo_int				      number(2,0);
  
	unexperienced_doctor	EXCEPTION;
	unexperienced_team		EXCEPTION;
	doctor_overloaded		  EXCEPTION;   

begin


   	select 	count(*)
    into 	tipo_int
   	from	persona p join medico m on p.cf = m.cf
    			      join effettua e on m.cf = e.cf_med
				      join intervento i on e.id_int = i.id
	where exists (  select  1
    		   		from    effettua e1 join intervento i1 on e1.id_int = i1.id
    		   		where   e.cf_med = e1.cf_med AND i.tipo = i1.tipo
			   		having count(*) > 2
    		 	 );

    IF tipo_int > 1 THEN
        raise unexperienced_doctor;
	END IF;


	select 	count(*)
    into	num_int
    from	medico m join effettua e on m.cf=e.cf_med
    				 join intervento i on e.id_int = i.id
    WHERE   e.cf_med = :NEW.cf_med 
    AND i.data_e_ora = (SELECT  i.data_e_ora
                        FROM 	intervento i
                        WHERE 	i.id = :NEW.id_int);



	IF num_int > 2 THEN
        raise doctor_overloaded;
	END IF;

    

    EXCEPTION
    	when unexperienced_doctor then
    		raise_application_error('-20001','unexperienced_doctor:');
		when unexperienced_team then
    		raise_application_error('-20002','unexperienced_team:');
		when doctor_overloaded then
    		raise_application_error('-20003','doctor_overloaded:');
    
end;

