create database BibliotecaTec

go
---- creacion de la tabla alumnos
create  table Alumnos
(
Matricula varchar (9)Primary key,
Nombre varchar (30),
ApellidoPaterno varchar (30),
ApellidoMaterno varchar (30),
IdCarrera varchar (4),
Semestre int,
Sexo char(1)
)
go
----creacion de la tabla carreras
Create table Carreras
(
IdCarrera varchar (4) Primary key,
NombreCarrera varchar (30)
)
go
--creacion de la tabla registros de entrada salida
create table registros 
(
Folio int identity primary key,
Id_Matricula varchar (9),
Nombre varchar (30),
ApellidoPaterno varchar (30),
ApellidoMaterno varchar (30),
IdCarrera varchar (4),
Semestre int,
Sexo char(1),
Fecha date,
HoraEntrada time,
HoraSalida time
)
go
--Create table Administradores
--(
--Usuarios varchar (20) primary key,
--Contraseña varchar (45)
--)
go
-- crear relaciones 
alter table Alumnos add constraint CarrerasAlumnos
	foreign key (IdCarrera) references Carreras(IdCarrera)
go
---- insertar carreras
insert into Carreras(IdCarrera,NombreCarrera)values('ISIC','Sistemas Computacionales')
insert into Carreras(IdCarrera,NombreCarrera)values('IIND','Industrial')
insert into Carreras(IdCarrera,NombreCarrera)values('IGEM','Gestión Empresarial')
insert into Carreras(IdCarrera,NombreCarrera)values('ILOG','Logistica')
go
---- insertar alumnos prueba 
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values ('131000124','Salvador','Almaraz','Montemayor','ISIC',6,'M')
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values ('131000153','Ricardo','Hernandez','Fernandez','ISIC',6,'M')
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values ('131000155','Mariela','Alanis','Carrillo','IGEM',6,'F')
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values ('131000156','Monica','Valdez','Reyes','ISIC',6,'F')
insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values ('131000157','Diego','Loera','Partida','IGEM',6,'M')

go
---- sp insertar alumnos
create procedure spAgregar_alumno
@Matricula varchar(9),
@Nombre varchar (30),
@ApellidoPaterno varchar (30),
@ApellidoMaterno varchar (30),
@IdCarrera varchar (4),
@Semestre int,
@Sexo char(1),
@msg varchar (130) out 
as
begin transaction 
begin try
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
		 set @msg = 'La matricula ya esta registrada'
		end
	else
		begin
			insert into Alumnos(Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo) values (@Matricula,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@IdCarrera,@Semestre,@Sexo)
			set @msg = 'Matricula registrada'
		end
 commit tran
end try
begin catch 
 set @msg = 'Error al cargar los datos'
 rollback tran
end catch
-- prueba insertar
go
declare @mensaje varchar (130) 
execute spAgregar_alumno '131000123','Erica','Serrano','Ramirez','IGEM',6,'F',@mensaje out
print @mensaje
select * from Alumnos
go
--prueba modificar
declare @mensaje varchar (130) 
execute spmodifica_alumno '131000123','Erica','Serrano','Ramirez','IGEM',6,'F',@mensaje out
print @mensaje
go
----- sp insertar entradas
create procedure spInsertarEntradas
@Matricula varchar (9),
@msg varchar (130) out 
as
BEGIN TRANSACTION
	BEGIN TRY	
	if	exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
			 if exists (select Id_Matricula from registros where Id_Matricula=@Matricula)
				 Begin
					 if exists (select HoraSalida from registros where Id_Matricula=@Matricula and HoraSalida is null)     
						 begin 
							 update registros
							 set HoraSalida=GETDATE()where Id_Matricula=@Matricula and HoraSalida is null
							 set @msg = 'Que tenga un buen dia'
						 end      
					 else
						 begin
						  insert into registros(Id_Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo,Fecha,HoraEntrada)(select Matricula, Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo,GETDATE(),GETDATE() from Alumnos where Matricula=@Matricula)						 
						   set @msg = 'Bienvenido'
						 end
				 end
			 else
				 begin 
						  insert into registros(Id_Matricula,Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo,Fecha,HoraEntrada)(select Matricula, Nombre,ApellidoPaterno,ApellidoMaterno,IdCarrera,Semestre,Sexo,GETDATE(),GETDATE() from Alumnos where Matricula=@Matricula)						 
					   set @msg = 'Bienvenido'
				 end
		end
	else
		begin
			set @msg = 'La Matricula no existe,acuda con el encargado de biblioteca'
		end
COMMIT TRANSACTION
	END TRY ---TERMINO TRY---
	BEGIN CATCH
		SET @msg ='ERROR al cargar los datos'
		ROLLBACK TRAN
END CATCH
go
-----  prueba sp insertar entradas
declare @mensaje varchar (130) 
execute InsertarEntradas '131000122',@mensaje out
print @mensaje
select * from registros

go
----- sp modificar alumnos
create procedure spmodifica_alumno
@Matricula varchar(9),
@Nombre varchar (30),
@ApellidoPaterno varchar (30),
@ApellidoMaterno varchar (30),
@IdCarrera varchar (4),
@Semestre int,
@Sexo char(1),
@msg varchar (130) out 
as
begin transaction 
begin try
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
		update Alumnos  set Nombre = @Nombre, ApellidoPaterno = @ApellidoPaterno,ApellidoMaterno = @ApellidoMaterno,IdCarrera = @IdCarrera,Semestre=@Semestre,Sexo = @Sexo where Matricula = @Matricula
		set @msg = 'Datos de alumno modificados'
		end
	else
		begin
		 set @msg = 'Alumno no entcontrado en el sistema'
		end
 commit tran
