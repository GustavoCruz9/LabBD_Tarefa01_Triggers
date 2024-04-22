/*
use master
drop database Tarefa01_LabBD_Triggers
*/
create database Tarefa01_LabBD_Triggers
go
use Tarefa01_LabBD_Triggers
go
-- criar tabela times
create table times (
codtime int primary key,
nometime varchar(50) not null
);

-- criar tabela jogos
create table jogos (
codtimea int references times(codtime),
codtimeb int references times(codtime),
settimea int,
settimeb int
);

-- criar trigger para verificar os inserts dos sets
create trigger t_verificarinserts
before insert on jogos
begin
if (new.settimea > 3 or new.settimeb > 3)
begin
signal sqlstate '45000'
set message_text = 'o número máximo de sets é 3.';
end 

if (new.settimea = 3 and new.settimeb = 3)
begin
    signal sqlstate '45000'
    set message_text = 'apenas um time pode ter 3 sets.';
end

end

-- exemplo de inserção de dados nas tabelas
insert into times (nometime) values ('time 1'), ('time 2'), ('time 3'), ('time 4');
insert into jogos (codtimea, codtimeb, settimea, settimeb) values
(1, 2, 3, 2),
(3, 4, 3, 1),
(2, 3, 2, 3);






