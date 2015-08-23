CREATE DATABASE MS_ABS
GO
USE MS_ABS
GO
/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2015/8/19 14:27:49                           */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('BMessage')
            and   type = 'U')
   drop table BMessage
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LPspMsg')
            and   type = 'U')
   drop table LPspMsg
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RMediaType')
            and   type = 'U')
   drop table RMediaType
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RMessageType')
            and   type = 'U')
   drop table RMessageType
go

/*==============================================================*/
/* Table: BMessage                                              */
/*==============================================================*/
create table BMessage (
   MSG_ID               bigint               identity(1,1),
   MSG_DESC             nvarchar(200)        not null,
   MSG_TITLE            nvarchar(200)        not null,
   MSG_CONTENT          nvarchar(1000)       not null,
   MSG_DT               datetime             not null,
   MSG_RMT_ID           int                  not null,
   MSG_START_DT         datetime             not null,
   MSG_END_DT           datetime             not null,
   MSG_CREATIONUID      varchar(50)          null,
   MSG_CREATION_DT      datetime             not null default getdate(),
   MSG_UPDATEUID        varchar(50)          null,
   MSG_UPDATE_DT        datetime             not null default getdate(),
   constraint PK_BMESSAGE primary key (MSG_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息表',
   'user', @CurrentUser, 'table', 'BMessage'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息描述、备注',
   'user', @CurrentUser, 'table', 'BMessage', 'column', 'MSG_DESC'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '有效期开始',
   'user', @CurrentUser, 'table', 'BMessage', 'column', 'MSG_START_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '有效期结束',
   'user', @CurrentUser, 'table', 'BMessage', 'column', 'MSG_END_DT'
go

/*==============================================================*/
/* Table: LPspMsg                                               */
/*==============================================================*/
create table LPspMsg (
   LPM_ID               bigint               identity(1,1),
   LPM_PSP_ID           int                  not null,
   LPM_MSG_ID           bigint               not null,
   LPM_MDT_ID           int                  not null,
   LPM_TITLE            nvarchar(200)        not null,
   LPM_CONTENT          nvarchar(1000)       null,
   LPM_START_DT         datetime             not null,
   LPM_END_DT           datetime             not null,
   LPM_READ_DT          datetime             null,
   LPM_STATUS           tinyint              not null,
   LPM_CREATIONUID      varchar(50)          null,
   LPM_CREATION_DT      datetime             not null default getdate(),
   constraint PK_LPSPMSG primary key (LPM_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息发送用户表',
   'user', @CurrentUser, 'table', 'LPspMsg'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '客户ID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_PSP_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息ID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_MSG_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息发送介质类型ID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_MDT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息标题（冗余，如果发送的是可变内容，则保存的是填充可变内容后的消息标题）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_TITLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息内容（冗余，如果发送的是可变内容，则保存的是填充可变内容后的消息内容）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_CONTENT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息有效期开始（冗余）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_START_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息有效期结束（冗余）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_END_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '读取时间（状态改为“已读”时修改为当前服务器时间）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_READ_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息状态（1.已发送；2.已读取；）',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_STATUS'
go

/*==============================================================*/
/* Table: RMediaType                                            */
/*==============================================================*/
create table RMediaType (
   MDT_ID               int                  not null,
   MDT_DESC             nvarchar(200)        not null,
   MDT_ORDER_NUM        int                  not null default 0,
   constraint PK_RMEDIATYPE primary key (MDT_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息介质类型表',
   'user', @CurrentUser, 'table', 'RMediaType'
go

/*==============================================================*/
/* Table: RMessageType                                          */
/*==============================================================*/
create table RMessageType (
   RMT_ID               int                  not null,
   RMT_DESC             nvarchar(200)        not null,
   RMT_ORDER_NUM        int                  not null default 0,
   constraint PK_RMESSAGETYPE primary key (RMT_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '消息分类表',
   'user', @CurrentUser, 'table', 'RMessageType'
go

--RMessageType消息分类表
SELECT * FROM RMessageType;
TRUNCATE TABLE RMessageType;
insert INTO RMessageType SELECT 1,'系统消息',9;
insert INTO RMessageType SELECT 2,'促销消息',8;
GO
--RMediaType消息发送介质类型表
SELECT * FROM RMediaType;
TRUNCATE TABLE RMediaType;
insert INTO RMediaType SELECT 1,'短信',9;
insert INTO RMediaType SELECT 2,'微信',8;
insert INTO RMediaType SELECT 3,'邮件',7;
insert INTO RMediaType SELECT 4,'APP',6;
insert INTO RMediaType SELECT 5,'手机网站',5;
insert INTO RMediaType SELECT 6,'官网',4;
GO