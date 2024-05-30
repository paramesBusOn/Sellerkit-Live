// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, prefer_conditional_assignment, unused_import
import 'dart:developer';
import 'dart:isolate';
import 'package:sellerkit/DBModel/AuthorizationDB.dart';
import 'package:sellerkit/DBModel/DayStartTableModel.dart';
import 'package:sellerkit/DBModel/SiteCheckInTableModel.dart';
import 'package:sellerkit/DBModel/TestDbmodel1.dart';
import 'package:sellerkit/DBModel/enquiry_filterdbmodel.dart';
import 'package:sellerkit/DBModel/lead_filterdbmodel.dart';
import 'package:sellerkit/DBModel/leadopenDBmodel.dart';
import 'package:sellerkit/DBModel/openlead_filterdbmodel.dart';
import 'package:sellerkit/DBModel/order_filterdbmodel.dart';
import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
import 'package:sellerkit/DBModel/outstandinglinechild.dart';
import 'package:sellerkit/DBModel/stateDBModel.dart';
import 'package:sellerkit/DBModel/testdbmodel2.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../DBModel/CustomerModel.dart';
import '../DBModel/EnqTypeModel.dart';
import '../DBModel/ItemMasertDBModel.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/QuotFilterTableModel.dart';
import '../DBModel/ScreenShotModel.dart';
import '../Models/OfferZone/OfferZoneModel.dart';
import '../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';

class DBHelper {
  static Database? _db;

  DBHelper._() {}
  static Future<Database?> getInstance() async {
    String path = await getDatabasesPath();
    if (_db == null) {
      _db = await openDatabase(join(path, 'SellerKit2.db'),
          version: 1, onCreate: createTable);
    }
    return _db;
  }

