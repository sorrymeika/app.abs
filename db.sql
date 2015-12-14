select * from BMessage order by MSG_ID desc


select CSV_USE_FLAG from 


select * from WFree join LFreCnl on LFC_FRE_ID=FRE_ID
select * from LPspFre

update BPurchase set PUR_PSP_ID=86
update XProspect set XPS_EFFICTIVE_AMOUNT=1000,XPS_END_FREE_DT='2016-10-09',XPS_START_FREE_DT='2015-05-09' where XPS_PSP_ID=86

update XProspect set XPS_AVAILABLEPOINTS=1000 where XPS_PSP_ID=86

select * from BCashVoucher
update BCashVoucher set CSV_PSP_ID=86


select XPS_START_FREE_DT,XPS_END_FREE_DT from XProspect where XPS_PSP_ID=59
select Top 1 FRE_NAME,FRE_TITLE_PIC,FRE_PIC1,LPF_PUR_ID from WFree join LFreCnl on LFC_FRE_ID=FRE_ID left join (select LPF_PUR_ID,LPF_FRE_ID from LPspFre where LPF_PSP_ID=59) a on LPF_FRE_ID=FRE_ID where FRE_FRT_ID=1 and LFC_CNL_ID=1 and GETDATE() between LFC_START_TIME and LFC_END_TIME

update XPurchase set XPU_EXPRESS_CODE='asdfasdf'

select * from BProspect
select * from XProspect

select * from BPurchase
select * from XPurchase
select * from RPayStatus
select * from RPurchaseStatus

select * from WProductPicture


select * from BCashVoucher
update BCashVoucher set CSV_PSP_ID= 59

select * from RVoucherType

select * from RPointOperationType

select * from RPointType

select * from HPoint
update HPoint set HPT_PSP_ID= 59
select * from RPointType

update XProspect set XPS_TOTAL_AMOUNT=1001,XPS_AVAILABLEPOINTS=100

select * from BChannel
select * From RChannelType

select * from WFree join LFreCnl on LFC_FRE_ID=FRE_ID where FRE_FRT_ID=1
select * from LFrePrd

create table BPostMessage(
MSG_ID int identity primary key,
MSG_TITLE varchar(100),
MSG_CONTENT varchar(500),
MSG_DT datetime,
MSG_RMT_ID int,
MSG_CREATION_DT datetime,
MSG_CREATIONUID varchar(50)
)
create table RMessageType (
RMT_ID int primary key,
RMT_DESC varchar(20)
)
insert into RMessageType values (1,'APP')

create table LPspMsg (
LPM_ID int identity primary key,
LPM_MSG_ID int,
LPM_PSP_ID int,
LPM_STATUS int
)

select COUNT(1) from BPostMessage where not exists (select 1 from LPspMsg where LPM_PSP_ID=59 and MSG_ID=LPM_MSG_ID)

select MSG_ID,MSG_TITLE,MSG_CONTENT,MSG_DT from BPostMessage left join LPspMsg on MSG_ID=LPM_MSG_ID where MSG_DT>GETDATE()

select * from XChannel 

update XChannel set XCL_ADDRESS='上海市松江区新松江路927弄开元地中海商业广场3F3050',XCL_PHONE='021-37699007'

update BChannel set CNL_CLT_ID=1

alter table XChannel add XCL_ADDRESS nvarchar(200)
alter table XChannel add  XCL_PHONE varchar(20)


create table BVoucherDispatcher(
VDP_ID int primary key,
VDP_VCA_ID int,
VDP_DESC nvarchar(400),
VDP_MESSAGE nvarchar(1000),
VDP_VALID_FLAG bit
)

insert into BVoucherDispatcher (VDP_ID,VDP_VCA_ID,VDP_DESC,VDP_MESSAGE,VDP_VALID_FLAG) values (1,13,'首次安装xxx','首次安装xxx',1)

select * from BVoucherActivity

select * from RVoucherType 

alter table BMessage add MSG_ALL_FLAG bit

alter table BCashVoucher add CSV_VDP_ID int

insert into BMessage (MSG_RMT_ID,MSG_ALL_FLAG,MSG_TITLE,MSG_CONTENT,MSG_START_DT,MSG_END_DT) values (5,0,@p0,@p1,@p2,@p3)

select * from BMessage

select * from LPspMsg

alter table HPoint add HPT_CNL_ID int

alter table LFreCnl add FRE_MOBILE_PIC1 varchar(255)
alter table LFreCnl add FRE_MOBILE_PIC2 varchar(255)


