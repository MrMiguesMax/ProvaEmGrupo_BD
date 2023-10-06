-- Integrantes: André, Gabriel, Miguel

drop database if exists senai; -- Criado para fazer teste no codigo inteiro sem precisar de ir de linha a linha
create database senai; -- Criado para fazer teste no codigo inteiro sem precisar de ir de linha a linha
use senai; -- Usar banco.

create table disciplina(
sigla_disc varchar(5) primary key,
nome varchar(40) not null, -- nomes costumam ser grandes, e precisamos identificar pelo nome.
descricao text -- tipo texto utiliza menos mememoria e nao tem not null pois a descricao pode ser adicionada posteriormente.
);

create table professor(
id int not null,
nome varchar(40) not null, -- nomes costumam ser grandes, e precisamos identificar tambem pelo nome.
sigla_disc varchar(5) not null,
especialidade varchar(40) not null, -- tem not null, pois nao podemos deixar de identificar a especialidade/formacao de um professor.
data_adm date not null, -- Precisa ser criado como not null, pois, é de um uso federal.
constraint pk_professor primary key(id,sigla_disc), -- cria uma primary key dupla, podendo armazenar mais com valores semelhantes.

constraint fk_siglaDisc foreign key(sigla_disc) 
references disciplina(sigla_disc) on update cascade -- caso seja atualizado a sigla da disciplina, ja sera atualizado na tabela professor.
);

-- Inserts para Disciplina
INSERT INTO disciplina (sigla_disc, nome, descricao)
VALUES
    ('PWBE', 'Programação Web para Back-End', 'Tal disciplina aborda conceitos e técnicas para desenvolvimento de aplicativos web no lado do servidor, com foco em back-end.'),
    ('PWFE', 'Programação Web para Front-End', 'Esta disciplina explora as tecnologias e práticas para desenvolvimento de aplicações web e com foco em front-end.'),
    ('IDM', 'Interface para Dispositivos Móveis', 'A disciplina, aborda projetar e desenvolver interfaces de usuário para aplicativos móveis, com foco nos princípios de design e usabilidade.'),
    ('BD', 'Banco de Dados', 'Tal disciplina contempla conceitos fundamentais de bancos de dados, modelagem de dados e linguagens de consulta SQL.'),
    ('REDES', 'Redes de Computadores', 'Esta disciplina aborda conceitos introdutórios sobre redes de computadores, topologias e padrões.'),
    ('SO', 'Sistemas Operacionais', 'A disciplina contempla conceitos fundamentais sobre sistemas operacionais, apresentando as funcionalidades dos sistemas operacionais baseados nas plataformas Windows e Linux');

-- Inserts para Professor
INSERT INTO professor (id, nome, sigla_disc, especialidade, data_adm)
VALUES
    (101, 'Eduardo Nascimento', 'BD', 'Tecnologia da Informação', '2023-01-15'),
	(101, 'Eduardo Nascimento', 'PWFE', 'Tecnologia da Informação' ,'2023-01-15'),
    (102, 'Matheus Michilino', 'IDM', 'Mecatrônica e Interfaces Robóticas', '2020-01-01'),
    (103, 'Rafael Selvagio', 'PWBE', 'Tecnologia da Informação', '2023-06-01'),
	(104, 'Rafael Rizzi', 'REDES', 'Eng. Elétrica' ,'2022-01-01');

select * from professor;
select * from disciplina;

-- 1) Selecione os nomes dos professores que têm especialidade em "Tecnologia da Informação" (não devem ser exibidos nomes iguais).
select distinct nome from professor where especialidade like "%Tecnologia da Informação%";

-- 2) Liste o nome das disciplinas cujo nome contém a palavra "Web".
select nome from disciplina where nome like "%Web%";

-- 3) Liste o nome do professor mais antigo (com base na data de admissão).
select nome from professor order by  data_adm asc limit 1;

-- 4) Selecione os nomes das disciplinas lecionadas por professores com especialidade em "Tecnologia da Informação":
select disciplina.nome from disciplina 
join professor on disciplina.sigla_disc = professor.sigla_disc 
where professor.especialidade like "%Tecnologia da Informação%";

-- 5) Liste o nome da disciplina e a especialidade do professor que a ministra, ordene por nome de disciplina:
select disciplina.nome, professor.nome, professor.especialidade from disciplina
join professor on disciplina.sigla_disc = professor.sigla_disc ;