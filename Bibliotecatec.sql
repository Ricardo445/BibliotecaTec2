create database BibliotecaTec

create  table Alumnos
(
Matricula varchar (9)Primary key,
Nombre varchar (30),
ApellidoPaterno varchar (30),
ApellidoMaterno varchar (30),
IdCarrera varchar (4),
Semestre int,
Seccion char(1),
Sexo char(1)
)
Create table Carreras
(
IdCarrera varchar (4) Primary key,
NombreCarrera varchar (30)
)
create table registros 
(
Folio int identity primary key,
Id_Matricula varchar (9),
HoraEntrada datetime,
HoraSalida datetime
)
Create table Administradores
(
Usuarios varchar (20) primary key,
Contraseña varchar (45)
)
-- crear relaciones 
alter table registros add constraint alumnosRegistros
	foreign key (Id_Matricula) references Alumnos(Matricula)
alter table Alumnos add constraint CarrerasAlumnos
	foreign key (IdCarrera) references Carreras(IdCarrera)

insert into Carreras(IdCarrera,NombreCarrera)values('ISIC','Sistemas Computacionales')
insert into Carreras(IdCarrera,NombreCarrera)values('IIND','Industrial')
insert into Carreras(IdCarrera,NombreCarrera)values('IGEM','Gestión Empresarial')
insert into Carreras(IdCarrera,NombreCarrera)values('ILOG','Logistica')


insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Seccion,Sexo) values ('131000124','Salvador','Almaraz','Montemayor','ISIC',6,'C','M')
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Seccion,Sexo) values ('131000153','Ricardo','Hernandez','Fernandez','ISIC',6,'C','M')
go

create procedure InsertarEntradas
@Matricula varchar (9)
as
begin
     if exists (select Id_Matricula from registros where Id_Matricula=@Matricula)
		 Begin
		 if exists (select HoraSalida from registros where Id_Matricula=@Matricula and HoraSalida is null)     
			 begin 
			 update registros
			 set HoraSalida=GETDATE()where Id_Matricula=@Matricula and HoraSalida is null
			 end      
		 else
			 begin
			  insert into registros(Id_Matricula,HoraEntrada)values (@Matricula,GETDATE())
			 end
		 end
     else
     begin 
		 insert into registros(Id_Matricula,HoraEntrada)values (@Matricula,GETDATE())
     end
end
execute InsertarEntradas '131000153'

select * from registros