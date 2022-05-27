create database dbvideolocadoura20221;

show databases;

#drop database (nome do db);

use dbvideolocadoura20221;

######Comandos para tables######

#Devemos sempre criar primeiro as tables que cedem suas chaves primárias

create table tblsexo (
		
        id 		int unsigned not null auto_increment primary key,
        nome 	varchar(25) not null,
        sigla	varchar(1) not null,
        
        unique index(id)
);

create table tblgenero (

		id 		int unsigned not null auto_increment,
        nome 	varchar(45) not null,

	primary key(id),
	unique index(id)
);

create table tblstreaming (

		id 		int unsigned not null auto_increment primary key,
        nome 	varchar(45) not null,

	unique index(id)

);

create table tblnacionalidade (

		id 		int unsigned not null auto_increment primary key
        
        #Forçando um erro para demonstrar como alterar os atributos de uma tabela
        #nome 	varchar(45) not null,

	##unique index(id)

);

create table tblator (

		id 				int unsigned not null auto_increment primary key,
        nome 			varchar(80) not null,
        nomeartistico 	varchar(80),
        datanascimento 	date not null,
        datafalecimento date,
        biografia 		text,
        
        #Quando criamos uma chave estrangeira, ela precisa ter as mesmas propriedades de 
	#quando ela foi criada como chave primária, tirando auto_increment e primary key
        idsexo 			int unsigned not null,
    
    #Cria um nome representativo para a relação
	constraint FK_Sexo_Ator 
    
    #Estabelece quem será a FK nesta tabela
    foreign key(idsexo)
    
    #Especifica de onde virá a FK (tabela de origem PK)
    references tblsexo(id),
        

	unique index(id)

);

insert into tblator(nome, nomeartistico, datanascimento, datafalecimento, biografia, idsexo)
	values('James Edmund Caan',
            'JAMES CAAN',
            '1940-03-26',
            null,
            '- Conquistou a faixa preta de caratê quando jovem;- Possui uma estrela na Calçada da Fama, localizada em 6648 Hollywood Boulevard;- Pai do tambem ator Scott Caan.',
            2);
            
select id,nome from tblator;

create table tblatornacionalidade (
	
    id 				int unsigned not null auto_increment primary key,
    idator 			int unsigned not null,
    idnacionalidade int unsigned not null,
	
	constraint FK_Ator_AtorNacionalidade
    foreign key (idator)
    references tblator(id),
    
    unique index(id)
);

select * from tblatornacionalidade;

#Alterando uma tabela para adicionar uma chave estrangeira.
alter table tblatornacionalidade
	add constraint 	FK_Nacionalidade_AtorNacionalidade
    foreign key 	(idnacionalidade)
    references 		tblNacionalidade (id);

######## Para apagar um coluna que seja um chave estrangeira em uma tabela
###### é necessário primeiro dar um drop na constraint dessa chave,
###### e só então podemos apagar a coluna.

#Comando para apagar a constraint de uma chave estrangeira.
alter table tblatornacionalidade
	drop foreign key FK_Nacionalidade_AtorNacionalidade;

alter table tblnacionalidade add column
		
        nome varchar(45) not null,
        add unique index(id);
        
alter table tblnacionalidade drop column nome;

alter table tblnacionalidade modify column 
		nome varchar(45) not null;
        
#O comando change permite modificar o nome da coluna e suas outras propriedades        
alter table tblnacionalidade change 
		nome nomeNacionalidade varchar(45) not null;

show tables;

#drop table tblnacionalidade;

#Mostram as configurações da tabela (desc -> description)
desc tblatornacionalidade;
describe tblsexo;

###########	COMANDOS BÁSICOS DE CRUD (Insert, Update, Delete e Select)	##################

#	Insert
insert into tblsexo	(sigla, nome)
		values ('F', 'Feminino');
        
insert into tblsexo	(sigla, nome)
		values ('M', 'Masculino'),
				('O', 'Outros');

#	Update
update tblsexo set 
		nome = 'Feminino'
	where id = 1;
 
update tblsexo set id = 1 where nome = 'Feminino'; 
    
#Pesquisar sobre rollback;
    
#	Delete

delete from tblsexo where id = 6;

select * from tblsexo;

#	Select

	#select - campos que serão exibidos nas buscas
    #from - colocamos as tabelas e seus relacionamentos
    #where - critérios das buscas

#Retorna todos os dados de todos os campos    
select * from tblsexo; 
select tblsexo.* from tblsexo;

#Retorna um  ou mais campos específicos
select nome from tblsexo;
select id, nome from tblsexo;
select tblsexo.id, tblsexo.nome from tblsexo;

#Retorna apenas registros que atendam aos critérios informados
select * from tblsexo 
	where id = 3;
    
select * from tblsexo
	where nome = 'Masculino';
 
#Ordernando os resultados do Select
select * from tblsexo order by nome desc;
select * from tblsexo order by nome asc;
select * from tblsexo order by nome, sigla asc;
select * from tblsexo order by nome asc, sigla desc;

##	Like - permite buscar por um campo string sendo qualquer parte da escrita

#Pesquisa pelo início da string 
select * from tblator where nome like 'Marlon%';

#Pesquisa pelo fim da string
select * from tblator where nome like '%o';

#Pesquisa por qualquer parte da string
select * from tblator where nome like '%o%';

##	Operadores lógicos

#And - somar ou atender ambos os critérios
#Or	- pode atender apenas um dos critérios
#Not - faz a negação da saida

select nome, nomeartistico, biografia 
	from tblator 
	where nome like '%o%' and biografia like '%o%';
    
select nome, nomeartistico, biografia 
	from tblator 
	where nome like '%o%' or biografia like '%o%';
    
select nome, nomeartistico, biografia 
	from tblator 
	where nome not like '%o%' and biografia not like '%0%';