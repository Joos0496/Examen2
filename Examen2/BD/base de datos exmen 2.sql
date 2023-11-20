--crear tablas--

CREATE DATABASE Examen2
go
use Examen2
go


create table usuarios
(
id int identity (1,1),
Nombre varchar(50) not null,
Correoele varchar(50) not null,
Telefono varchar(15),
CONSTRAINT PK_idusuarios PRIMARY  KEY (ID),

)
go
INSERT INTO Usuarios (Nombre, Correoele, Telefono) values ('Osman','osgomezgmail', 34345656)

CREATE table Equipos 
(
id int identity (1,1),
idusuarios int,
tipoEqui varchar(50) not null,
Modelo varchar(50),
Telefono TEXT,
CONSTRAINT fk_idusuarios FOREIGN KEY (idusuarios) REFERENCES Usuarios(id),
CONSTRAINT PK_idEquipos PRIMARY  KEY (ID),

)

SELECT * FROM Usuarios


CREATE table Reparaciones
(
id int identity (1,1),
idEquipos int,
fechasolicitud varchar(50) not null,
Estado varchar(1),
CONSTRAINT fk_idEquipos FOREIGN KEY (idEquipos) REFERENCES Equipos(id),
CONSTRAINT PK_idReparaciones PRIMARY  KEY (ID),
)
CREATE table Asignaciones
(
id int identity (1,1),
idTecnicos int,
fechaasignacion varchar(50),
CONSTRAINT fk_idTecnicos FOREIGN KEY (idTecnicos) REFERENCES Tecnicos(id),
CONSTRAINT PK_idAsignaciones PRIMARY  KEY (ID),
)

CREATE table Tecnicos
(
id int identity (1,1),
Nombre varchar(50) not null,
Especialidad varchar(50),
CONSTRAINT PK_itecnicos PRIMARY  KEY (ID),
)
CREATE table Detallesreparacion
(
id int identity (1,1),
idReparaciones int,
descripcion varchar(50),
fechasinicio varchar(50),
fechafin varchar(50),
CONSTRAINT fk_idReparaciones FOREIGN KEY (idReparaciones) REFERENCES Reparaciones(id),
CONSTRAINT PK_idDetallesreparacion PRIMARY  KEY (ID),
)

CREATE PROCEDURE [dbo].[INGRESAR]
   @NOMBRE VARCHAR(50),
   @CORREOELE VARCHAR(50),
   @TELEFONO int,
 AS
   BEGIN 
     INSERT INTO  usuarios(Nombre, Correoele, Telefono) VALUES (@NOMBRE,@CORREOELE,@TELEFONO)
   END
GO

CREATE PROCEDURE [dbo].[BORRAR]
   @CODIGO INT 
 AS 
   BEGIN 
      DELETE usuarios WHERE ID = @CODIGO
	  DELETE Equipos WHERE ID = @CODIGO
	  DELETE Tecnicos WHERE ID = @CODIGO
   END
GO

CREATE PROCEDURE [dbo].[CONSULTAR_FILTRO]
   @CODIGO INT 
 AS 
   BEGIN 
      SELECT * FROM usuarios WHERE ID = @CODIGO
	  SELECT * FROM Equipos WHERE ID = @CODIGO
	  SELECT * FROM Tecnicos WHERE ID = @CODIGO
	  SELECT * FROM Reparaciones WHERE ID = @CODIGO
	  SELECT * FROM Detallesreparacion WHERE ID = @CODIGO
	  SELECT * FROM Asignaciones WHERE ID = @CODIGO
   END
GO

CREATE PROCEDURE [dbo].[ActualizarAsignacion]
   @AsignacionID INT,
   @ReparacionID INT,
   @TecnicoID INT,
   @FechaAsignacion DATETIME
AS 
BEGIN 
   UPDATE asignaciones SET Detallesreparacion = @ReparacionID, @TecnicoID = @TecnicoID, fechaAsignacion = @FechaAsignacion WHERE Asignaciones = @AsignacionID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarDetallesReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- actualizar detalles de reparación