  static void createTable(Database database, int version) async {
    await database.execute(
        '''
           create table $tableItemMaster(
             IMId integer primary key autoincrement,
             ${ItemMasterColumns.id} integer ,
             ${ItemMasterColumns.itemCode} varchar ,
             ${ItemMasterColumns.itemName} varchar ,
             ${ItemMasterColumns.brand} varchar ,
             ${ItemMasterColumns.segment} varchar ,
             ${ItemMasterColumns.category} varchar ,
             ${ItemMasterColumns.division} varchar ,
             ${ItemMasterColumns.favorite} varchar ,
             ${ItemMasterColumns.isselected} integer ,
             ${ItemMasterColumns.mgrPrice} decimal ,
             ${ItemMasterColumns.slpPrice} decimal ,
             ${ItemMasterColumns.whsStock} decimal ,
             ${ItemMasterColumns.storeStock} decimal ,
             ${ItemMasterColumns.refreshedRecordDate} varchar ,
             ${ItemMasterColumns.itemDescription} varchar ,
             ${ItemMasterColumns.modelNo} varchar ,
             ${ItemMasterColumns.partCode} varchar ,
             ${ItemMasterColumns.skucode} varchar ,
             ${ItemMasterColumns.brandCode} varchar ,
             ${ItemMasterColumns.itemGroup} varchar ,
             ${ItemMasterColumns.specification} varchar ,
             ${ItemMasterColumns.sizeCapacity} varchar ,
             ${ItemMasterColumns.clasification} varchar ,
             ${ItemMasterColumns.uoM} varchar ,
             ${ItemMasterColumns.taxRate} int ,
             ${ItemMasterColumns.catalogueUrl1} varchar ,
             ${ItemMasterColumns.catalogueUrl2} varchar ,
             ${ItemMasterColumns.imageUrl1} varchar ,
             ${ItemMasterColumns.imageUrl2} varchar ,
             ${ItemMasterColumns.textNote} varchar ,
             ${ItemMasterColumns.status} varchar ,
             ${ItemMasterColumns.movingType} varchar ,
             ${ItemMasterColumns.eol} varchar ,
             ${ItemMasterColumns.veryFast} varchar ,
             ${ItemMasterColumns.fast} varchar ,
             ${ItemMasterColumns.slow} varchar ,
             ${ItemMasterColumns.verySlow} varchar ,
             ${ItemMasterColumns.serialNumber} varchar ,
             ${ItemMasterColumns.priceStockId} int ,
             ${ItemMasterColumns.storeCode} varchar ,
             ${ItemMasterColumns.whseCode} varchar ,
             ${ItemMasterColumns.sp} decimal ,
             ${ItemMasterColumns.ssp1} decimal ,
             ${ItemMasterColumns.ssp2} decimal ,
             ${ItemMasterColumns.ssp3} decimal ,
             ${ItemMasterColumns.ssp4} decimal ,
             ${ItemMasterColumns.ssp5} decimal ,
             ${ItemMasterColumns.ssp1Inc} decimal ,
             ${ItemMasterColumns.ssp2Inc} decimal ,
             ${ItemMasterColumns.ssp3Inc} decimal ,
             ${ItemMasterColumns.ssp4Inc} decimal ,
             ${ItemMasterColumns.ssp5Inc} decimal ,
             ${ItemMasterColumns.allowNegativeStock} varchar ,
             ${ItemMasterColumns.allowOrderBelowCost} varchar ,
             ${ItemMasterColumns.isFixedPrice} varchar ,
             ${ItemMasterColumns.validTill} varchar ,
             ${ItemMasterColumns.color} varchar ,
             ${ItemMasterColumns.calcType} varchar ,
             ${ItemMasterColumns.payOn} varchar 
             
             )
        ''');
    await database.execute(
        '''
           create table $tableEnqType(
             ETId integer primary key autoincrement,
             ${EnqTypeDBModel.code} varchar ,
             ${EnqTypeDBModel.name} varchar 
             )
        ''');
         await database.execute(
        '''
           create table $tableEnquiryfilter(
             ETId integer primary key autoincrement,
             ${EnquiryfilterDBcolumns.enqID} int,
             ${EnquiryfilterDBcolumns.enquiredOn} varchar ,
             ${EnquiryfilterDBcolumns.cardCode} varchar ,
             ${EnquiryfilterDBcolumns.cardName} varchar ,
             ${EnquiryfilterDBcolumns.enqDate} varchar ,
             ${EnquiryfilterDBcolumns.followup} varchar ,
             ${EnquiryfilterDBcolumns.status} varchar ,
             ${EnquiryfilterDBcolumns.mgrUserCode} varchar ,
             ${EnquiryfilterDBcolumns.mgrUserName} varchar ,
             ${EnquiryfilterDBcolumns.assignedToUser} varchar ,
             ${EnquiryfilterDBcolumns.assignedToUserName} varchar ,
             ${EnquiryfilterDBcolumns.enqType} varchar ,
             ${EnquiryfilterDBcolumns.lookingfor} varchar ,
             ${EnquiryfilterDBcolumns.potentialValue} decimal ,
             ${EnquiryfilterDBcolumns.addressLine1} varchar ,
             ${EnquiryfilterDBcolumns.addressLine2} varchar ,
             ${EnquiryfilterDBcolumns.pincode} varchar ,
             ${EnquiryfilterDBcolumns.city} varchar ,
             ${EnquiryfilterDBcolumns.state} varchar ,
             ${EnquiryfilterDBcolumns.country} varchar ,
             ${EnquiryfilterDBcolumns.managerStatusTab} varchar ,
             ${EnquiryfilterDBcolumns.slpStatusTab} varchar ,
             ${EnquiryfilterDBcolumns.email} varchar ,
             ${EnquiryfilterDBcolumns.referal} varchar ,
             ${EnquiryfilterDBcolumns.contactName} varchar ,
             ${EnquiryfilterDBcolumns.altermobileNo} varchar ,
             ${EnquiryfilterDBcolumns.customerGroup} varchar ,
             ${EnquiryfilterDBcolumns.customermobile} varchar ,
             ${EnquiryfilterDBcolumns.comapanyname} varchar ,
             ${EnquiryfilterDBcolumns.storecode} varchar ,
             ${EnquiryfilterDBcolumns.area} varchar ,
             ${EnquiryfilterDBcolumns.district} varchar ,
             ${EnquiryfilterDBcolumns.itemCode} varchar ,
             ${EnquiryfilterDBcolumns.itemname} varchar ,
             ${EnquiryfilterDBcolumns.enquirydscription} varchar ,
             ${EnquiryfilterDBcolumns.quantity} decimal ,
             ${EnquiryfilterDBcolumns.isVisitRequired} varchar ,
             ${EnquiryfilterDBcolumns.visitTime} varchar ,
             ${EnquiryfilterDBcolumns.remindOn} varchar ,
             ${EnquiryfilterDBcolumns.isClosed} varchar ,
             ${EnquiryfilterDBcolumns.leadConverted} varchar ,
             ${EnquiryfilterDBcolumns.createdBy} int ,
             ${EnquiryfilterDBcolumns.createdDateTime} varchar ,
             ${EnquiryfilterDBcolumns.updatedBy} int ,
             ${EnquiryfilterDBcolumns.updatedDateTime} varchar ,
             ${EnquiryfilterDBcolumns.interestLevel} varchar ,
             ${EnquiryfilterDBcolumns.orderType} varchar
             
             )
        ''');
        await database.execute('''
           create table $QuotFilterTable(
             ${QuotFilterDBTable.custName} varchar ,
             ${QuotFilterDBTable.assignTo} varchar ,
             ${QuotFilterDBTable.orderNum} varchar ,
             ${QuotFilterDBTable.product} varchar ,
             ${QuotFilterDBTable.quotDate} varchar ,
             ${QuotFilterDBTable.OrderStatus} varchar ,
             ${QuotFilterDBTable.orderType} varchar,
             ${QuotFilterDBTable.docTotal} decimal, 
           ${QuotFilterDBTable.AttachURL1} varchar,  
${QuotFilterDBTable.AttachURL2} varchar , 
${QuotFilterDBTable.AttachURL3} varchar , 
${QuotFilterDBTable.BaseDocDate} varchar , 
${QuotFilterDBTable.BaseID}    varchar , 
${QuotFilterDBTable.BaseType} varchar , 
${QuotFilterDBTable.CurrentStatus} varchar , 
${QuotFilterDBTable.DealID} varchar , 
${QuotFilterDBTable.Del_Address1} varchar , 
${QuotFilterDBTable.Del_Address2} varchar , 
${QuotFilterDBTable.Del_Address3} varchar , 
${QuotFilterDBTable.Del_Area} varchar , 
${QuotFilterDBTable.Del_City} varchar , 
${QuotFilterDBTable.Del_Country} varchar , 
${QuotFilterDBTable.Del_State} varchar , 
${QuotFilterDBTable.Del_Pincode} varchar , 
${QuotFilterDBTable.Discount} varchar , 
${QuotFilterDBTable.FollowupEntry} varchar , 
${QuotFilterDBTable.GrossTotal} varchar ,
${QuotFilterDBTable.LastUpdateMessage} varchar ,
${QuotFilterDBTable.Mobile} varchar ,
${QuotFilterDBTable.LastUpdateTime} varchar ,
${QuotFilterDBTable.OrderDocEntry} varchar ,
${QuotFilterDBTable.RoundOff} varchar ,
${QuotFilterDBTable.StoreCode} varchar ,
${QuotFilterDBTable.bil_Address1} varchar ,
${QuotFilterDBTable.bil_Address2} varchar ,
${QuotFilterDBTable.bil_Address3} varchar ,
${QuotFilterDBTable.bil_Area} varchar ,
${QuotFilterDBTable.bil_City} varchar ,
${QuotFilterDBTable.bil_Country} varchar ,
${QuotFilterDBTable.bil_State} varchar ,
${QuotFilterDBTable.bil_Pincode} varchar ,
${QuotFilterDBTable.paymentDueDate} varchar ,
${QuotFilterDBTable.pAN} varchar ,
${QuotFilterDBTable.leadid} varchar ,
${QuotFilterDBTable.isDelivered} varchar ,
${QuotFilterDBTable.isInvoiced} varchar ,
${QuotFilterDBTable.companyName} varchar ,
${QuotFilterDBTable.contactName} varchar ,
${QuotFilterDBTable.gSTNo} varchar ,
${QuotFilterDBTable.createdon} varchar ,
${QuotFilterDBTable.enqid} varchar ,
  ${QuotFilterDBTable.lastUpdatedDate} varchar 
             )
        ''');
         await database.execute(
        '''
           create table $tableorderfilter(
             ETId integer primary key autoincrement,
             ${OrderfilterDBcolumns.orderDocEntry} int,
             ${OrderfilterDBcolumns.followupEntry} int ,
             ${OrderfilterDBcolumns.orderNum} int ,
             ${OrderfilterDBcolumns.deliveryDueDate} varchar ,
             ${OrderfilterDBcolumns.paymentDueDate} varchar ,
             ${OrderfilterDBcolumns.alternateMobileNo} varchar ,
             ${OrderfilterDBcolumns.contactName} varchar ,
             ${OrderfilterDBcolumns.customerEmail} varchar ,
             ${OrderfilterDBcolumns.companyName} varchar ,
             ${OrderfilterDBcolumns.pAN} varchar ,
             ${OrderfilterDBcolumns.gSTNo} varchar ,
             ${OrderfilterDBcolumns.customerPORef} varchar ,
             ${OrderfilterDBcolumns.bil_Address1} varchar ,
             ${OrderfilterDBcolumns.bil_Address2} varchar ,
             ${OrderfilterDBcolumns.bil_Address3} varchar ,
             ${OrderfilterDBcolumns.bil_Area} varchar ,
             ${OrderfilterDBcolumns.bil_City} varchar ,
             ${OrderfilterDBcolumns.bil_District} varchar ,
             ${OrderfilterDBcolumns.bil_State} varchar ,
             ${OrderfilterDBcolumns.bil_Country} varchar ,
             ${OrderfilterDBcolumns.bil_Pincode} varchar ,
             ${OrderfilterDBcolumns.del_Address1} varchar ,
             ${OrderfilterDBcolumns.del_Address2} varchar ,
             ${OrderfilterDBcolumns.del_Address3} varchar ,
             ${OrderfilterDBcolumns.Del_Area} varchar ,
             ${OrderfilterDBcolumns.del_City} varchar ,
             ${OrderfilterDBcolumns.del_District} varchar ,
             ${OrderfilterDBcolumns.del_State} varchar ,
             ${OrderfilterDBcolumns.del_Country} varchar ,
             ${OrderfilterDBcolumns.del_Pincode} varchar ,
             ${OrderfilterDBcolumns.storeCode} varchar ,
             ${OrderfilterDBcolumns.assignedTo} varchar ,
             ${OrderfilterDBcolumns.deliveryFrom} varchar ,
             ${OrderfilterDBcolumns.orderStatus} varchar ,
             ${OrderfilterDBcolumns.currentStatus} varchar ,
             ${OrderfilterDBcolumns.dealID} varchar ,
             ${OrderfilterDBcolumns.baseID} int ,
             ${OrderfilterDBcolumns.baseType} varchar ,
             ${OrderfilterDBcolumns.baseDocDate} varchar ,
             ${OrderfilterDBcolumns.grossTotal} decimal ,
             ${OrderfilterDBcolumns.subTotal} decimal ,
             ${OrderfilterDBcolumns.discount} decimal ,
             ${OrderfilterDBcolumns.taxAmount} decimal ,
             ${OrderfilterDBcolumns.roundOff} decimal ,
             ${OrderfilterDBcolumns.attachURL1} varchar ,
             ${OrderfilterDBcolumns.attachURL2} varchar ,
             ${OrderfilterDBcolumns.status} varchar ,
             ${OrderfilterDBcolumns.attachURL3} varchar ,
             ${OrderfilterDBcolumns.mobile} varchar,
             ${OrderfilterDBcolumns.customerName} varchar,
             ${OrderfilterDBcolumns.docDate} varchar,
             ${OrderfilterDBcolumns.product} varchar,
             ${OrderfilterDBcolumns.createdon} varchar,
             ${OrderfilterDBcolumns.value} decimal,
             ${OrderfilterDBcolumns.lastUpdateMessage} varchar,
             ${OrderfilterDBcolumns.lastUpdateTime} varchar,
             ${OrderfilterDBcolumns.enqid} varchar,
             ${OrderfilterDBcolumns.leadid} varchar,
             ${OrderfilterDBcolumns.isDelivered} int,
             ${OrderfilterDBcolumns.isInvoiced} int,
             ${OrderfilterDBcolumns.orderType} varchar,
             ${OrderfilterDBcolumns.customerGroup} varchar
             
             )
        ''');
         await database.execute(
        '''
           create table $tableLeadfilter(
             ETId integer primary key autoincrement,
             ${LeadfilterDBcolumns.leadDocEntry} int,
             ${LeadfilterDBcolumns.followupEntry} int ,
             ${LeadfilterDBcolumns.leadNum} int ,
             ${LeadfilterDBcolumns.mobile} varchar ,
             ${LeadfilterDBcolumns.customerName} varchar ,
             ${LeadfilterDBcolumns.docDate} varchar ,
             ${LeadfilterDBcolumns.city} varchar ,
             ${LeadfilterDBcolumns.nextFollowup} varchar ,
             ${LeadfilterDBcolumns.product} varchar ,
             ${LeadfilterDBcolumns.value} decimal ,
             ${LeadfilterDBcolumns.status} varchar ,
             ${LeadfilterDBcolumns.lastUpdateMessage} varchar ,
             ${LeadfilterDBcolumns.lastUpdateTime} varchar ,
             ${LeadfilterDBcolumns.customermob} varchar ,
             ${LeadfilterDBcolumns.cusEmail} varchar ,
             ${LeadfilterDBcolumns.companyname} varchar ,
             ${LeadfilterDBcolumns.cusgroup} varchar ,
             ${LeadfilterDBcolumns.storecode} varchar ,
             ${LeadfilterDBcolumns.add1} varchar ,
             ${LeadfilterDBcolumns.add2} varchar ,
             ${LeadfilterDBcolumns.area} varchar ,
             ${LeadfilterDBcolumns.district} varchar ,
             ${LeadfilterDBcolumns.state} varchar ,
             ${LeadfilterDBcolumns.country} varchar ,
             ${LeadfilterDBcolumns.pincode} varchar ,
             ${LeadfilterDBcolumns.gender} varchar ,
             ${LeadfilterDBcolumns.agegroup} varchar ,
             ${LeadfilterDBcolumns.cameAs} varchar ,
             ${LeadfilterDBcolumns.headcount} int ,
             ${LeadfilterDBcolumns.maxbudget} decimal ,
             ${LeadfilterDBcolumns.assignedTo} varchar ,
             ${LeadfilterDBcolumns.refferal} varchar ,
             ${LeadfilterDBcolumns.purchasePlan} varchar ,
             ${LeadfilterDBcolumns.dealDescription} varchar ,
             ${LeadfilterDBcolumns.lastFollowupDate} varchar ,
             ${LeadfilterDBcolumns.createdBy} int ,
             ${LeadfilterDBcolumns.createdDate} varchar ,
             ${LeadfilterDBcolumns.updatedBy} int ,
             ${LeadfilterDBcolumns.updatedDate} varchar ,
             ${LeadfilterDBcolumns.traceId} varchar ,
             ${LeadfilterDBcolumns.isselected} int ,
             ${LeadfilterDBcolumns.interestLevel} varchar ,
             ${LeadfilterDBcolumns.orderType} varchar
             
             )
        ''');

         await database.execute(
        '''
           create table $tableopenLeadfilter(
             ETId integer primary key autoincrement,
             ${OpenLeadfilterDBcolumns.leadDocEntry} int,
             ${OpenLeadfilterDBcolumns.followupEntry} int ,
             ${OpenLeadfilterDBcolumns.leadNum} int ,
             ${OpenLeadfilterDBcolumns.mobile} varchar ,
             ${OpenLeadfilterDBcolumns.customerName} varchar ,
             ${OpenLeadfilterDBcolumns.docDate} varchar ,
             ${OpenLeadfilterDBcolumns.city} varchar ,
             ${OpenLeadfilterDBcolumns.nextFollowup} varchar ,
             ${OpenLeadfilterDBcolumns.product} varchar ,
             ${OpenLeadfilterDBcolumns.value} decimal ,
             ${OpenLeadfilterDBcolumns.status} varchar ,
             ${OpenLeadfilterDBcolumns.lastUpdateMessage} varchar ,
             ${OpenLeadfilterDBcolumns.lastUpdateTime} varchar ,
             ${OpenLeadfilterDBcolumns.customermob} varchar ,
             ${OpenLeadfilterDBcolumns.cusEmail} varchar ,
             ${OpenLeadfilterDBcolumns.companyname} varchar ,
             ${OpenLeadfilterDBcolumns.cusgroup} varchar ,
             ${OpenLeadfilterDBcolumns.storecode} varchar ,
             ${OpenLeadfilterDBcolumns.add1} varchar ,
             ${OpenLeadfilterDBcolumns.add2} varchar ,
             ${OpenLeadfilterDBcolumns.area} varchar ,
             ${OpenLeadfilterDBcolumns.district} varchar ,
             ${OpenLeadfilterDBcolumns.state} varchar ,
             ${OpenLeadfilterDBcolumns.country} varchar ,
             ${OpenLeadfilterDBcolumns.pincode} varchar ,
             ${OpenLeadfilterDBcolumns.gender} varchar ,
             ${OpenLeadfilterDBcolumns.agegroup} varchar ,
             ${OpenLeadfilterDBcolumns.cameAs} varchar ,
             ${OpenLeadfilterDBcolumns.headcount} int ,
             ${OpenLeadfilterDBcolumns.maxbudget} decimal ,
             ${OpenLeadfilterDBcolumns.assignedTo} varchar ,
             ${OpenLeadfilterDBcolumns.refferal} varchar ,
             ${OpenLeadfilterDBcolumns.purchasePlan} varchar ,
             ${OpenLeadfilterDBcolumns.dealDescription} varchar ,
             ${OpenLeadfilterDBcolumns.lastFollowupDate} varchar ,
             ${OpenLeadfilterDBcolumns.createdBy} int ,
             ${OpenLeadfilterDBcolumns.createdDate} varchar ,
             ${OpenLeadfilterDBcolumns.updatedBy} int ,
             ${OpenLeadfilterDBcolumns.updatedDate} varchar ,
             ${OpenLeadfilterDBcolumns.traceId} varchar ,
            
             ${OpenLeadfilterDBcolumns.interestLevel} varchar ,
             ${OpenLeadfilterDBcolumns.orderType} varchar
             
             )
        ''');


    await database.execute(
        '''
           create table $tableCusTagType(
             ETId integer primary key autoincrement,
             ${CusTagTypeDBModel.code} varchar ,
             ${CusTagTypeDBModel.name} varchar 
             )
        ''');
        await database.execute(
        '''
           create table $tableLevelof(
             ETId integer primary key autoincrement,
             ${CusLevelDBModel.code} varchar ,
             ${CusLevelDBModel.name} varchar 
             )
        ''');
        await database.execute(
        '''
           create table $tableOrderType(
             ETId integer primary key autoincrement,
             ${OrderTypeDBModel.code} varchar ,
             ${OrderTypeDBModel.name} varchar 
             )
        ''');
        
    await database.execute(
        '''
           create table $tableitemlist1(
             ${ItemlistdbColumns1.id} integer ,
             ${ItemlistdbColumns1.itemName} varchar,
             ${ItemlistdbColumns1.itemCode} varchar,
             ${ItemlistdbColumns1.brand} varchar,
             ${ItemlistdbColumns1.category} varchar,
             ${ItemlistdbColumns1.subCategory} varchar,
             ${ItemlistdbColumns1.itemDescription} varchar,
             ${ItemlistdbColumns1.modelNo} varchar,
             ${ItemlistdbColumns1.partCode} varchar,
             ${ItemlistdbColumns1.skucode} varchar,
             ${ItemlistdbColumns1.brandCode} varchar,
             ${ItemlistdbColumns1.itemGroup} varchar,
             ${ItemlistdbColumns1.specification} varchar,
             ${ItemlistdbColumns1.sizeCapacity} varchar,
             ${ItemlistdbColumns1.color} varchar,
             ${ItemlistdbColumns1.clasification} varchar,
             ${ItemlistdbColumns1.uoM} varchar,
             ${ItemlistdbColumns1.taxRate} varchar,
             ${ItemlistdbColumns1.textNote} varchar,
             ${ItemlistdbColumns1.catalogueUrl1} varchar,
             ${ItemlistdbColumns1.catalogueUrl2} varchar,
             ${ItemlistdbColumns1.imageUrl1} varchar,
             ${ItemlistdbColumns1.imageUrl2} varchar,
             ${ItemlistdbColumns1.status} varchar,
             ${ItemlistdbColumns1.movingType} varchar,
             ${ItemlistdbColumns1.eol} varchar,
             ${ItemlistdbColumns1.updatedBy} varchar,
             ${ItemlistdbColumns1.createdDateTime} varchar,
             ${ItemlistdbColumns1.updateDateTime} varchar,
             ${ItemlistdbColumns1.lastUpdatedIp} varchar,
             ${ItemlistdbColumns1.veryFast} varchar,
             ${ItemlistdbColumns1.fast} varchar,
             ${ItemlistdbColumns1.slow} varchar,
             ${ItemlistdbColumns1.verySlow} varchar,
             ${ItemlistdbColumns1.createdBy} varchar,
             ${ItemlistdbColumns1.serialNumber} varchar
             )
        ''');
    await database.execute(
        '''
           create table $tableitemlist2(
             ${ItemlistdbColumns2.id} integer ,
             ${ItemlistdbColumns2.itemCode} varchar,
             ${ItemlistdbColumns2.storeCode} varchar,
             ${ItemlistdbColumns2.whseCode} varchar,
             ${ItemlistdbColumns2.storeStock} decimal,
             ${ItemlistdbColumns2.whseStock} decimal,
             ${ItemlistdbColumns2.mrp} decimal,
             ${ItemlistdbColumns2.cost} decimal,
             ${ItemlistdbColumns2.sp} decimal,
             ${ItemlistdbColumns2.ssp1} decimal,
             ${ItemlistdbColumns2.ssp2} decimal,
             ${ItemlistdbColumns2.ssp3} decimal,
             ${ItemlistdbColumns2.ssp4} varchar,
             ${ItemlistdbColumns2.ssp5} varchar,
             ${ItemlistdbColumns2.spInc} varchar,
             ${ItemlistdbColumns2.ssp1Inc} varchar,
             ${ItemlistdbColumns2.ssp2Inc} varchar,
             ${ItemlistdbColumns2.ssp3Inc} varchar,
             ${ItemlistdbColumns2.ssp4Inc} varchar,
             ${ItemlistdbColumns2.ssp5Inc} varchar,
             ${ItemlistdbColumns2.allowNegativeStock} varchar,
             ${ItemlistdbColumns2.allowOrderBelowCost} varchar,
             ${ItemlistdbColumns2.isFixedPrice} varchar,
             ${ItemlistdbColumns2.validTill} varchar,
             ${ItemlistdbColumns2.createdBy} integer,
             ${ItemlistdbColumns2.createdDateTime} varchar,
             ${ItemlistdbColumns2.updatedBy} integer,
             ${ItemlistdbColumns2.updatedDateTime} varchar
             
             )
        ''');
    await database.execute(
        '''
           create table $tableEnqReffers(
             ERId integer primary key autoincrement,
             ${EnqReffersDBModel.code} varchar ,
             ${EnqReffersDBModel.name} varchar 
             )
        ''');
    await database.execute(
        '''
           create table $tableUserList(
             UId integer primary key autoincrement,
             ${UserListDBModel.slpcode} varchar,
              ${UserListDBModel.managerSlp} varchar,
             ${UserListDBModel.userName} varchar ,
             ${UserListDBModel.userCode} varchar ,
             ${UserListDBModel.salesEmpID} integer ,
             ${UserListDBModel.color} integer ,
             ${UserListDBModel.storeid} integer 

             )
        ''');
    await database.execute(
        '''
           create table $tableLeadStatusReason(
             LRId integer primary key autoincrement,
             ${LeadStatusReason.code} varchar ,
             ${LeadStatusReason.name} varchar ,
             ${LeadStatusReason.statusType} integer 
             )
        ''');
    await database.execute(
        '''
           create table $tableOrderStatusReason(
             LRId integer primary key autoincrement,
             ${OrderStatusReason.code} varchar ,
             ${OrderStatusReason.name} varchar ,
             ${OrderStatusReason.statusType} varchar 
             )
        ''');

    await database.execute(
        '''
           create table $tableOfferZone(
             OSZId integer primary key autoincrement,
             ${OfferZoneColumns.offerName} varchar ,
             ${OfferZoneColumns.offerZoneId} integer ,
             ${OfferZoneColumns.itemCode} varchar ,
             ${OfferZoneColumns.offerDetails} varchar ,
             ${OfferZoneColumns.mediaurl1} varchar ,
             ${OfferZoneColumns.mediaurl2} varchar ,
             ${OfferZoneColumns.incentive} varchar ,
             ${OfferZoneColumns.validTill} varchar 
            )
        ''');
    await database.execute(
        '''
           create table $tableOfferZonechild1(
             
             ${offerzoneColumnchild1.id} varchar,
             ${offerzoneColumnchild1.itemid} varchar,
             ${offerzoneColumnchild1.offerid} varchar,
             ${offerzoneColumnchild1.itemName} varchar,
             ${offerzoneColumnchild1.brand} varchar,
             ${offerzoneColumnchild1.category} varchar,
             ${offerzoneColumnchild1.subCategory} varchar,
             ${offerzoneColumnchild1.itemDescription} varchar
             
             
            )
        ''');

    await database.execute(
        '''
           create table $tableOfferZonechild2(
             
             ${offerzoneColumnchild2.id2} varchar ,
             ${offerzoneColumnchild2.offerId2} varchar ,
             ${offerzoneColumnchild2.storeId} varchar 
            
             
            )
        ''');
    await database.execute(
        '''
           create table $tableSiteCheckIn(
        CheckInId integer primary key autoincrement,
        ${SiteCheckInColumns.customer} varchar,
        ${SiteCheckInColumns.mobile} integer,
        ${SiteCheckInColumns.cantactName} varchar,
        ${SiteCheckInColumns.address1} varchar,
        ${SiteCheckInColumns.address2} varchar,
        ${SiteCheckInColumns.area} varchar,
        ${SiteCheckInColumns.city} varchar,
        ${SiteCheckInColumns.pincode} integer,
        ${SiteCheckInColumns.state} varchar,
        ${SiteCheckInColumns.siteType} varchar,
        ${SiteCheckInColumns.date} varchar,
        ${SiteCheckInColumns.time} varchar,
        ${SiteCheckInColumns.datetime} varchar,
         ${SiteCheckInColumns.purpose} varchar
             )
        ''');
    await database.execute(
        '''
           create table $tableDayStart(
        DayStartId integer primary key autoincrement,
        ${DayStartColumns.address} varchar,
        ${DayStartColumns.date} varchar,
        ${DayStartColumns.dayType} varchar,
        ${DayStartColumns.time} varchar
             )
        ''');

    await database.execute(
        '''
           create table $tableNotification(
             NId integer primary key autoincrement,
             ${Notification.docEntry} int ,
             ${Notification.title} varchar ,
             ${Notification.imgurl} varchar ,
             ${Notification.description} varchar ,
             ${Notification.receiveTime} varchar ,
             ${Notification.seenTime} varchar ,
             ${Notification.naviScn} varchar ,
             ${Notification.jobid} int 
             )
        ''');
    await database.execute(
        '''
           create table $tableOpenLead(
             OPLId integer primary key autoincrement,
             ${OpenLeadColumn.LeadDocEntry} int ,
             ${OpenLeadColumn.LeadDocNum} int ,
             ${OpenLeadColumn.FollowupEntry} int ,
             ${OpenLeadColumn.Branch} varchar ,
             ${OpenLeadColumn.BranchManager} varchar ,
             ${OpenLeadColumn.Brand} varchar ,
             ${OpenLeadColumn.CreateDate} varchar ,
             ${OpenLeadColumn.Customer} varchar ,
             ${OpenLeadColumn.CustomerInitialIcon} varchar ,
             ${OpenLeadColumn.Division} varchar ,
             ${OpenLeadColumn.DocTotal} numeric ,
             ${OpenLeadColumn.FollowupDate} varchar ,
             ${OpenLeadColumn.Followup_Due_Type} varchar ,
             ${OpenLeadColumn.GroupProperty} varchar ,
             ${OpenLeadColumn.GroupSegment} varchar ,
             ${OpenLeadColumn.ItemCode} varchar ,
             ${OpenLeadColumn.LastFollowupDate} varchar ,
             ${OpenLeadColumn.LastFollowupStatus} varchar ,
             ${OpenLeadColumn.LastFollowup_Feedback} varchar ,
             ${OpenLeadColumn.Phone} varchar ,
             ${OpenLeadColumn.Product} varchar ,
             ${OpenLeadColumn.Quantity} varchar ,
             ${OpenLeadColumn.RegionalManager} varchar ,
             ${OpenLeadColumn.SalesExecutive} varchar 
             )
        ''');
    await database.execute(
        '''
           create table $tableCustomerMaster(
             OPLId integer primary key autoincrement,
             ${CustomerMasterDB.id} int ,
             ${CustomerMasterDB.cardcode} varchar ,
             ${CustomerMasterDB.cardname} varchar ,
             ${CustomerMasterDB.mobile} varchar ,
             ${CustomerMasterDB.alterMobileno} varchar ,
             ${CustomerMasterDB.email} varchar ,
             ${CustomerMasterDB.gst} varchar ,
             ${CustomerMasterDB.address1} varchar ,
             ${CustomerMasterDB.address2} varchar ,
             ${CustomerMasterDB.city} varchar ,
             ${CustomerMasterDB.area} varchar ,
             ${CustomerMasterDB.state} varchar ,
             ${CustomerMasterDB.zipcode} varchar ,
             ${CustomerMasterDB.tag} varchar ,
             ${CustomerMasterDB.cantactName} varchar 
             )
        ''');
    await database.execute(
        '''
           create table $tableStateMaster(
             OPLId integer primary key autoincrement,
             ${StateMasterDB.statecode} varchar ,
             ${StateMasterDB.statename} varchar ,
             ${StateMasterDB.cuntrycode} varchar ,
             ${StateMasterDB.countryname} varchar 
             )
        ''');

    await database.execute(
        '''
           create table $tableScreenShot(
             SId integer primary key autoincrement,
             ${ScreenShotTab.Filepath} varchar ,
             ${ScreenShotTab.DateTime} varchar 
             )
        ''');
         await database.execute('''
           create table $loginverificationDB(
             SId integer primary key autoincrement,
             ${LoginVerificationDB.id} int ,
             ${LoginVerificationDB.code} varchar ,
             ${LoginVerificationDB.restrictionType} int ,
             ${LoginVerificationDB.restrictionData} varchar ,
            ${LoginVerificationDB.remarks} varchar 

             )
        ''');
    await database.execute(
        '''
           create table $tableoutstanding(
             SId integer primary key autoincrement,
             ${outsatandingDBcolumns.customerCode} varchar,
             ${outsatandingDBcolumns.customerName} varchar,
             ${outsatandingDBcolumns.customerMobile} varchar,
             ${outsatandingDBcolumns.alternateMobileNo} varchar,
             ${outsatandingDBcolumns.contactName} varchar,
             ${outsatandingDBcolumns.customerEmail} varchar,
             ${outsatandingDBcolumns.companyName} varchar,
             ${outsatandingDBcolumns.customerGroup} varchar,
             ${outsatandingDBcolumns.gstNo} varchar,
             ${outsatandingDBcolumns.storeCode} varchar,
             ${outsatandingDBcolumns.assignedTo} varchar,
             ${outsatandingDBcolumns.transAmount} decimal,
             ${outsatandingDBcolumns.penaltyAfterDue} decimal,
             ${outsatandingDBcolumns.collectionInc} decimal,
             ${outsatandingDBcolumns.amountPaid} decimal,
             ${outsatandingDBcolumns.balanceToPay} decimal
             )
        ''');

    await database.execute(
        '''
           create table $tableoutstandingline(
             SId integer primary key autoincrement,
             ${outsatandinglineDBcolumns.docentry} int,
             ${outsatandinglineDBcolumns.customerCode} varchar,
             ${outsatandinglineDBcolumns.customerName} varchar,
             ${outsatandinglineDBcolumns.customerMobile} varchar,
             ${outsatandinglineDBcolumns.alternateMobileNo} varchar,
             ${outsatandinglineDBcolumns.contactName} varchar,
             ${outsatandinglineDBcolumns.customerEmail} varchar,
             ${outsatandinglineDBcolumns.companyName} varchar,
             ${outsatandinglineDBcolumns.customerGroup} varchar,
             ${outsatandinglineDBcolumns.gstNo} varchar,
             ${outsatandinglineDBcolumns.customerPORef} varchar,
             ${outsatandinglineDBcolumns.bil_Address1} varchar,
             ${outsatandinglineDBcolumns.bil_Address2} varchar,
             ${outsatandinglineDBcolumns.bil_Address3} varchar,
             ${outsatandinglineDBcolumns.bil_Area} varchar,
             ${outsatandinglineDBcolumns.bil_City} varchar,
             ${outsatandinglineDBcolumns.bil_District} varchar,
             ${outsatandinglineDBcolumns.bil_State} varchar,
             ${outsatandinglineDBcolumns.bil_Country} varchar,
             ${outsatandinglineDBcolumns.bil_Pincode} varchar,
             ${outsatandinglineDBcolumns.storeCode} varchar,
             ${outsatandinglineDBcolumns.assignedTo} varchar,
             ${outsatandinglineDBcolumns.transNum} varchar,
             ${outsatandinglineDBcolumns.transDate} varchar,
             ${outsatandinglineDBcolumns.transDueDate} varchar,
             ${outsatandinglineDBcolumns.transType} varchar,
             ${outsatandinglineDBcolumns.transRef1} varchar,
             ${outsatandinglineDBcolumns.loanRef} varchar,
             ${outsatandinglineDBcolumns.collectionType} varchar,
             ${outsatandinglineDBcolumns.transAmount} decimal,
             ${outsatandinglineDBcolumns.penaltyAfterDue} decimal,
             ${outsatandinglineDBcolumns.collectionInc} decimal,
             ${outsatandinglineDBcolumns.amountPaid} decimal,
             ${outsatandinglineDBcolumns.balanceToPay} decimal,
             ${outsatandinglineDBcolumns.status} varchar,
             ${outsatandinglineDBcolumns.createdBy} int,
             ${outsatandinglineDBcolumns.createdOn} varchar,
             ${outsatandinglineDBcolumns.updatedBy} int,
             ${outsatandinglineDBcolumns.updatedOn} varchar,
             ${outsatandinglineDBcolumns.traceid} varchar
            
            
             )
        ''');
  }

