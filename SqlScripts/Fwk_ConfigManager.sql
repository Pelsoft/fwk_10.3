/****** Object:  Table [dbo].[fwk_ConfigManager]    Script Date: 07/30/2014 09:33:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fwk_ConfigManager](
	[ConfigurationFileName] [nvarchar](500) NOT NULL,
	[group] [nvarchar](500) NOT NULL,
	[key] [nvarchar](500) NOT NULL,
	[encrypted] [bit] NOT NULL,
	[value] [nvarchar](max) NULL
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

ALTER TABLE [dbo].[fwk_ConfigManager] ADD  CONSTRAINT [DF_fwk_ConfigManager_encrypted]  DEFAULT ((0)) FOR [encrypted]
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