CREATE PROCEDURE [dbo].[ActualizarDetallesReparacion]
   @DetallesID INT,
   @ReparacionID INT,
   @Descripcion VARCHAR(50),
   @FechaInicio DATETIME,
   @FechaFin DATETIME
AS 
BEGIN 
   UPDATE detallesReparacion SET Detallesreparacion = @ReparacionID, descripcion = @Descripcion, fechaInicio = @FechaInicio, fechaFin = @FechaFin WHERE Detallesreparacion = @DetallesID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEquipo]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- actualizar equipo
CREATE PROCEDURE [dbo].[ActualizarEquipo]
   @EquipoID INT,
   @TipoEquipo VARCHAR(50),
   @Modelo VARCHAR(50),
   @UsuarioID INT
AS 
BEGIN 
   UPDATE equipos SET tipoEqui = @TipoEquipo, modelo = @Modelo, idusuarios = @UsuarioID WHERE Equipos = @EquipoID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- actualizar reparación
CREATE PROCEDURE [dbo].[ActualizarReparacion]
   @ReparacionID INT,
   @EquipoID INT,
   @FechaSolicitud DATETIME,
   @Estado CHAR(1)
AS 
BEGIN 
   UPDATE reparaciones SET idEquipos = @EquipoID, fechaSolicitud = @FechaSolicitud, estado = @Estado WHERE Detallesreparacion = @ReparacionID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarTecnico]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- actualizar técnico
CREATE PROCEDURE [dbo].[ActualizarTecnico]
   @TecnicoID INT,
   @Nombre VARCHAR(50),
   @Especialidad VARCHAR(50)
AS 
BEGIN 
   UPDATE tecnicos SET nombre = @Nombre, especialidad = @Especialidad WHERE Tecnicos = @TecnicoID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarUsuario]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--actualizar usuario
CREATE PROCEDURE [dbo].[ActualizarUsuario]
   @UsuarioID INT,
   @Nombre VARCHAR(50),
   @CorreoElectronico VARCHAR(50),
   @Telefono VARCHAR(15)
AS 
BEGIN 
   UPDATE usuarios SET nombre = @Nombre, Correoele = @CorreoElectronico, telefono = @Telefono WHERE usuarios = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarAsignacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTOS ASIGNACIONES
-- agregar asignación
CREATE PROCEDURE [dbo].[AgregarAsignacion]
   @ReparacionID INT,
   @TecnicoID INT,
   @FechaAsignacion DATETIME
AS 
BEGIN 
   INSERT INTO asignaciones (Detallesreparacion, tecnicos, fechaAsignacion) VALUES (@ReparacionID, @TecnicoID, @FechaAsignacion)
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarDetallesReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTOS DETALLESREPARACION
-- agregar detalles de reparación
CREATE PROCEDURE [dbo].[AgregarDetallesReparacion]
   @ReparacionID INT,
   @Descripcion VARCHAR(50),
   @FechaInicio DATETIME,
   @FechaFin DATETIME
AS 
BEGIN 
   INSERT INTO detallesReparacion (idReparaciones, descripcion, fechaInicio, fechaFin) VALUES (@ReparacionID, @Descripcion, @FechaInicio, @FechaFin)
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarEquipo]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTOS EQUIPOS
-- agregar equipo
CREATE PROCEDURE [dbo].[AgregarEquipo]
   @TipoEquipo VARCHAR(50),
   @Modelo VARCHAR(50),
   @UsuarioID INT
AS 
BEGIN 
   INSERT INTO equipos (tipoEqui, modelo, idusuarios) VALUES (@TipoEquipo, @Modelo, @UsuarioID)
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTOS REPARACIONES
-- agregar reparación
CREATE PROCEDURE [dbo].[AgregarReparacion]
   @EquipoID INT,
   @FechaSolicitud DATETIME,
   @Estado CHAR(1)
AS 
BEGIN 
   INSERT INTO reparaciones (idEquipos, fechaSolicitud, estado) VALUES (@EquipoID, @FechaSolicitud, @Estado)
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarTecnico]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTOS TECNICOS
-- agregar técnico
CREATE PROCEDURE [dbo].[AgregarTecnico]
   @Nombre VARCHAR(50),
   @Especialidad VARCHAR(50)