  // Future<Database> createDB() async {
  //   String path = await getDatabasesPath();
  //     // print("path: "+path);
  //   return
  // // db =
  //  await
  //    openDatabase(join(path, 'SellerKit2.db'),
  //       onCreate: (database, version) async {
  //     await database.execute('''
  //          create table $tableItemMaster(
  //            IMId integer primary key autoincrement,
  //            ${ItemMasterColumns.itemCode} varchar ,
  //            ${ItemMasterColumns.itemName} varchar ,
  //            ${ItemMasterColumns.brand} varchar ,
  //            ${ItemMasterColumns.segment} varchar ,
  //            ${ItemMasterColumns.category} varchar ,
  //            ${ItemMasterColumns.division} varchar ,
  //            ${ItemMasterColumns.favorite} varchar ,
  //            ${ItemMasterColumns.isselected} integer ,
  //            ${ItemMasterColumns.mgrPrice} decimal ,
  //            ${ItemMasterColumns.slpPrice} decimal ,
  //            ${ItemMasterColumns.whsStock} decimal ,
  //            ${ItemMasterColumns.storeStock} decimal ,
  //            ${ItemMasterColumns.refreshedRecordDate} varchar
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableEnqType(
  //            ETId integer primary key autoincrement,
  //            ${EnqTypeDBModel.code} integer ,
  //            ${EnqTypeDBModel.name} varchar
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableEnqReffers(
  //            ERId integer primary key autoincrement,
  //            ${EnqReffersDBModel.code} varchar ,
  //            ${EnqReffersDBModel.name} varchar
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableUserList(
  //            UId integer primary key autoincrement,
  //            ${UserListDBModel.userName} varchar ,
  //            ${UserListDBModel.salesEmpID} integer ,
  //            ${UserListDBModel.color} integer
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableLeadStatusReason(
  //            LRId integer primary key autoincrement,
  //            ${LeadStatusReason.code} varchar ,
  //            ${LeadStatusReason.name} varchar ,
  //            ${LeadStatusReason.statusType} varchar
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableOfferZone(
  //            OSZId integer primary key autoincrement,
  //            ${OfferZoneColumns.offerName} varchar ,
  //            ${OfferZoneColumns.offerZoneId} integer ,
  //            ${OfferZoneColumns.itemCode} varchar ,
  //            ${OfferZoneColumns.offerDetails} varchar ,
  //            ${OfferZoneColumns.item} varchar ,
  //            ${OfferZoneColumns.discoutDetails} varchar ,
  //            ${OfferZoneColumns.incentive} varchar ,
  //            ${OfferZoneColumns.validTill} varchar
  //           )
  //       ''');
  //     await database.execute('''
  //          create table $tableNotification(
  //            NId integer primary key autoincrement,
  //            ${Notification.docEntry} int ,
  //            ${Notification.title} varchar ,
  //            ${Notification.imgurl} varchar ,
  //            ${Notification.description} varchar ,
  //            ${Notification.receiveTime} varchar ,
  //            ${Notification.seenTime} varchar ,
  //            ${Notification.naviScn} varchar
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableOpenLead(
  //            OPLId integer primary key autoincrement,
  //            ${OpenLeadColumn.LeadDocEntry} int ,
  //            ${OpenLeadColumn.LeadDocNum} int ,
  //            ${OpenLeadColumn.FollowupEntry} int ,
  //            ${OpenLeadColumn.Branch} varchar ,
  //            ${OpenLeadColumn.BranchManager} varchar ,
  //            ${OpenLeadColumn.Brand} varchar ,
  //            ${OpenLeadColumn.CreateDate} varchar ,
  //            ${OpenLeadColumn.Customer} varchar ,
  //            ${OpenLeadColumn.CustomerInitialIcon} varchar ,
  //            ${OpenLeadColumn.Division} varchar ,
  //            ${OpenLeadColumn.DocTotal} numeric ,
  //            ${OpenLeadColumn.FollowupDate} varchar ,
  //            ${OpenLeadColumn.Followup_Due_Type} varchar ,
  //            ${OpenLeadColumn.GroupProperty} varchar ,
  //            ${OpenLeadColumn.GroupSegment} varchar ,
  //            ${OpenLeadColumn.ItemCode} varchar ,
  //            ${OpenLeadColumn.LastFollowupDate} varchar ,
  //            ${OpenLeadColumn.LastFollowupStatus} varchar ,
  //            ${OpenLeadColumn.LastFollowup_Feedback} varchar ,
  //            ${OpenLeadColumn.Phone} varchar ,
  //            ${OpenLeadColumn.Product} varchar ,
  //            ${OpenLeadColumn.Quantity} varchar ,
  //            ${OpenLeadColumn.RegionalManager} varchar ,
  //            ${OpenLeadColumn.SalesExecutive} varchar
  //            )
  //       ''');
  //   }, version: 1);
  // }

  Future insertItemMaster(List<ItemMasterDBModel> values, Database db) async {
    //openDatabase('SellerKit.db');
    // ReceivePort port = new ReceivePort();
    // final iss = await Isolate.spawn<List<dynamic>>(
    //     insertDataItem, [port.sendPort, values]);
    // iss.kill(priority: Isolate.immediate);

    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableItemMaster, es);
      // log("ItemMasterDBModel Batchhhh Item...");
    });
    await batch.commit();
    // await db.close();
  }

  insertDataItem(List<dynamic> datas, Database db) async {
    // final Database db = await createDB();
    List<ItemMasterDBModel> valuesm = datas[1];
    var data = valuesm.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    // Database db = datas[2];
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableItemMaster, es);
      // log("ItemMasterDBModel Batchhhh Item11111...");
    });
    log("commiteddd...");
    await batch.commit();
    log("commiteddd222222...");
  }

