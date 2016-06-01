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

--SP para obtener la contraseña y comparar en el login [30/052016] 
create procedure contraseña
@usuario VARCHAR(20)
AS
select Contraseña from Administradores where Usuarios= @usuario


--SP para agregar nuevos usuarios [30/052016]
create procedure Insertar_Usuario
@Usuarios varchar(20),
@Contraseña varchar (45),
@msg varchar (130) out 
as
begin transaction 
begin try
	if exists (select @Usuarios from Administradores where Usuarios=@Usuarios)
		begin
		update Administradores  set Usuarios = @Usuarios, Contraseña = @Contraseña where Usuarios = @Usuarios
		set @msg = 'Datos Actualizados'
		commit tran
		end
	else
		begin
			insert into Administradores values(@Usuarios,@Contraseña)
		 set @msg = 'Datos Agregados'
		 commit tran
		end
end try
begin catch 
 set @msg = 'Error al cargar los datos'
 rollback tran
end catch	
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
@Matricula varchar (9),
@msg varchar (130) out 
as
begin
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
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
						  insert into registros(Id_Matricula,HoraEntrada)values (@Matricula,GETDATE())
						  set @msg = 'Bienvenido'
						 end
				 end
			 else
				 begin 
					 insert into registros(Id_Matricula,HoraEntrada)values (@Matricula,GETDATE())
				 end
		end
	else
		begin
			set @msg = 'La Matricula no existe o aun no esta registrada \n si este es el caso acuda con el encargado de biblioteca'
		end
end

declare @mensaje varchar (130) 
execute InsertarEntradas '131000153',@mensaje out
print @mensaje
select * from registros
go
create procedure modifica_alumno
@Matricula varchar(9),
@Nombre varchar (30),
@ApellidoPaterno varchar (30),
@ApellidoMaterno varchar (30),
@IdCarrera varchar (4),
@Semestre int,
@Seccion char(1),
@Sexo char(1),
@msg varchar (130) out 
as
begin
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
		update Alumnos  set Nombre = @Nombre, ApellidoPaterno = @ApellidoPaterno,ApellidoMaterno = @ApellidoMaterno,IdCarrera = @IdCarrera,Semestre=@Semestre,Seccion=@Semestre,Sexo = @Sexo where Matricula = @Matricula
		set @msg = 'Datos de alumno modificados'
		end
	else
		begin
		 set @msg = 'Alumno no entcontrado en el sistema'
		end
end

go
create procedure elimina_alumno
@Matricula varchar (9),
@msg varchar (130) out 
as
begin
	if exists (select Matricula from Alumnos where Matricula=@Matricula)
		begin
		delete Alumnos where Matricula = @Matricula
		set @msg = 'Alumno eliminado'
		end
	else
		begin
		 set @msg = 'Alumno no entcontrado en el sistema'
		end
end
go
create view v_registros
as
select Folio,Id_Matricula,HoraEntrada,HoraSalida,IdCarrera from registros inner join Alumnos on registros.Id_Matricula = Alumnos.Matricula 
go

create procedure sp_mostrar 
@op int
as
begin
	if @op = 1
		begin
		select * from v_registros
		end
	if @op = 2
		begin
		select * from v_registros where IdCarrera = 'ISIS'
		end
	if @op = 3
		begin
		select * from v_registros where IdCarrera = 'IIND'
		end
	if @op = 3
		begin
		select * from v_registros where IdCarrera = 'IGEM'
		end
	if @op = 4
		begin
		select * from v_registros where IdCarrera = 'ILOG'
		end
end
 
--SP para obtener la contraseña y comparar en el login [30/052016] 
create procedure contraseña
@usuario VARCHAR(20)
AS
select Contraseña from Administradores where Usuarios= @usuario


--SP para agregar nuevos usuarios [30/052016]
create procedure Insertar_Usuario
@Usuarios varchar(20),
@Contraseña varchar (45),
@msg varchar (130) out 
as
begin transaction 
begin try
	if exists (select @Usuarios from Administradores where Usuarios=@Usuarios)
		begin
		update Administradores  set Usuarios = @Usuarios, Contraseña = @Contraseña where Usuarios = @Usuarios
		set @msg = 'Datos Actualizados'
		commit tran
		end
	else
		begin
			insert into Administradores values(@Usuarios,@Contraseña)
		 set @msg = 'Datos Agregados'
		 commit tran
		end
end try
begin catch 
 set @msg = 'Error al cargar los datos'
 rollback tran
end catch	
