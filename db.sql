select * from BMessage order by MSG_ID desc

select * from BProspect
select * from XProspect

select * from BPurchase
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
LPM_PSP_ID int
)

select COUNT(1) from BPostMessage where not exists (select 1 from LPspMsg where LPM_PSP_ID=59 and MSG_ID=LPM_MSG_ID)

select MSG_ID,MSG_TITLE,MSG_CONTENT,MSG_DT from BPostMessage left join LPspMsg on MSG_ID=LPM_MSG_ID where MSG_DT>GETDATE()