  Future insertdocuments(ItemMasterDBModel values, Database db) async {
    final id = await db.insert(tableItemMaster, values.toMap());
    print("result: $id");
  }

  Future<List<ItemMasterDBModel>> getFavData(String fav, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $fav,IsSelected,Favorite
 FROM ItemMaster
WHERE $fav IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          id: int.parse(result[i]['Id'].toString()),
          itemCode: '', // result[i]['ItemCode'].toString(),
          itemName: '', //  result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: 0.0, // double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: 0.0, //double.parse( result[i]['SlpPrice'].toString()),
          storeStock: 0.0, //double.parse( result[i]['StoreStock'].toString()),
          whsStock: 0.0,
          itemDescription: '',
          modelNo: '',
          partCode: '',
          skucode: '',
          brandCode: '',
          itemGroup: '',
          specification: '',
          sizeCapacity: '',
          clasification: '',
          uoM: '',
          taxRate: 0,
          catalogueUrl1: '',
          catalogueUrl2: '',
          imageUrl1: '',
          imageUrl2: '',
          textNote: '',
          status: '',
          movingType: '',
          eol: bool.parse(result[i]['Eol'].toString()),
          veryFast: bool.parse(result[i]['VeryFast'].toString()),
          fast: bool.parse(result[i]['Fast'].toString()),
          slow: bool.parse(result[i]['Slow'].toString()),
          verySlow: bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: bool.parse(result[i]['serialNumber '].toString()),
          priceStockId: 0,
          storeCode: '',
          whseCode: '',
          sp: 0.0,
          ssp1: 0.0,
          ssp2: 0.0,
          ssp3: 0.0,
          ssp4: 0.0,
          ssp5: 0.0,
          ssp1Inc: 0.0,
          ssp2Inc: 0.0,
          ssp3Inc: 0.0,
          ssp4Inc: 0.0,
          ssp5Inc: 0.0,
          allowNegativeStock:
              bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost:
              bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: '',
          color: '',
          calcType: '',
        payOn: '' // double.parse( result[i]['WhsStock'].toString()),
          );
    });
  }

  Future<List<ItemMasterDBModel>> onFieldSeleted(
      String brand,
      String category,
      String segment,
      String isselectedBrand,
      String isSelectedCate,
      String isSelectedsegment,
      String fromAmt,
      String toAmount,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
 SELECT * From ItemMaster A
      Where 
      A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
      A.Segment <> 'null' and coalesce(A.Segment,'') <> '' AND 
      A.Category <> 'null' and coalesce(A.Category,'') <> '' AND 
      ('$isselectedBrand' = '' OR A.Brand in ($brand)) 
      AND ('$isSelectedCate' = '' OR A.Category in ($category)) 
      AND ('$isSelectedsegment' = '' OR A.Segment in ($segment)) 
""");

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    ///
    String data =
        """
 SELECT * From ItemMaster A
      Where 
      A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
      A.Segment <> 'null' and coalesce(A.Segment,'') <> '' AND
      A.Category <> 'null' and coalesce(A.Category,'') <> '' AND
      ('$isselectedBrand' = '' OR A.Brand in ($brand))
      AND ('$isSelectedCate' = '' OR A.Category in ($category))
      AND ('$isSelectedsegment' = '' OR A.Segment in ($segment))
""";

    log(data.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          id: int.parse(result[i]['Id'].toString()),
          IMId: int.parse(result[i]['IMId'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: double.parse(result[i]['SlpPrice'].toString()),
          storeStock: double.parse(result[i]['StoreStock'].toString()),
          whsStock: double.parse(result[i]['WhsStock'].toString()),
          refreshedRecordDate: result[i]['RefreshedRecordDate'].toString(),
          itemDescription: result[i]['ItemDescription'].toString(),
          modelNo: result[i]['ModelNo'].toString(),
          partCode: result[i]['PartCode'].toString(),
          skucode: result[i]['Skucode'].toString(),
          brandCode: result[i]['BrandCode'].toString(),
          itemGroup: result[i]['ItemGroup'].toString(),
          specification: result[i]['Specification'].toString(),
          sizeCapacity: result[i]['SizeCapacity'].toString(),
          clasification: result[i]['Clasification'].toString(),
          uoM: result[i]['UoM'].toString(),
          taxRate: int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: bool.parse(result[i]['eol'].toString()),
          veryFast: bool.parse(result[i]['Fast'].toString()),
          fast: bool.parse(result[i]['Fast'].toString()),
          slow: bool.parse(result[i]['Slow'].toString()),
          verySlow: bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: double.parse(result[i]['Sp'].toString()),
          ssp1: double.parse(result[i]['Ssp1'].toString()),
          ssp2: double.parse(result[i]['Ssp2'].toString()),
          ssp3: double.parse(result[i]['Ssp3'].toString()),
          ssp4: double.parse(result[i]['Ssp4'].toString()),
          ssp5:double.parse( result[i]['Ssp5'].toString()),
          ssp1Inc:double.parse( result[i]['Ssp1Inc'].toString()),
          ssp2Inc: double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc: double.parse(result[i]['Ssp3Inc'].toString()),
          ssp4Inc: double.parse(result[i]['Ssp4Inc'].toString()),
          ssp5Inc:double.parse( result[i]['Ssp5Inc'].toString()),
          allowNegativeStock:
              bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost:
              bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString(),
          calcType: result[i]['calcType'].toString(),
        payOn: result[i]['payOn'].toString()
          
          );
    });
  }

  /// view all

  Future<List<ItemMasterDBModel>> getViewAllData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $data,IsSelected
 FROM ItemMaster
WHERE $data IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          id: int.parse(result[i]['Id'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: 0.00, // double.parse( result[i]['MgrPrice'].toString()),
          slpPrice: 0.00, // double.parse( result[i]['SlpPrice'].toString()),
          storeStock: 0.00, //double.parse( result[i]['StoreStock'].toString()),
          whsStock: 0.00,
          itemDescription: '',
          modelNo: '',
          partCode: '',
          skucode: '',
          brandCode: '',
          itemGroup: '',
          specification: '',
          sizeCapacity: '',
          clasification: '',
          uoM: '',
          taxRate: 0,
          catalogueUrl1: '',
          catalogueUrl2: '',
          imageUrl1: '',
          imageUrl2: '',
          textNote: '',
          status: '',
          movingType: '',
          eol: bool.parse(result[i]['Eol'].toString()),
          veryFast: bool.parse(result[i]['VeryFast'].toString()),
          fast: bool.parse(result[i]['Fast'].toString()),
          slow: bool.parse(result[i]['Slow'].toString()),
          verySlow: bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: 0,
          storeCode: '',
          whseCode: '',
          sp: 0.0,
          ssp1: 0.0,
          ssp2: 0.0,
          ssp3: 0.0,
          ssp4: 0.0,
          ssp5: 0.0,
          ssp1Inc: 0.0,
          ssp2Inc: 0.0,
          ssp3Inc: 0.0,
          ssp4Inc: 0.0,
          ssp5Inc: 0.0,
          allowNegativeStock:
              bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost:
              bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: '',
          color: '',
          payOn:'',
          calcType: '' //double.parse( result[i]['WhsStock'].toString()),
          );
    });
  }

  Future<List<ItemMasterDBModel>> getSearchData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
Select * from ItemMaster where (ItemCode || ' - ' || ItemName) Like '%$data%';
''');

    log("Search data: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          id: int.parse(result[i]['Id'].toString()),
          IMId: int.parse(result[i]['IMId'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: double.parse(result[i]['SlpPrice'].toString()),
          storeStock: double.parse(result[i]['StoreStock'].toString()),
          whsStock: double.parse(result[i]['WhsStock'].toString()),
          refreshedRecordDate: result[i]['RefreshedRecordDate'].toString(),
          itemDescription: result[i]['ItemDescription'].toString(),
          modelNo: result[i]['ModelNo'].toString(),
          partCode: result[i]['PartCode'].toString(),
          skucode: result[i]['Skucode'].toString(),
          brandCode: result[i]['BrandCode'].toString(),
          itemGroup: result[i]['ItemGroup'].toString(),
          specification: result[i]['Specification'].toString(),
          sizeCapacity: result[i]['SizeCapacity'].toString(),
          clasification: result[i]['Clasification'].toString(),
          uoM: result[i]['UoM'].toString(),
          taxRate: int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: bool.parse(result[i]['eol'].toString()),
          veryFast: bool.parse(result[i]['Fast'].toString()),
          fast: bool.parse(result[i]['Fast'].toString()),
          slow: bool.parse(result[i]['Slow'].toString()),
          verySlow: bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: double.parse(result[i]['Sp'].toString()),
          ssp1: double.parse(result[i]['Ssp1'].toString()),
          ssp2: double.parse(result[i]['Ssp2'].toString()),
          ssp3: double.parse(result[i]['Ssp3'].toString()),
          ssp4: double.parse(result[i]['Ssp4'].toString()),
          ssp5: double.parse(result[i]['Ssp5'].toString()),
          ssp1Inc:double.parse( result[i]['Ssp1Inc'].toString()),
          ssp2Inc: double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc:double.parse( result[i]['Ssp3Inc'].toString()),
          ssp4Inc:double.parse( result[i]['Ssp4Inc'].toString()),
          ssp5Inc:double.parse( result[i]['Ssp5Inc'].toString()),
          allowNegativeStock:
              bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost:
              bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString(),
           payOn:result[i]['payOn'].toString(),
          calcType: result[i]['calcType'].toString()
          );
    });
  }

  //update
  Future<void> updateItemMaster(
      String ID, ItemMasterDBModel itemMaserPriceAvail, Database db) async {
// print("mgrPrice: "+itemMaserPriceAvail.mgrPrice.toString());
// print("refreshedRecordDate: "+itemMaserPriceAvail.refreshedRecordDate.toString());
// print("slpPrice "+itemMaserPriceAvail.slpPrice.toString());
// print("whsStock "+itemMaserPriceAvail.whsStock.toString());
// print("storeStock: "+itemMaserPriceAvail.storeStock.toString());
// print("storeID ID: "+ID.toString());

    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      UPDATE $tableItemMaster
SET MgrPrice = ${itemMaserPriceAvail.mgrPrice},
 SlpPrice = ${itemMaserPriceAvail.slpPrice} ,
 StoreStock = ${itemMaserPriceAvail.storeStock} ,
 WhsStock = ${itemMaserPriceAvail.whsStock},
 RefreshedRecordDate = "${itemMaserPriceAvail.refreshedRecordDate}" WHERE IMId = "$ID";
    ''');
  }

//   Future<List<ItemMasterDBModel>> getAllProducts(Database db) async {
//     final List<Map<String, Object?>> result =
//         await db.rawQuery("""
//  SELECT * From ItemMaster 
// """);

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//           id: int.parse(result[i]['IMId'].toString()),
//           IMId: int.parse(result[i]['IMId'].toString()),
//           itemCode: result[i]['ItemCode'].toString(),
//           itemName: result[i]['ItemName'].toString(),
//           brand: result[i]['Brand'].toString(),
//           category: result[i]['Category'].toString(),
//           division: result[i]['Division'].toString(),
//           segment: result[i]['Segment'].toString(),
//           isselected: int.parse(result[i]['IsSelected'].toString()),
//           favorite: result[i]['Favorite'].toString(),
//           mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
//           slpPrice: double.parse(result[i]['SlpPrice'].toString()),
//           storeStock: double.parse(result[i]['StoreStock'].toString()),
//           whsStock: double.parse(result[i]['WhsStock'].toString()),
//           refreshedRecordDate: result[i]['RefreshedRecordDate'].toString(),
//           itemDescription: result[i]['ItemDescription'].toString(),
//           modelNo: result[i]['ModelNo'].toString(),
//           partCode: result[i]['PartCode'].toString(),
//           skucode: result[i]['Skucode'].toString(),
//           brandCode: result[i]['BrandCode'].toString(),
//           itemGroup: result[i]['ItemGroup'].toString(),
//           specification: result[i]['Specification'].toString(),
//           sizeCapacity: result[i]['SizeCapacity'].toString(),
//           clasification: result[i]['Clasification'].toString(),
//           uoM: result[i]['UoM'].toString(),
//           taxRate: int.parse(result[i]['TaxRate'].toString()),
//           catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
//           catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
//           imageUrl1: result[i]['ImageUrl1'].toString(),
//           imageUrl2: result[i]['ImageUrl2'].toString(),
//           textNote: result[i]['TextNote'].toString(),
//           status: result[i]['Status'].toString(),
//           movingType: result[i]['MovingType'].toString(),
//           eol: bool.parse(result[i]['eol'].toString()),
//           veryFast: bool.parse(result[i]['Fast'].toString()),
//           fast: bool.parse(result[i]['Fast'].toString()),
//           slow: bool.parse(result[i]['Slow'].toString()),
//           verySlow: bool.parse(result[i]['VerySlow'].toString()),
//           serialNumber: bool.parse(result[i]['SerialNumber'].toString()),
//           priceStockId: int.parse(result[i]['PriceStockId'].toString()),
//           storeCode: result[i]['StoreCode'].toString(),
//           whseCode: result[i]['WhseCode'].toString(),
//           sp: double.parse(result[i]['Sp'].toString()),
//           ssp1: double.parse(result[i]['Ssp1'].toString()),
//           ssp2: double.parse(result[i]['Ssp2'].toString()),
//           ssp3: double.parse(result[i]['Ssp3'].toString()),
//           ssp4:double.parse(result[i]['Ssp4'].toString()),
//           ssp5: double.parse(result[i]['Ssp5'].toString()),
//           ssp1Inc: double.parse(result[i]['Ssp1Inc'].toString()),
//           ssp2Inc:double.parse( result[i]['Ssp2Inc'].toString()),
//           ssp3Inc:double.parse( result[i]['Ssp3Inc'].toString()),
//           ssp4Inc:double.parse( result[i]['Ssp4Inc'].toString()),
//           ssp5Inc:double.parse( result[i]['Ssp5Inc'].toString()),
//           allowNegativeStock:
//               bool.parse(result[i]['AllowNegativeStock'].toString()),
//           allowOrderBelowCost:
//               bool.parse(result[i]['AllowOrderBelowCost'].toString()),
//           isFixedPrice: bool.parse(result[i]['IsFixedPrice'].toString()),
//           validTill: result[i]['ValidTill'].toString(),
//           color: result[i]['color'].toString());
//     });
//   }

  //enqtype methods

  Future insertEnqType(List<EnquiryTypeData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqType, es);
      log("Enq Batchhhh Item...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     insertIsoEnqtpe, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  Future insertCusTagType(List<CustomerTagTypeData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableCusTagType, es);
      log("Enq Batchhhh Item...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     insertIsoEnqtpe, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  insertIsoEnqtpe(List<dynamic> value) async {
    List<EnquiryTypeData> valu = value[1];
    var data = valu.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len2222: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableEnqType, es);
      // log("Enq Batchhhh Item22222...");
    });
    await batch.commit();
  }

  insertIsoCusTagtpe(List<dynamic> value) async {
    List<CustomerTagTypeData> valu = value[1];
    var data = valu.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len2222: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableCusTagType, es);
      // log("Enq Batchhhh Item22222...");
    });
    await batch.commit();
  }

  Future<List<EnquiryTypeData>> getEnqData(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM EnqType;
''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return EnquiryTypeData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  Future<List<EnquiryTypeData>> getCusTagData(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM CusTagType;
''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return EnquiryTypeData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  Future<void> truncareItemMaster(Database db) async {
    await db.rawQuery('delete from $tableItemMaster');
  }

  Future<void> truncareEnqType(Database db) async {
    await db.rawQuery('delete from $tableEnqType');
  }

  Future<void> truncareCusTagType(Database db) async {
    await db.rawQuery('delete from $tableCusTagType');
  }

  Future<void> truncareEnqReffers(Database db) async {
    await db.rawQuery('delete from $tableEnqReffers');
  }

  Future insertEnqReffers(List<EnqRefferesData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqReffers, es);
      log("Enq Batchhhh Item...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoReferral, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  indertIsoReferral(List<dynamic> value) async {
    List<EnqRefferesData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableEnqReffers, es);
      // log("referrall Batchhhh Item3333...");
    });
    await batch.commit();
  }

  Future<List<EnqRefferesData>> getEnqRefferes(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
    SELECT * FROM $tableEnqReffers;
    ''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return EnqRefferesData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  // user list

  Future insertUserList(List<UserListData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableUserList, es);
      print("Data...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoUserList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  indertIsoUserList(List<dynamic> value) async {
    List<UserListData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableUserList, es);
      // log("Enq userlist Batchhhh Item4444...");
    });
    await batch.commit();
  }

  Future<List<UserListData>> getUserList(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM $tableUserList;
''');

    return List.generate(result.length, (i) {
      return UserListData(
        userCode: result[i]['UserCode'].toString(),
        storeid: int.parse(result[i]['StoreID'].toString()),

        //  UserKey: int.parse(result[i]['UserKey'].toString()),
        //  UserCode: result[i]['UserCode'].toString(),
        mngSlpcode: result[i]['managerSlp'].toString(),
        slpcode: result[i]['slpCode'].toString(),
        UserName: result[i]['UserName'].toString(),
        color: int.parse(result[i]['Color'].toString()),
        // EmployeeID: int.parse(result[i]['EmployeeID'].toString()),
        SalesEmpID: int.parse(result[i]['SalesEmpID'].toString()),
      );
    });
  }

  Future insertLeadStatusList(
      List<GetLeadStatusData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      print("LeadStatusList...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoLeadStatusList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  indertIsoLeadStatusList(List<dynamic> value) async {
    List<GetLeadStatusData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      // log("Enq LeadStatus Batchhhh Item555..");
    });
    await batch.commit();
  }

  Future<List<GetLeadStatusData>> getLeadStatusOpen(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = '1';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());
    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: int.parse(result[i]['StatusType'].toString()),
      );
    });
  }

  Future<List<GetLeadStatusData>> getLeadStatusWon(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = '2';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: int.parse(result[i]['StatusType'].toString()),
      );
    });
  }

  Future<List<GetLeadStatusData>> getLeadStatusLost(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = '3';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: int.parse(result[i]['StatusType'].toString()),
      );
    });
  }

  Future insertOfferZone(List<OfferZoneData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZone, es);
      // log("offerzone...$data");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  Future insertOfferZonechild1(
      List<offerproductlist> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZonechild1, es);
      // log("offerzone...$data");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  Future insertOfferZonechild2(List<offerstorelist> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZonechild2, es);
      // log("offerzone...$data");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  indertIsoOfferZone(
    List<dynamic> value,
  ) async {
    List<OfferZoneData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableOfferZone, es);
      // log("OfferZone Batchhhh Item66666..");
    });
    await batch.commit();
  }

  static Future<List<Map<String, Object?>>> getofferDataproduct(
      Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * from $tableOfferZonechild1

''');

