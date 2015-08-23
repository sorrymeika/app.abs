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
   '��Ϣ��',
   'user', @CurrentUser, 'table', 'BMessage'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ��������ע',
   'user', @CurrentUser, 'table', 'BMessage', 'column', 'MSG_DESC'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ч�ڿ�ʼ',
   'user', @CurrentUser, 'table', 'BMessage', 'column', 'MSG_START_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ч�ڽ���',
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
   '��Ϣ�����û���',
   'user', @CurrentUser, 'table', 'LPspMsg'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�ID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_PSP_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��ϢID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_MSG_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ���ͽ�������ID',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_MDT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ���⣨���࣬������͵��ǿɱ����ݣ��򱣴�������ɱ����ݺ����Ϣ���⣩',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_TITLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ���ݣ����࣬������͵��ǿɱ����ݣ��򱣴�������ɱ����ݺ����Ϣ���ݣ�',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_CONTENT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ��Ч�ڿ�ʼ�����ࣩ',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_START_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ��Ч�ڽ��������ࣩ',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_END_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��ȡʱ�䣨״̬��Ϊ���Ѷ���ʱ�޸�Ϊ��ǰ������ʱ�䣩',
   'user', @CurrentUser, 'table', 'LPspMsg', 'column', 'LPM_READ_DT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '��Ϣ״̬��1.�ѷ��ͣ�2.�Ѷ�ȡ����',
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
   '��Ϣ�������ͱ�',
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
   '��Ϣ�����',
   'user', @CurrentUser, 'table', 'RMessageType'
go

--RMessageType��Ϣ�����
SELECT * FROM RMessageType;
TRUNCATE TABLE RMessageType;
insert INTO RMessageType SELECT 1,'ϵͳ��Ϣ',9;
insert INTO RMessageType SELECT 2,'������Ϣ',8;
GO
--RMediaType��Ϣ���ͽ������ͱ�
SELECT * FROM RMediaType;
TRUNCATE TABLE RMediaType;
insert INTO RMediaType SELECT 1,'����',9;
insert INTO RMediaType SELECT 2,'΢��',8;
insert INTO RMediaType SELECT 3,'�ʼ�',7;
insert INTO RMediaType SELECT 4,'APP',6;
insert INTO RMediaType SELECT 5,'�ֻ���վ',5;
insert INTO RMediaType SELECT 6,'����',4;
GO