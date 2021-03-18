select * from rbs;
select * from tst;

select count(*) from rbs
where status=1 and seller<>'tkp_Tver';

select count(*) from rbs
where status=0 and seller='tkp_Tver';


select (select count(*) from rbs
where status=0 and seller='tkp_Tver') -
(select count(*) from rbs
where status=1 and seller<>'tkp_Tver')
from dual;

select count(ern) from rbs;
select count(distinct ern) from rbs;

select ern, terminal_date, count(*), avg(summ) as summ from rbs
group by ern, terminal_date
having sum(status)=0; --поиск транзакций, которые не завершены после доавторизатора

select round(sum(avg(summ)))from rbs
group by ern, terminal_date
having sum(status)=0; -- сумма всех незавершенных транзакций предыдущего запроса

select max(length(ern)) from tst;

select (to_date('01-01-2019 14:24:20', 'DD-MM-YYYY HH24:MI:SS') - to_date('01-01-2019 14:24:18', 'DD-MM-YYYY HH24:MI:SS'))* (24*60*60) from dual;

select t.ern as ERN_TST, r.ern as ERN_RBS, to_char(t.transaction_datetime, 'DD-MON-YYYY HH24:MI:SS') as DATE_TST,
to_char(r.terminal_date, 'DD-MON-YYYY HH24:MI:SS') as DATE_RBS, t.sumpurse,
round((t.transaction_datetime - r.terminal_date)*(24*60*60)) as tt  from tst t
left join rbs r on instr(r.ern, t.ern)=1 and t.transaction_datetime - r.terminal_date between -0.00002 and 0.00002;


--insert into TST_RBS
select t.ern as ERN_TST, r.ern as ERN_RBS, to_char(t.transaction_datetime, 'DD-MON-YYYY HH24:MI:SS') as DATE_TST,
to_char(r.terminal_date, 'DD-MON-YYYY HH24:MI:SS') as DATE_RBS, t.sumpurse,
round((t.transaction_datetime - r.terminal_date)*(24*60*60)) as tt  from tst t
left join rbs r on instr(r.ern, t.ern)=1 and t.transaction_datetime - r.terminal_date between -0.00002 and 0.00002;

select * from tst;