end try
begin catch 
 set @msg = 'Error al cargar los datos'
 rollback tran
end catch
go
---- sp eliminar alumnos 
create procedure spelimina_alumno
@Matricula varchar (9),
@msg varchar (130) out 
as
begin transaction
begin try
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
		delete Alumnos where Matricula = @Matricula
		set @msg = 'Alumno eliminado'
		end
	else
		begin
		 set @msg = 'Alumno no entcontrado en el sistema'
		end
 commit tran
end try 
begin catch
 set @msg = 'Error al cargar los datos'
 rollback tran
end catch
go
--- bitacora alumnos
create table Bitacora_Alumnos
(
folio int identity primary key, 
Tipo_transaccion varchar (15),
Matricula_ant  varchar (9),
Nombre_ant  varchar (30),
ApellidoPaterno_ant  varchar (30),
ApellidoMaterno_ant  varchar (30),
IdCarrera_ant  varchar (4),
Semestre_ant  int,
Sexo_ant  char(1),
Matricula_nue varchar (9),
Nombre_nue varchar (30),
ApellidoPaterno_nue varchar (30),
ApellidoMaterno_nue varchar (30),
IdCarrera_nue varchar (4),
Semestre_nue int,
Sexo_nue char(1)
)
go
--- triger eliminar alumnos
alter TRIGGER Eliminar_alumnos
ON Alumnos
FOR Delete
AS 
declare @Matricula_ant varchar (9),
@Nombre_ant  varchar (30),
@ApellidoPaterno_ant  varchar (30),
@ApellidoMaterno_ant  varchar (30),
@IdCarrera_ant  varchar (4),
@Semestre_ant  int,
@Sexo_ant  char(1)
declare elimina scroll cursor 
for 
select deleted.Matricula,deleted.Nombre,deleted.ApellidoPaterno,deleted.ApellidoMaterno,deleted.IdCarrera,deleted.Semestre,deleted.Sexo from deleted
open elimina
fetch next from elimina into @Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant 
while @@fetch_status=0
begin
insert into Bitacora_Alumnos(Tipo_transaccion,Matricula_ant,Nombre_ant,ApellidoPaterno_ant,ApellidoMaterno_ant,IdCarrera_ant,Semestre_ant,Sexo_ant) values ('Eliminar',@Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant )
fetch next from elimina into  @Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant 
end
close elimina
deallocate elimina
go

create TRIGGER inserta_alumnos
ON Alumnos
FOR insert
AS 
declare @Matricula_nue varchar (9),
@Nombre_nue  varchar (30),
@ApellidoPaterno_nue  varchar (30),
@ApellidoMaterno_nue  varchar (30),
@IdCarrera_nue  varchar (4),
@Semestre_nue int,
@Sexo_nue  char(1)
declare insertar scroll cursor 
for 
select inserted.Matricula,inserted.Nombre,inserted.ApellidoPaterno,inserted.ApellidoMaterno,inserted.IdCarrera,inserted.Semestre,inserted.Sexo from inserted
open insertar
fetch next from insertar into @Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue
while @@fetch_status=0
begin
insert into Bitacora_Alumnos(Tipo_transaccion,Matricula_nue,Nombre_nue,ApellidoPaterno_nue,ApellidoMaterno_nue,IdCarrera_nue,Semestre_nue,Sexo_nue)
            values ('Insertar',@Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue)
fetch next from insertar into @Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue
end
close insertar
deallocate insertar
go
alter TRIGGER modificar_alumnos
ON Alumnos
FOR update
AS 
declare @Matricula_nue varchar (9),
@Nombre_nue  varchar (30),
@ApellidoPaterno_nue  varchar (30),
@ApellidoMaterno_nue  varchar (30),
@IdCarrera_nue  varchar (4),
@Semestre_nue int,
@Sexo_nue  char(1),
@Matricula_ant varchar (9),
@Nombre_ant  varchar (30),
@ApellidoPaterno_ant  varchar (30),
@ApellidoMaterno_ant  varchar (30),
@IdCarrera_ant  varchar (4),
@Semestre_ant  int,
@Sexo_ant  char(1)
declare Modificar scroll cursor 
for 
select inserted.Matricula,inserted.Nombre,inserted.ApellidoPaterno,inserted.ApellidoMaterno,inserted.IdCarrera,inserted.Semestre,inserted.Sexo,deleted.Matricula,deleted.Nombre,deleted.ApellidoPaterno,deleted.ApellidoMaterno,deleted.IdCarrera,deleted.Semestre,deleted.Sexo from inserted inner join deleted on inserted.Matricula=deleted.Matricula
open modificar
fetch next from modificar into @Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue,@Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant 
while @@fetch_status=0
begin
insert into Bitacora_Alumnos(Tipo_transaccion,Matricula_nue,Nombre_nue,ApellidoPaterno_nue,ApellidoMaterno_nue,IdCarrera_nue,Semestre_nue,Sexo_nue,Matricula_ant,Nombre_ant,ApellidoPaterno_ant,ApellidoMaterno_ant,IdCarrera_ant,Semestre_ant,Sexo_ant)
            values ('Actualizar',@Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue,@Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant)
fetch next from modificar into @Matricula_nue,@Nombre_nue,@ApellidoPaterno_nue,@ApellidoMaterno_nue,@IdCarrera_nue,@Semestre_nue,@Sexo_nue,@Matricula_ant,@Nombre_ant,@ApellidoPaterno_ant,@ApellidoMaterno_ant,@IdCarrera_ant,@Semestre_ant,@Sexo_ant 
end
close modificar
deallocate modificar
go

     
SELECT * FROM Bitacora_Alumnos
SELECT * FROM Alumnos

select * from registros
where Fecha between '31/05/2016' and '31/05/2016' 