AS 
BEGIN 
   INSERT INTO tecnicos (nombre, especialidad) VALUES (@Nombre, @Especialidad)
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarUsuario]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--PROCEDIMIENTOS USUARIO
--agregar usuario
CREATE PROCEDURE [dbo].[AgregarUsuario]
   @Nombre VARCHAR(50),
   @CorreoElectronico VARCHAR(50),
   @Telefono VARCHAR(15)
AS 
BEGIN 
   INSERT INTO usuarios (nombre, Correoele, telefono) VALUES (@Nombre, @CorreoElectronico, @Telefono)
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarAsignaciones]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar todas las asignaciones
CREATE PROCEDURE [dbo].[ConsultarAsignaciones]
AS 
BEGIN 
   SELECT * FROM asignaciones
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarAsignacionPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarAsignacionesPorID]
   @AsignacionID INT
AS 
BEGIN 
   SELECT * FROM asignaciones WHERE Asignaciones = @AsignacionID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetallesReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar todos los detalles de reparación
CREATE PROCEDURE [dbo].[ConsultarDetallesReparacion]
AS 
BEGIN 
   SELECT * FROM detallesReparacion
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetallesReparacionPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarDetallesReparacionPorID]
   @DetallesID INT
AS 
BEGIN 
   SELECT * FROM detallesReparacion WHERE Detallesreparacion = @DetallesID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarEquipoPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarEquipoPorID]
   @EquipoID INT
AS 
BEGIN 
   SELECT * FROM equipos WHERE Equipos = @EquipoID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarEquipos]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar todos los equipos
CREATE PROCEDURE [dbo].[ConsultarEquipos]
AS 
BEGIN 
   SELECT * FROM equipos
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarReparaciones]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar todas las reparaciones
CREATE PROCEDURE [dbo].[ConsultarReparaciones]
AS 
BEGIN 
   SELECT * FROM reparaciones
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarReparacionPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarReparacionPorID]
   @ReparacionID INT
AS 
BEGIN 
   SELECT * FROM reparaciones WHERE Detallesreparacion = @ReparacionID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTecnicoPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarTecnicoPorID]
   @TecnicoID INT
AS 
BEGIN 
   SELECT * FROM tecnicos WHERE Tecnicos = @TecnicoID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTecnicos]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- consultar todos los técnicos
CREATE PROCEDURE [dbo].[ConsultarTecnicos]
AS 
BEGIN 
   SELECT * FROM tecnicos
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarioPorID]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--consultar por ID (filtro)
CREATE PROCEDURE [dbo].[ConsultarUsuarioPorID]
   @UsuarioID INT
AS 
BEGIN 
   SELECT * FROM usuarios WHERE usuarios = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarios]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--consultar todos los usuarios
CREATE PROCEDURE [dbo].[ConsultarUsuarios]
AS 
BEGIN 
   SELECT * FROM usuarios
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarAsignacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- eliminar asignación
CREATE PROCEDURE [dbo].[EliminarAsignacion]
   @AsignacionID INT
AS 
BEGIN 
   DELETE asignaciones WHERE Asignaciones = @AsignacionID
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarDetallesReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- eliminar detalles de reparación
CREATE PROCEDURE [dbo].[EliminarDetallesReparacion]
   @DetallesID INT
AS 
BEGIN 
   DELETE detallesReparacion WHERE Detallesreparacion = @DetallesID
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarEquipo]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- eliminar equipo
CREATE PROCEDURE [dbo].[EliminarEquipo]
   @EquipoID INT
AS 
BEGIN 
   DELETE equipos WHERE Equipos = @EquipoID
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarReparacion]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- eliminar reparación
CREATE PROCEDURE [dbo].[EliminarReparacion]
   @ReparacionID INT
AS 
BEGIN 
   DELETE reparaciones WHERE Detallesreparacion = @ReparacionID
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarTecnico]    Script Date: 19/11/2023 23:58:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- eliminar técnico
CREATE PROCEDURE [dbo].[EliminarTecnico]
   @TecnicoID INT
AS 
BEGIN 
   DELETE tecnicos WHERE Tecnicos = @TecnicoID
END
GO
