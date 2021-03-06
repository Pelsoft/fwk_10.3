
GO
/****** Object:  StoredProcedure [dbo].[fwk_ConfigManager_PIVOT]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_ConfigManager_PIVOT]
      @columns VARCHAR(2000)
 AS
 --DECLARE @columns2 VARCHAR(2000)
--SET @columns2 = 'bb_config.en-US,bb_config.es-AR,bb_config.es-AR_local'
                             
 
DECLARE @query VARCHAR(4000)
 
SET @query = '
Select [group],[key] , ' + @columns + ' FROM (
SELECT *
FROM fwk_ConfigManager) p
PIVOT
(
MAX([value])
FOR ConfigurationFileName IN (' + @columns + ')
)
AS p'
--select @query
EXECUTE(@query)
----SELECT * FROM fwk_ConfigManager
--SELECT [key] ,[bb_config.en-ES] ,[bb_config.es-AR] FROM (
--
--SELECT * FROM fwk_ConfigManager) p
--PIVOT
--( 
--MAX([value])
--	FOR ConfigurationFileName IN ([bb_config.en-ES] ,[bb_config.es-AR])
--)
--AS p
--
GO
/****** Object:  Table [dbo].[DomainsUrl]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DomainsUrl](
	[DomainName] [nvarchar](8) NOT NULL,
	[LDAPPath] [nvarchar](100) NOT NULL,
	[Usr] [nvarchar](20) NOT NULL,
	[Pwd] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_ADDomains] PRIMARY KEY CLUSTERED 
(
	[DomainName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[EventLog_i]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------
	-- Author     :		 moviedo
	-- Date       :	   2010-04-19T19:26:41
	-- Description: 	 [Description]
	--------------------------------------------------------------------------------------------
	CREATE PROCEDURE [dbo].[EventLog_i]
	
	(	@Message NVarChar(1000)= NULL,
	 @EventID INT = NULL,
	 @Category NVarChar(20) = NULL,
	 @MachineName NVarChar(20) = NULL,
	 @Source NVarChar(20)= NULL,
	 @TimeWritten DateTime = NULL,
	 @TimeGenerated DATETIME = NULL,
	 @UserName NVarChar(20)= NULL,
	 @EventLogEntryType NVarChar(12)= NULL,
	 @Winlog NVarChar(12)= NULL,
	 @AuditMachineName NVarChar(20)= NULL
	)
	
	AS
	
	
	
	
	
	INSERT INTO EventLog
	(
		[Message]
		,EventID
		,Category
		,MachineName
		,Source
		,TimeWritten
		,TimeGenerated
		,UserName
		,EventLogEntryType
		,Winlog
	,AuditMachineName
	)
	VALUES
	(
		@Message,
		@EventID,
		@Category,
		@MachineName,
		@Source,
		@TimeWritten,
		@TimeGenerated,
		@UserName,
		@EventLogEntryType,
		@Winlog,@AuditMachineName
	)
GO
/****** Object:  StoredProcedure [dbo].[EventLog_sp]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------
	-- Autor:		moviedo
	-- Creacion:		14/05/2010 16:27:24
	-- Descripcion: 	Realiza una busqueda por parametros de la tabla EventLog
	--------------------------------------------------------------------------------------------
	-- Operadores posibles de usar:
	--
	-- <> | > | >= | < | <= | = | %_ | _% | %% | []
	--
	--------------------------------------------------------------------------------------------
	CREATE PROCEDURE [dbo].[EventLog_sp]

	@Category NVarChar(20)  = NULL,

	@MachineName NVarChar(20)  = NULL,

	@Source NVarChar(20)  = NULL,

	@TimeGenerated DateTime  = NULL,

	@UserName NVarChar(20) = NULL,

	@EventLogEntryType NVarChar(12)  = NULL,

	@Winlog NVarChar(12)  = NULL,

	@AuditMachineName NVarChar(20) = NULL

	AS
	BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT DMY

	----------------------------------------
	-- Definimos Variables
	----------------------------------------
	DECLARE @sql        nvarchar(4000)
	DECLARE @parametros nvarchar(4000)

	SET @sql = N' SELECT * FROM EventLog  WHERE 1 = 1 '
	
	-- Category = TYPE NVarChar
	IF (@Category IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND Category  LIKE  @Category '
	END
		
	-- MachineName = TYPE NVarChar
	IF (@MachineName IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND MachineName  LIKE  ''%'' + @MachineName + ''%'''
	END
	
	-- Source = TYPE NVarChar
	IF (@Source IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND Source  LIKE  ''%'' + @Source + ''%'''
	END
	
--	-- TimeGenerated = TYPE DateTime
--	
	 IF (@TimeGenerated IS NOT NULL AND @TimeGenerated <> '' )
	BEGIN
	  SET @sql = @sql + ' AND (TimeGenerated >= @TimeGeneratedDesde AND TimeGenerated <= )' + CONVERT(DATETIME, CONVERT(VARCHAR(10), getdate(), 103), 103)
	END
	
	-- UserName = TYPE NVarChar
	IF (@UserName IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND UserName  LIKE  ''%'' + @UserName + ''%'''
	END
	
	-- EventLogEntryType = TYPE NVarChar
	IF (@EventLogEntryType IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND EventLogEntryType  =   @EventLogEntryType '
	END
	
	-- Winlog = TYPE NVarChar
	IF (@Winlog IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND Winlog  =  @Winlog '
	END
	
	

	
	-- AuditMachineName = TYPE NChar
	IF (@AuditMachineName IS NOT NULL)
	BEGIN
	SET @sql = @sql + ' AND AuditMachineName  LIKE  @AuditMachineName% '
	END
	



	SELECT @parametros = '	
@Category NVarChar(20) ,
@MachineName NVarChar(20) ,
@Source NVarChar(20) ,
@TimeGenerated DateTime ,
@UserName NVarChar(20)	,
@EventLogEntryType NVarChar(12) ,
@Winlog NVarChar(12) ,
@AuditMachineName NVarChar(20) '

	EXEC sp_executesql @sql, @parametros, 
@Category, 
@MachineName, 
@Source,
@TimeGenerated, 
@UserName, 
@EventLogEntryType, 
@Winlog, 
@AuditMachineName
	END
GO
/****** Object:  Table [dbo].[fwk_Service]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_Service](
	[Name] [varchar](255) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Handler] [varchar](255) NOT NULL,
	[Request] [varchar](255) NOT NULL,
	[Response] [varchar](255) NOT NULL,
	[Available] [bit] NOT NULL,
	[Audit] [bit] NOT NULL,
	[TransactionalBehaviour] [varchar](20) NOT NULL,
	[IsolationLevel] [varchar](20) NOT NULL,
	[ApplicationId] [nchar](50) NULL,
	[CreatedDateTime] [datetime] NULL,
	[CreatedUserName] [varchar](20) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Handler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de request.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Request'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de response.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Response'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si el servicio está disponible para ser ejecutado. Valores posibles: true / false.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Available'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si la ejecución del servicio debe ser auditada o no. Valores posibles: true / false.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Audit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Define el comportamiento transaccional del servicio raíz.

*Required: el servicio transacciona. Si hay un ámbito transaccional ya abierto, utiliza el existente, en caso contrario crea una nueva transaccion.

*RequiresNew: Siempre se crea una nueva transacción.
 
*Suppress: no transacciona, todas las operaciones se hacen sin estar en un ámbito transaccional. ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'TransactionalBehaviour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Especifica el nivel de aislamiento de la transacción.

*Chaos: los cambios pendientes de transacciones más aisladas no puede ser sobreescritos.

*ReadCommitted: los datos volátites no puede ser leidos durante la transacción, pero pueden ser modificados.

*ReadUncommitted: los datos volátines pueden ser leidos y modificados durante la transacción.

*RepeatableRead: los datos volátiles pueden ser leidos pero no modificados durante la transación. Nuevos datos pueden ser creados.

*Serializable: los datos volátiles pueden ser leidos pero no modificados, y no es posible crear nuevos datos durante la transacción.

*Snapshot: los datos volátiles pueden ser leidos. Antes de modificarse datos,  se verifica que otra transacción los haya cambiado luego de haber sido leidos. Si los datos se actualizaron, se levanta un error.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'IsolationLevel'
GO
/****** Object:  Table [dbo].[fwk_ConfigManager]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fwk_ConfigManager](
	[ConfigurationFileName] [nvarchar](50) NOT NULL,
	[group] [nvarchar](50) NOT NULL,
	[key] [nvarchar](50) NOT NULL,
	[encrypted] [bit] NOT NULL,
	[value] [nvarchar](1000) NULL,
 CONSTRAINT [PK_fwk_ConfigMannager_1] PRIMARY KEY CLUSTERED 
(
	[ConfigurationFileName] ASC,
	[group] ASC,
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del grupo. Este valor agruma propiedades (keys)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ConfigManager', @level2type=N'COLUMN',@level2name=N'group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la propiedad. Ejemplo: RutaDeImagenes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ConfigManager', @level2type=N'COLUMN',@level2name=N'key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determina si este valor esta encriptado en la base de datos o no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ConfigManager', @level2type=N'COLUMN',@level2name=N'encrypted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor de la propiedad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ConfigManager', @level2type=N'COLUMN',@level2name=N'value'
GO
/****** Object:  Table [dbo].[fwk_ServiceAudit]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_ServiceAudit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServiceName] [varchar](200) NOT NULL,
	[Send_Time] [datetime] NOT NULL,
	[Resived_Time] [datetime] NOT NULL,
	[Send_UserId] [varchar](200) NOT NULL,
	[Send_Machine] [varchar](200) NOT NULL,
	[Dispatcher_Instance_Name] [varchar](200) NOT NULL,
	[ApplicationId] [varchar](200) NULL,
	[Requets] [varbinary](max) NULL,
	[Response] [varbinary](max) NULL,
	[ServiceError] [varbinary](max) NULL,
 CONSTRAINT [PK_fwk_ServiceAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aspnet_RulesCategory]    Script Date: 07/14/2012 11:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_RulesCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[ParentCategoryId] [int] NULL CONSTRAINT [DF_aspnet_RulesCategory_ParenCategoryId]  DEFAULT ((0)),
	[Name] [nvarchar](50) NULL,
	[ApplicationId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_aspnet_RulesCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Rules]    Script Date: 07/14/2012 11:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Rules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NOT NULL,
	[expression] [nvarchar](max) NULL,
	[ApplicationId] [uniqueidentifier] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_aspnet_Rules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_RulesInCategory]    Script Date: 07/14/2012 11:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_RulesInCategory](
	[CategoryId] [int] NOT NULL,
	[RuleId] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_aspnet_RulesInCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[RuleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fwk_ServiceDispatcher]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_ServiceDispatcher](
	[InstanseName] [varchar](200) NOT NULL,
	[AuditMode] [smallint] NOT NULL,
	[HostIp] [varchar](50) NOT NULL,
	[HostName] [varchar](100) NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
	[Logo] [varbinary](1000) NULL,
	[InstanseId] [uniqueidentifier] NULL,
	[Url_URI] [varchar](1000) NULL,
	[Port] [int] NULL,
 CONSTRAINT [PK_fwk_ServiceDispatcher_1] PRIMARY KEY CLUSTERED 
(
	[InstanseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Required=0, Optional=1, None=3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ServiceDispatcher', @level2type=N'COLUMN',@level2name=N'AuditMode'
GO
/****** Object:  StoredProcedure [dbo].[fwk_Logs_d]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Logs_d]
(
	@Id    uniqueidentifier

)
AS
				
-- Description : Procedimiento de eliminación de Logs.
-- Author      : moviedo
-- Date        : 2006-11-16T11:59:20
				

DELETE FROM fwk_Logs
WHERE Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[fwk_Logs_s]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------
	-- Autor:		moviedo
	-- Creacion:		26/02/2010 10:05:27
	-- Descripcion: 	Realiza una busqueda por parametros de la tabla Logs

	CREATE PROCEDURE [dbo].[fwk_Logs_s]
	-- Lista de Parámetros
	
	
	@Source NVarChar(20) = null,
	@LogType NVarChar(20) = null,
	@Machine NVarChar(50) = null,
	@LogDateDesde DateTime = null,
	@LogDateHasta DateTime = null,
	@UserLoginName NVarChar(100) = NULL,
	@AppId NVarChar(100) = null	

	AS

	SELECT * FROM fwk_Logs  
	WHERE 
	 (@LogType IS NULL or	 LogType = @LogType)
	 AND
	 ( (@LogDateDesde IS NULL  AND  @LogDateHasta IS NULL) OR (fwk_Logs.LogDate >= @LogDateDesde AND fwk_Logs.LogDate <= @LogDateHasta))
	 AND
	 ( (@LogDateDesde IS  NULL  AND  @LogDateHasta IS NULL) OR (fwk_Logs.LogDate >= @LogDateDesde))
	 AND
	 ( 
	 	(@UserLoginName IS NULL OR fwk_Logs.UserLoginName  LIKE  @UserLoginName)
	 OR
	 	(@Source IS NULL OR fwk_Logs.Source   LIKE  @Source) ----- Retorna si al menos en algun campo se cumple el like
	 OR
	 	(@Machine IS NULL OR fwk_Logs.[Machine]	  LIKE  @Machine)
	 	 OR
	 	(@AppId IS NULL OR fwk_Logs.AppId  LIKE  @AppId)
	 )
GO
/****** Object:  Table [dbo].[fwk_Logs]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_Logs](
	[Id] [uniqueidentifier] NOT NULL,
	[Message] [varbinary](2000) NOT NULL,
	[Source] [nvarchar](20) NOT NULL,
	[LogType] [nvarchar](20) NOT NULL,
	[Machine] [nvarchar](50) NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[UserLoginName] [nvarchar](100) NOT NULL,
	[AppId] [nvarchar](100) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fwk_ParamType]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_ParamType](
	[ParamTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParentId] [int] NULL,
	[Description] [nchar](10) NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Params] PRIMARY KEY CLUSTERED 
(
	[ParamTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[Message] [nvarchar](1000) NULL,
	[EventID] [int] NULL,
	[Category] [nvarchar](20) NULL,
	[MachineName] [nvarchar](20) NULL,
	[Source] [nvarchar](20) NULL,
	[TimeWritten] [datetime] NULL,
	[TimeGenerated] [datetime] NULL,
	[UserName] [nvarchar](20) NULL,
	[EventLogEntryType] [nvarchar](12) NULL,
	[Winlog] [nvarchar](12) NULL,
	[AuditMachineName] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fwk_Param]    Script Date: 07/28/2013 13:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_Param](
	[ParamId] [int] NOT NULL,
	[ParentId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParamTypeId] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[Enabled] [bit] NOT NULL,
	[Culture] [char](5) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Param] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_g_Name]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_g_Name]
	(
	@Name VARCHAR(255),
	 @ApplicationId varchar(30) = null
	)
AS
BEGIN
	SELECT	fwk_Service.*
	FROM	fwk_Service
	WHERE	fwk_Service.Name = @Name
	AND  fwk_Service.ApplicationId = @ApplicationId
END
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_s_All]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		moviedo
-- Description:	Buscar todos los servicios.
-- =============================================
CREATE PROCEDURE [dbo].[fwk_Service_s_All]

@ApplicationId VARCHAR(30) = NULL

AS

SELECT	 [Name]
		,[Description]
		,Request
		,Response
		,TransactionalBehaviour
		,Handler
		,IsolationLevel
		,Available
		,Audit
		,CreatedDateTime
		,CreatedUserName
		,ApplicationId 
	 FROM fwk_Service
	 
where
(@ApplicationId IS NULL   OR fwk_Service.ApplicationId = @ApplicationId)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_i]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_i]
(

	@Name varchar(255),
	@Description varchar(1000)= null,
	@Handler varchar(255),
	@Request varchar(255),
	@Response varchar(255),
	@Available bit,
	@Audit bit,
	@TransactionalBehaviour varchar(20),
	@IsolationLevel varchar(20),
	@CreatedDateTime datetime	= null,
	@CreatedUserName varchar(20)= null,
	@ApplicationId varchar(30) = null
)                 
AS

-- Description : Procedimiento Almacenado de Creacion de Service
-- Author      : moviedo

INSERT INTO fwk_Service
(
	[Name],
	[Description],
	Handler,
	Request,
	Response,
	Available,
	Audit,
	TransactionalBehaviour,
	IsolationLevel,
	ApplicationId,
	CreatedDateTime 	,
	CreatedUserName 
)
VALUES
(
	@Name,
	@Description,
	@Handler,
	@Request,
	@Response,
	@Available,
	@Audit,
	@TransactionalBehaviour,
	@IsolationLevel,
	@ApplicationId,
	@CreatedDateTime	,
	@CreatedUserName 
)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_u]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_u]
(

	@Name varchar(255),
	@Description varchar(1000)= null,
	@Handler varchar(255),
	@Request varchar(255),
	@Response varchar(255),
	@Available bit,
	@Audit bit,
	@TransactionalBehaviour varchar(20),
	@IsolationLevel varchar(20),
	@ApplicationId varchar(50) = null,
	@CreatedDateTime datetime	= null,
	@CreatedUserName varchar(20)= null,
	@UpdateServiceName varchar(255)
 
)                 
AS

-- Description : Procedimiento Almacenado de Actualizacion de Service
-- Author      : moviedo
-- Date        : 02/08/2010 05:02:04

UPDATE fwk_Service

 SET 
	[Name] = @Name,
	[Description] = @Description,
	Handler = @Handler,
	Request = @Request,
	Response = @Response,
	Available = @Available,
	Audit = @Audit,
	TransactionalBehaviour = @TransactionalBehaviour,
	IsolationLevel = @IsolationLevel,
	
	CreatedDateTime = @CreatedDateTime ,
	CreatedUserName = @CreatedUserName 
WHERE 
(
	[Name] = @UpdateServiceName  
	AND ApplicationId =	@ApplicationId
)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_d]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_d]
(

	@Name varchar(255),
	 @ApplicationId varchar(30) = null
)                 
AS

-- Description : Procedimiento Almacenado de Eliminacion de Service
-- Author      : moviedo
-- Date        :02/08/201005:02:04

DELETE FROM 
	fwk_Service
WHERE 
	(
	[Name] = @Name 
	AND  fwk_Service.ApplicationId = @ApplicationId
)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Logs_i]    Script Date: 07/28/2013 13:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Logs_i]
(
	@Id  uniqueidentifier ,
	@LogDate datetime ,
	@Message varbinary(2000) ,
	@Source nvarchar(20) ,
	@LogType nvarchar(20) ,
	@Machine nvarchar(100) ,
	@UserLoginName nvarchar(100) ,
	@AppId nvarchar(100)

)
AS
				
-- Description : Procedimiento de creación de Logs.
-- Author      : moviedo
-- Date        : 2006-11-16T11:59:20
				

INSERT INTO fwk_Logs
(
	Id,
	LogDate,
	[Message],
	Source,
	LogType,
	Machine,
	UserLoginName,
	AppId

)
VALUES
(
	@Id,
	@LogDate,
	@Message,
	@Source,
	@LogType,
	@Machine,
	@UserLoginName,
	@AppId

)
GO
/****** Object:  Default [DF_fwk_ConfigMannager_encrypted]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_ConfigManager] ADD  CONSTRAINT [DF_fwk_ConfigMannager_encrypted]  DEFAULT ((0)) FOR [encrypted]
GO
/****** Object:  Default [DF_Param_Enabled]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_Param] ADD  CONSTRAINT [DF_Param_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
/****** Object:  Default [DF_fwk_Param_Culture]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_Param] ADD  CONSTRAINT [DF_fwk_Param_Culture]  DEFAULT ('es-AR') FOR [Culture]
GO
/****** Object:  Default [DF_ParamType_Enabled]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_ParamType] ADD  CONSTRAINT [DF_ParamType_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
/****** Object:  Default [DF_fwk_ServiceLogs_LogTime]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_ServiceAudit] ADD  CONSTRAINT [DF_fwk_ServiceLogs_LogTime]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  ForeignKey [FK_fwk_Param_fwk_Param]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_Param]  WITH CHECK ADD  CONSTRAINT [FK_fwk_Param_fwk_Param] FOREIGN KEY([Id])
REFERENCES [dbo].[fwk_Param] ([Id])
GO
ALTER TABLE [dbo].[fwk_Param] CHECK CONSTRAINT [FK_fwk_Param_fwk_Param]
GO
/****** Object:  ForeignKey [FK_Param_ParamType]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_Param]  WITH CHECK ADD  CONSTRAINT [FK_Param_ParamType] FOREIGN KEY([ParamTypeId])
REFERENCES [dbo].[fwk_ParamType] ([ParamTypeId])
GO
ALTER TABLE [dbo].[fwk_Param] CHECK CONSTRAINT [FK_Param_ParamType]
GO
/****** Object:  ForeignKey [FK_ParamType_ParamType]    Script Date: 07/28/2013 13:54:08 ******/
ALTER TABLE [dbo].[fwk_ParamType]  WITH CHECK ADD  CONSTRAINT [FK_ParamType_ParamType] FOREIGN KEY([ParentId])
REFERENCES [dbo].[fwk_ParamType] ([ParamTypeId])
GO
ALTER TABLE [dbo].[fwk_ParamType] CHECK CONSTRAINT [FK_ParamType_ParamType]
GO