// log("message"+result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getofferDatastore(
      Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * from $tableOfferZonechild2
''');

// log("message"+result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getofferFavData(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * from $tableOfferZone

''');

// log("message"+result.toString());

    return result;

    // return List.generate(result.length, (i) {
    //   // return offerproductlist(
    //   //   id: id,
    //   //   itemid: itemid,
    //   //   offer: offer,
    //   //   offerid: offerid,
    //   //   relevanttag: relevanttag
    //   //   );
    //   //   return offerstorelist(
    //   //     id: id,
    //   //     offerid: offerid,
    //   //     storeid: storeid
    //   //     );
    //   return OfferZoneData(
    //       offerId: int.parse(result[i]['OfferID'].toString()),
    //       itemCode: result[i]['ItemCode'].toString(),
    //       offerName: result[i]['OfferName'].toString(),
    //       offerDetails: result[i]['OfferDetails'].toString(),
    //       item: result[i]['Item'].toString(),
    //       discoutDetails: result[i]['DiscountDetails'].toString(),
    //       incentive: result[i]['Incentive'].toString(),
    //       validTill: result[i]['ValidTill'].toString(),

    //       );

    // });
  }
//   Future<List<OfferZoneData>> getofferFavData(Database db) async {
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT *
//  FROM $tableOfferZone
// ''');

