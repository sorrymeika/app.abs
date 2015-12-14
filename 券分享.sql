if exists (select 1
            from  sysobjects
           where  id = object_id('RVoucherShareType')
            and   type = 'U')
   drop table RVoucherShareType
go

/*==============================================================*/
/* Table: RVoucherShareType                                     */
/*==============================================================*/
create table RVoucherShareType (
   VST_ID               int                  not null,
   VST_DESC             nvarchar(200)        not null,
   VST_ENDESC           varchar(100)         null,
   VST_ORDER_NUM        int                  not null default 0,
   constraint PK_RVOUCHERSHARETYPE primary key (VST_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'ȯ�������ͱ�',
   'user', @CurrentUser, 'table', 'RVoucherShareType'
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BVoucherSharing')
            and   type = 'U')
   drop table BVoucherSharing
go

/*==============================================================*/
/* Table: BVoucherSharing                                       */
/*==============================================================*/
create table BVoucherSharing (
   VSR_ID               int                  identity(1,1),
   VSR_CSV_ID           int                  not null,
   VSR_START_SHARE_TIME datetime             not null,
   VSR_END_SHARE_TIME   datetime             not null,
   VSR_VST_ID           int                  not null,
   VSR_SHARE_QTY        int                  not null,
   VSR_CREATIONUID      varchar(50)          null,
   VSR_CREATION_DT      datetime             not null default getdate(),
   constraint PK_BVOUCHERSHARING primary key (VSR_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'ȯ�����',
   'user', @CurrentUser, 'table', 'BVoucherSharing'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '�������ȯ��ID',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_CSV_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '����ʼʱ��',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_START_SHARE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '�������ʱ�䣨��������ʱ��󣬼�ʹȯû�б���ȡ�꣬���ں�Ҳ��������ȡ��Ҳ���ܻ��أ�',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_END_SHARE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '�������ͣ�һ��һ����[����ȯ��]��ƽ���֣�����ֵȣ�',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_VST_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '������������һ��ȯ������Ϊ���ٷݣ�����ȯΪ1��ƽ���ֺ��������Ҫָ������',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_SHARE_QTY'
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LVsrCsv')
            and   type = 'U')
   drop table LVsrCsv
go

/*==============================================================*/
/* Table: LVsrCsv                                               */
/*==============================================================*/
create table LVsrCsv (
   LRV_VSR_ID           int                  not null,
   LRV_CSV_ID           int                  not null,
   constraint PK_LVSRCSV primary key (LRV_VSR_ID, LRV_CSV_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'ȯ�����ϵ��',
   'user', @CurrentUser, 'table', 'LVsrCsv'
go
