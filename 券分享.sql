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
   '券分享类型表',
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
   '券分享表',
   'user', @CurrentUser, 'table', 'BVoucherSharing'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '被分享的券的ID',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_CSV_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分享开始时间',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_START_SHARE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分享结束时间（超过结束时间后，即使券没有被领取完，过期后也不能再领取，也不能还回）',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_END_SHARE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分享类型（一对一分享[包邮券等]，平均分，随机分等）',
   'user', @CurrentUser, 'table', 'BVoucherSharing', 'column', 'VSR_VST_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分享数量，即一张券分享后变为多少份；包邮券为1，平均分和随机分需要指定数量',
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
   '券分享关系表',
   'user', @CurrentUser, 'table', 'LVsrCsv'
go