//     return List.generate(result.length, (i) {
//       return OfferZoneData(
//           offerId: int.parse(result[i]['OfferID'].toString()),
//           itemCode: result[i]['ItemCode'].toString(),
//           offerName: result[i]['OfferName'].toString(),
//           offerDetails: result[i]['OfferDetails'].toString(),
//           item: result[i]['Item'].toString(),
//           discoutDetails: result[i]['DiscountDetails'].toString(),
//           incentive: result[i]['Incentive'].toString(),
//           validTill: result[i]['ValidTill'].toString());
//     });
//   }

  //Notification

  Future insertNotification(List<NotificationModel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableNotification, es);
    });
    await batch.commit();
  }

  //   Future insertNotify(NotificationModel values)async{
  //     final Database db = await createDB();
  //     final id = await db.insert(tableNotification, values.toMap());
  //       await db.close();
  // }

  Future<List<NotificationModel>> getNotification(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM $tableNotification;
''');
    log(result.toList().toString());
    return List.generate(result.length, (i) {
      return NotificationModel(
        jobid: int.parse(result[i]['Jobid'].toString()),
        id: int.parse(result[i]['NId'].toString()),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        titile: result[i]['Title'].toString(),
        description: result[i]['Description'].toString(),
        receiveTime: result[i]['ReceiveTime'].toString(),
        seenTime: result[i]['SeenTime'].toString(),
        imgUrl: result[i]['ImgUrl'].toString(),
        naviScn: result[i]['NavigateScreen'].toString(),
      );
    });
  }

  Future<int?> getUnSeenNotificationCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  updateNotify(int id, String time, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
  }

  deleteNotify(int id, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      delete from $tableNotification WHERE DocEntry = $id;
    ''');
    // await db.close();
  }

  deleteNotifyAll(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  Future<void> truncateOfferZone(Database db) async {
    await db.rawQuery('delete from $tableOfferZone');
    // await db.close();
  }

  static Future<void> truncateOfferZonechild1(Database db) async {
    await db.rawQuery('delete from $tableOfferZonechild1');
    // await db.close();
  }

  static Future<void> truncateOfferZonechild2(Database db) async {
    await db.rawQuery('delete from $tableOfferZonechild2');
    // await db.close();
  }

  Future<void> truncateUserList(Database db) async {
    await db.rawQuery('delete from $tableUserList');
    // await db.close();
  }

  Future<void> truncateLeadstatus(Database db) async {
    await db.rawQuery('delete from $tableLeadStatusReason');
    // await db.close();
  }

  Future<void> truncateNotification(Database db) async {
    await db.rawQuery('delete from $tableNotification');
    //  await db.close();
  }

  //Open Lead

  Future insertOpenLead(List<OpenLeadData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("openLead len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOpenLead, es);
      log("openLead Batchhhh Item...");
    });
    await batch.commit();
    // await db.close();
  }

  Future<List<Map<String, Object?>>> runQuery(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
    SELECT * from OpenLeadT;
    ''');
    log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return result;
  }

  Future<void> truncateOpenLead(Database db) async {
    await db.rawQuery('delete from $tableOpenLead');
    //  await db.close();
  }

  //

  Future<List<Map<String, Object?>>> getOpenLFtr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $column
 FROM $tableOpenLead
WHERE $column IS NOT '';
''');

    log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
    // return List.generate(result.length, (i) {
    //   return OpenLeadData(
    //     FollowupDate: FollowupDate,
    //     LeadDocEntry: LeadDocEntry,
    //     LeadDocNum: LeadDocNum,
    //     FollowupEntry: FollowupEntry,
    //     Phone: Phone,
    //     Customer: Customer,
    //     CreateDate: CreateDate,
    //     LastFollowupDate: LastFollowupDate,
    //     DocTotal: DocTotal,
    //     Quantity: Quantity,
    //     Product: Product,
    //     LastFollowupStatus: LastFollowupStatus,
    //     CustomerInitialIcon: CustomerInitialIcon,
    //     Followup_Due_Type: Followup_Due_Type,
    //     ItemCode: ItemCode, Brand: Brand, GroupProperty: GroupProperty,
    //     GroupSegment: GroupSegment, Division: Division, Branch: Branch,
    //     SalesExecutive: SalesExecutive, BranchManager: BranchManager,
    //     RegionalManager: RegionalManager,
    //     LastFollowup_Feedback: LastFollowup_Feedback
    //     );
    // });
  }

  Future<List<OpenLeadData>> onFilteredOpenLead(
      String brand,
      String groupProperty,
      String groupSegment,
      String division,
      String branch,
      String salesExecutive,
      String branchManager,
      String regionalManager,
      String isBrand,
      String isgroupProperty,
      String isgroupSegment,
      String isdivision,
      String isBranch,
      String issalesExecutive,
      String isBranchManager,
      String isRegionalManager,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
 SELECT * From OpenLeadT A
            Where 

            ('$isBrand' = '' OR A.Brand in ($brand))  AND 
            ('$isgroupProperty' = '' OR A.GroupProperty in ($groupProperty)) AND 
            ('$isgroupSegment' = '' OR A.GroupSegment in ($groupSegment))AND
            ('$isdivision' = '' OR A.Division in ($division))AND
            ('$isBranch' = '' OR A.Branch in ($branch))AND
            ('$issalesExecutive' = '' OR A.SalesExecutive in ($salesExecutive))AND
            ('$isBranchManager' = '' OR A.BranchManager in ($branchManager))AND
            ('$isRegionalManager' = '' OR A.RegionalManager in ($regionalManager))
""");

    String data =
        """
  SELECT * From OpenLeadT A
            Where 
            ('$isBrand' = '' OR A.Brand in ($brand))  AND 
            ('$isgroupProperty' = '' OR A.GroupProperty in ($groupProperty)) AND 
            ('$isgroupSegment' = '' OR A.GroupSegment in ($groupSegment))AND
            ('$isdivision' = '' OR A.Division in ($division))AND
            ('$isBranch' = '' OR A.Branch in ($branch))AND
            ('$issalesExecutive' = '' OR A.SalesExecutive in ($salesExecutive))AND
            ('$isBranchManager' = '' OR A.BranchManager in ($branchManager))AND
            ('$isRegionalManager' = '' OR A.RegionalManager in ($regionalManager))
""";
    log(data.toString());
    log(result.toString());

    return List.generate(result.length, (i) {
      return OpenLeadData(
          FollowupDate: result[i]["FollowupDate"].toString(),
          LeadDocEntry: int.parse(result[i]["LeadDocEntry"].toString()),
          LeadDocNum: int.parse(result[i]["LeadDocNum"].toString()),
          FollowupEntry: int.parse(result[i]["FollowupEntry"].toString()),
          Phone: result[i]["Phone"].toString(),
          Customer: result[i]["Customer"].toString(),
          CreateDate: result[i]["CreateDate"].toString(),
          LastFollowupDate: result[i]["LastFollowupDate"].toString(),
          DocTotal: double.parse(result[i]["DocTotal"].toString()),
          Quantity: result[i]["Quantity"].toString(),
          Product: result[i]["Product"].toString(),
          LastFollowupStatus: result[i]["LastFollowupStatus"].toString(),
          CustomerInitialIcon: result[i]["CustomerInitialIcon"].toString(),
          Followup_Due_Type: result[i]["Followup_Due_Type"].toString(),
          ItemCode: result[i]["ItemCode"].toString(),
          Brand: result[i]["Brand"].toString(),
          GroupProperty: result[i]["GroupProperty"].toString(),
          GroupSegment: result[i]["GroupSegment"].toString(),
          Division: result[i]["Division"].toString(),
          Branch: result[i]["Branch"].toString(),
          SalesExecutive: result[i]["SalesExecutive"].toString(),
          BranchManager: result[i]["BranchManager"].toString(),
          RegionalManager: result[i]["RegionalManager"].toString(),
          LastFollowup_Feedback: result[i]["LastFollowup_Feedback"].toString());
    });
    //return  result;
  }

  Future<List<OpenLeadData>> onSearchOpenLead(String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
        SELECT * From OpenLeadT Where ItemCode LIKE '%$data%';
    """);
    log(result.toString());
    return List.generate(result.length, (i) {
      return OpenLeadData(
          FollowupDate: result[i]["FollowupDate"].toString(),
          LeadDocEntry: int.parse(result[i]["LeadDocEntry"].toString()),
          LeadDocNum: int.parse(result[i]["LeadDocNum"].toString()),
          FollowupEntry: int.parse(result[i]["FollowupEntry"].toString()),
          Phone: result[i]["Phone"].toString(),
          Customer: result[i]["Customer"].toString(),
          CreateDate: result[i]["CreateDate"].toString(),
          LastFollowupDate: result[i]["LastFollowupDate"].toString(),
          DocTotal: double.parse(result[i]["DocTotal"].toString()),
          Quantity: result[i]["Quantity"].toString(),
          Product: result[i]["Product"].toString(),
          LastFollowupStatus: result[i]["LastFollowupStatus"].toString(),
          CustomerInitialIcon: result[i]["CustomerInitialIcon"].toString(),
          Followup_Due_Type: result[i]["Followup_Due_Type"].toString(),
          ItemCode: result[i]["ItemCode"].toString(),
          Brand: result[i]["Brand"].toString(),
          GroupProperty: result[i]["GroupProperty"].toString(),
          GroupSegment: result[i]["GroupSegment"].toString(),
          Division: result[i]["Division"].toString(),
          Branch: result[i]["Branch"].toString(),
          SalesExecutive: result[i]["SalesExecutive"].toString(),
          BranchManager: result[i]["BranchManager"].toString(),
          RegionalManager: result[i]["RegionalManager"].toString(),
          LastFollowup_Feedback: result[i]["LastFollowup_Feedback"].toString());
    });
    //return  result;
  }
}

// A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
// A.GroupProperty <> 'null' and coalesce(A.GroupProperty,'') <> '' AND
// A.GroupSegment <> 'null' and coalesce(A.GroupSegment,'') <> '' AND
// A.Division <> 'null' and coalesce(A.Division,'') <> '' AND
// A.Branch <> 'null' and coalesce(A.Branch,'') <> '' AND
// A.SalesExecutive <> 'null' and coalesce(A.SalesExecutive,'') <> '' AND
// A.BranchManager <> 'null' and coalesce(A.BranchManager,'') <> '' AND
// A.RegionalManager <> 'null' and coalesce(A.RegionalManager,'') <> '' AND

//   Future<List<ItemMasterDBModel>> getViewAllCategory() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Category,IsSelected
//  FROM ItemMaster
// WHERE Category IS NOT 'null' AND Category IS NOT '';
// ''');

//     // log("Saved AllocATE: " + result.toList().toString());
//     // log("Saved AllocATE length: " + result.length.toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//         favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

//   Future<List<ItemMasterDBModel>> getViewAllSegment() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Segment,IsSelected
//  FROM ItemMaster
// WHERE Segment IS NOT 'null' AND Segment IS NOT '';
// ''');

//     // log("Saved AllocATE: " + result.toList().toString());
//     // log("Saved AllocATE length: " + result.length.toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//          favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

///

//   Future<List<ItemMasterDBModel>> getProduct() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Category,IsSelected,Favorite
//  FROM ItemMaster
// WHERE Category IS NOT '' AND Favorite IS NOT 'N';
// ''');

//     log("Saved AllocATE: "+result.toList().toString());
// log("Saved AllocATE length: "+result.length .toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//          favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

//   Future<List<ItemMasterDBModel>> getSegment() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Segment,IsSelected,Favorite
//  FROM ItemMaster
// WHERE Segment IS NOT '' AND Favorite IS NOT 'N';
// ''');

// //     log("Saved AllocATE: "+result.toList().toString());
// // log("Saved AllocATE length: "+result.length .toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//         favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }
