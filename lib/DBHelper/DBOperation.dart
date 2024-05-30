import 'dart:developer';

import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/DBModel/AuthorizationDB.dart';
import 'package:sellerkit/DBModel/CustomerModel.dart';
import 'package:sellerkit/DBModel/ScreenShotModel.dart';
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
import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/GetAllOrderModel.dart';
import 'package:sellerkit/Models/TestModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../DBModel/EnqTypeModel.dart';
import '../DBModel/ItemMasertDBModel.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/QuotFilterTableModel.dart';
import '../Models/CustomerMasterModel/CustomerMasterModel.dart';
import '../Models/OfferZone/OfferZoneModel.dart';
import '../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../Models/PostQueryModel/OrdersCheckListModel/GetOrderStatuModel.dart';

class DBOperation {


  static Future insertItemMaster(
      List<ItemMasterDBModel> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    // log("Start:insertItemMaster ");

    try{
await db.execute(
  "INSERT INTO $tableItemMaster (${values.first.toMap().keys.join(', ')}) VALUES ${values.map((item) => '(${item.toMap().values.map((v) => v==null ? "NULL" :"'$v'").join(', ')})').join(', ')}"
);
log("values len: " + tableItemMaster.length.toString());
    }catch(e){
log("values len:xxxx "+e.toString());
    }
    stopwatch.stop();
    // log('API insertItemMaster ${stopwatch.elapsedMilliseconds} milliseconds');
    // var data = values.map((e) => e.toMap()).toList();
    // log("values len: " + values.length.toString());
    // log("data len: " + data.length.toString());
    // var batch = db.batch();
    // for (var item in data) {
    //   String columns = item.keys.join(', ');
    //   String values =
    //       item.values.map((v) => v == null ? "NULL" : "'$v'").join(', ');
    //   String sql = 'INSERT INTO $tableItemMaster ($columns) VALUES ($values)';
    //   batch.rawInsert(sql);
    // }
    // await batch.commit();
    
  }

  //old
  // static Future insertItemMaster(
  //     List<ItemMasterDBModel> values, Database db) async {
  //   final stopwatch = Stopwatch()..start();
  //   log("Start:insertItemMaster ");
  //   var data = values.map((e) => e.toMap()).toList();
  //   // log("values len: " + values.length.toString());
  //   // log("data len: " + data.length.toString());
  //   var batch = db.batch();
  //   for (var item in data) {
  //     String columns = item.keys.join(', ');
  //     String values =
  //         item.values.map((v) => v == null ? "NULL" : "'$v'").join(', ');
  //     String sql = 'INSERT INTO $tableItemMaster ($columns) VALUES ($values)';
  //     batch.rawInsert(sql);
  //   }
  //   await batch.commit();
  //   stopwatch.stop();
  //   log('API insertItemMaster ${stopwatch.elapsedMilliseconds} milliseconds');
  // }
//      List<String> columns = item.keys.toList();
  // List<String> placeholders = List.filled(columns.length, '?');

  // String sql = 'INSERT INTO $tableItemMaster (${columns.join(', ')}) VALUES (${placeholders.join(', ')})';

  // List<dynamic> values = item.values.toList();

  // batch.rawInsert(sql, values);
  // v is String ?"'$v'"
  static Future insertEnqdata(List<EnquiriesData> values, Database db) async {
    //openDatabase('SellerKit.db');
    // ReceivePort port = new ReceivePort();
    // final iss = await Isolate.spawn<List<dynamic>>(
    //     insertDataItem, [port.sendPort, values]);
    // iss.kill(priority: Isolate.immediate);
    final stopwatch = Stopwatch()..start();
    log("start DBBBB");
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + values.length.toString());

    var batch = db.batch();
    // for (var es in data){

    data.forEach((es) async {
      batch.insert(tableEnquiryfilter, es);
    });
    // }
    log("tableEnquiryfilter..." + tableEnquiryfilter.length.toString());
    await batch.commit();
    stopwatch.stop();
    log('API DB ${stopwatch.elapsedMilliseconds} milliseconds');

    // await db.close();
  }

   static Future insertleaddata(List<GetAllLeadData> values, Database db) async {
    //openDatabase('SellerKit.db');
    // ReceivePort port = new ReceivePort();
    // final iss = await Isolate.spawn<List<dynamic>>(
    //     insertDataItem, [port.sendPort, values]);
    // iss.kill(priority: Isolate.immediate);
    final stopwatch = Stopwatch()..start();
    log("start DBBBB");
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + values.length.toString());

    var batch = db.batch();
    // for (var es in data){

    data.forEach((es) async {
      batch.insert(tableLeadfilter, es);
    });
    // }
    log("tableLeadfilter..." + tableLeadfilter.length.toString());
    await batch.commit();
    stopwatch.stop();
    log('API DB ${stopwatch.elapsedMilliseconds} milliseconds');

    // await db.close();
  }

  static Future insertopenleaddata(List<OpenLeadfiltermodel> values, Database db) async {
    //openDatabase('SellerKit.db');
    // ReceivePort port = new ReceivePort();
    // final iss = await Isolate.spawn<List<dynamic>>(
    //     insertDataItem, [port.sendPort, values]);
    // iss.kill(priority: Isolate.immediate);
    final stopwatch = Stopwatch()..start();
    log("start DBBBB");
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + values.length.toString());

    var batch = db.batch();
    // for (var es in data){

    data.forEach((es) async {
      batch.insert(tableopenLeadfilter, es);
    });
    // }
    log("tableopenLeadfilter..." + tableopenLeadfilter.length.toString());
    await batch.commit();
    stopwatch.stop();
    log('API DB ${stopwatch.elapsedMilliseconds} milliseconds');

    // await db.close();
  }

  //new for outstanding
  static Future insertOutstandingMaster(
      List<outstandingData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("outstandingDBModel len: " + values.length.toString());
    log("outstandingDBModel len: " + data.length.toString());

    var batch = db.batch();
    var existingRecords = await db.query(tableoutstanding);
    var customerCodesToDelete = <String>{};
    for (var record in existingRecords) {
      String customerCode2 = record['CustomerCode'].toString();

      if (!data.any(
          (element) => element['CustomerCode'].toString() == customerCode2)) {
        customerCodesToDelete.add(customerCode2);
        log("customerCodesToDelete len: " +
            customerCodesToDelete.length.toString());
      }
    }
    for (var es in data) {
      String customercode = es['CustomerCode'].toString();

      var existingRecord = await db.query(
        tableoutstanding,
        where: 'CustomerCode = ? ',
        whereArgs: [
          customercode,
        ],
      );
      // log("existingRecord::"+existingRecord.length.toString());

      if (existingRecord.isNotEmpty) {
        batch.update(
          tableoutstanding,
          es,
          where: 'CustomerCode = ? ',
          whereArgs: [
            customercode,
          ],
        );
      } else {
        batch.insert(tableoutstanding, es);
      }
    }

    for (var code in customerCodesToDelete) {
      await db.delete(
        tableoutstanding,
        where: 'CustomerCode = ?',
        whereArgs: [code],
      );
    }
    // data.forEach((es) async {

    //   batch.insert(tableoutstanding, es);
    //   log("tableoutstanding Batchhhh Item...");
    // });
    await batch.commit();
  }
static Future<List<Map<String, Object?>>> getorderftr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableorderfilter
WHERE $column IS NOT '';
''');

    //  log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
  }


static Future<void> truncateQuotFilter(Database db) async {
    await db.rawQuery('delete from $QuotFilterTable');
  }

  static Future insertQuotFilter(
      Database db, List<QuotFilterModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("QuotationFilteDB", es);
    });
    await batch.commit();
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from QuotationFilteDB
     ''');
    log("QuotationFilteDB result:: ${result}");
  }
  static Future<List<Map<String, Object?>>> geQuotationtData(Database db,) async {

  final List<Map<String, Object?>> result = await db.rawQuery("""
   SELECT *  from QuotationFilteDB""");
    return result;
}
static Future<List<Map<String, Object?>>> getQuotftr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $QuotFilterTable
WHERE $column IS NOT '';
''');
    return result;
  }
  static Future<List<Map<String, Object?>>> getQuotfilterapply(
      Database db,
      String assignto,
      String enqstatus,
      String ordertype,
      double balanceabove,
      String fromdate,
      String enddate) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
   SELECT *  from QuotationFilteDB A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
	Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.OrderStatus || ','   end,', ' || A.OrderStatus || ',' ) > 0  AnD
 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
  DocTotal >=$balanceabove And
	  date(A.createdon) BETWEEN '$fromdate' AND '$enddate'
    
""");

    log('message::' +
        """
    SELECT *  from QuotationFilteDB A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
	Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.OrderStatus || ','   end,', ' || A.OrderStatus || ',' ) > 0  AnD
 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   DocTotal >=$balanceabove And
	  date(A.createdon) BETWEEN '$fromdate' AND '$enddate'
    
""");
    log("Filter message::$result");
    return result;
  }
  static Future<List<GetAllOrderData>> getorderdatafilter(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableorderfilter 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return GetAllOrderData(
        CustomerGroup: result[i]['CustomerGroup'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        createdon: result[i]['Createdon'].toString(), 
        isDelivered:int.parse(result[i]['IsDelivered'].toString()) , 
        isInvoiced:int.parse( result[i]['IsInvoiced'].toString()),
         OrderDocEntry: int.parse(result[i]['OrderDocEntry'].toString()), 
         OrderNum: int.parse(result[i]['OrderNum'].toString()), 
         Mobile: result[i]['Mobile'].toString(), 
         CustomerName: result[i]['CustomerName'].toString(), 
         DocDate: result[i]['DocDate'].toString(), 
         AssignedTo: result[i]['AssignedTo'].toString(), 
         AttachURL1: result[i]['AttachURL1'].toString(), 
         AttachURL2: result[i]['AttachURL2'].toString(), 
         AttachURL3: result[i]['AttachURL3'].toString(), 
         BaseDocDate: result[i]['BaseDocDate'].toString(), 
         BaseID: int.parse(result[i]['BaseID'].toString()), 
         BaseType: result[i]['BaseType'].toString(), 
         CurrentStatus: result[i]['CurrentStatus'].toString(), 
         DealID: result[i]['DealID'].toString(), 
         Del_Address2: result[i]['Del_Address2'].toString(), 
         Del_Address3: result[i]['Del_Address3'].toString(), 
         Del_Area: result[i]['del_Area'].toString(), 
         Del_City: result[i]['Del_City'].toString(), 
         Del_Country: result[i]['Del_Country'].toString(), 
         Del_District: result[i]['Del_District'].toString(), 
         Del_Pincode: result[i]['Del_Pincode'].toString(), 
         Del_State: result[i]['Del_State'].toString(), 
         DeliveryFrom: result[i]['DeliveryFrom'].toString(), 
         Discount: double.parse(result[i]['Discount'].toString()), 
         FollowupEntry: int.parse(result[i]['FollowupEntry'].toString()), 
         LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
         GrossTotal: double.parse(result[i]['GrossTotal'].toString()), 
         LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
         OrderStatus: result[i]['OrderStatus'].toString(), 
         Product: result[i]['Product'].toString(), 
         RoundOff: double.parse(result[i]['RoundOff'].toString()), 
         Status: result[i]['Status'].toString(), 
         StoreCode: result[i]['StoreCode'].toString(), 
         SubTotal: double.parse(result[i]['SubTotal'].toString()), 
         TaxAmount: double.parse(result[i]['TaxAmount'].toString()), 
         Value: double.parse(result[i]['Value'].toString()), 
         alternateMobileNo: result[i]['AlternateMobileNo'].toString(), 
         bil_Address1: result[i]['Bil_Address1'].toString(), 
         bil_Address2: result[i]['Bil_Address2'].toString(), 
         bil_Address3: result[i]['Bil_Address3'].toString(), 
         bil_Area: result[i]['Bil_Area'].toString(), 
         bil_City: result[i]['Bil_City'].toString(), 
         bil_Country: result[i]['Bil_Country'].toString(), 
         bil_District: result[i]['Bil_District'].toString(), 
         bil_Pincode: result[i]['Bil_Pincode'].toString(), 
         bil_State: result[i]['Bil_State'].toString(), 
         companyName: result[i]['CompanyName'].toString(), 
         contactName: result[i]['ContactName'].toString(), 
         customerEmail: result[i]['CustomerEmail'].toString(), 
         customerPORef: result[i]['CustomerPORef'].toString(), 
         del_Address1: result[i]['Del_Address1'].toString(), 
         deliveryDueDate: result[i]['DeliveryDueDate'].toString(), 
         enqid: result[i]['Enqid'].toString(), 
         gSTNo: result[i]['GSTNo'].toString(), 
         leadid: result[i]['Leadid'].toString(), 
         pAN: result[i]['PAN'].toString(), 
         paymentDueDate: result[i]['PaymentDueDate'].toString()
         );


     
    });
  }
  static Future insertOutstandingchild(
      List<outstandingLine> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("outstandingDBModel len: " + values.length.toString());
    log("outstandingDBModel len: " + data.length.toString());

    var batch = db.batch();
    for (var es in data) {
      String customercode = es['CustomerCode'].toString();
      String TransNum = es['TransNum'].toString();
      var existingRecord = await db.query(
        tableoutstandingline,
        where: 'CustomerCode = ? AND TransNum = ?',
        whereArgs: [customercode, TransNum],
      );
      if (existingRecord.isNotEmpty) {
        batch.update(
          tableoutstandingline,
          es,
          where: 'CustomerCode = ? AND TransNum = ?',
          whereArgs: [customercode, TransNum],
        );
      } else {
        batch.insert(tableoutstandingline, es);
      }
    }
    // data.forEach((es) async {

    //   batch.insert(tableoutstanding, es);
    //   log("tableoutstanding Batchhhh Item...");
    // });
    await batch.commit();
  }
  // static Future insertOutstandingMaster(
  //     List<outstandingDBModel> values, Database db) async {
  //    var data = values.map((e) => e.toMap()).toList();
  //   log("outstandingDBModel len: " + values.length.toString());
  //   log("outstandingDBModel len: " + data.length.toString());

  //   var batch = db.batch();
  //   data.forEach((es) async {

  //     batch.insert(tableoutstanding, es);
  //     log("tableoutstanding Batchhhh Item...");
  //   });
  //   await batch.commit();

  // }
  static Future<List<Map<String, Object?>>> getoutstndPdfList(
      Database db, String cuscode) async {
    List<Map<String, Object?>> result2 = await db.rawQuery("""
Select TransNum, TransDate, TransDueDate, TransType, OL.TransAmount, OL.BalanceToPay
From Outstanding O
Inner Join Outstandingline OL on O.CustomerCode = OL.CustomerCode
Where O.CustomerCode = '$cuscode' And OL.BalanceToPay > 0
Order BY TransDate
"""); //8015073303
    log("resuklutt::$result2");
    return result2;
  }
//  Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CardName || ','   end,', ' || A.CardName || ',' ) > 0  AnD
  static Future<List<EnquiriesData>> getEnqfilterapply(Database db,String assignto,String cusname,String cusgroup,String enqstatus,String lookingfor,String intlevel,String ordertype,double? balanceabove,String fromdate,String enddate)async{

// log("resultqueru::::" + """
//    SELECT *  from Enquiryfilter A
//       Where 
//     Instr(case when length('$assignto') <> 0 then ',' || '$assignto' || ',' else ','||' A.AssignedToUserName || ','  end,',' || A.AssignedToUserName || ',' ) > 0 AND
// 	   case when length('$cusgroup') <> 0 then A.CustomerGroup else '$cusgroup' end = '$cusgroup' AnD
// 	  case when length('$enqstatus') <> 0 then A.SlpStatusTab else '$enqstatus' end = '$enqstatus' AnD
// 	  case when length('$lookingfor') <> 0 then A.Lookingfor else '$lookingfor' end = '$lookingfor' AnD
// 	  case when length('$intlevel') <> 0 then A.InterestLevel else '$intlevel' end = '$intlevel' AnD
// 	  case when length('$ordertype') <> 0 then A.OrderType else '$ordertype' end = '$ordertype' AnD
	  
// 	   PotentialValue >=$balanceabove And
// 	  date(A.CreatedDateTime) BETWEEN '$fromdate' AND '$enddate'
    
// """);
   final List<Map<String, Object?>> result= await db.rawQuery("""
   SELECT *  from Enquiryfilter A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedToUserName || ','  end,', ' || A.AssignedToUserName || ',' ) > 0 AND
   
	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.CustomerGroup || ','   end,', ' || A.CustomerGroup || ',' ) > 0  AnD
	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.SlpStatusTab || ','   end,', ' || A.SlpStatusTab || ',' ) > 0  AnD
	 Instr(case when length('$lookingfor') <> 0 then ', ' || '$lookingfor' || ',' else ', '|| A.Lookingfor || ','   end,', ' || A.Lookingfor || ',' ) > 0  AnD
	 Instr(case when length('$intlevel') <> 0 then ', ' || '$intlevel' || ',' else ', '|| A.InterestLevel || ','   end,', ' || A.InterestLevel || ',' ) > 0  AnD
	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   PotentialValue >=$balanceabove And
	  date(A.CreatedDateTime) BETWEEN '$fromdate' AND '$enddate'
    
""");
// log("resultqueru::::" + """
//    SELECT *  from Enquiryfilter A
//       Where 
//     Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedToUserName || ','  end,', ' || A.AssignedToUserName || ',' ) > 0 AND
//     Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CardName || ','   end,', ' || A.CardName || ',' ) > 0  AnD
// 	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.CustomerGroup || ','   end,', ' || A.CustomerGroup || ',' ) > 0  AnD
// 	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.SlpStatusTab || ','   end,', ' || A.SlpStatusTab || ',' ) > 0  AnD
// 	 Instr(case when length('$lookingfor') <> 0 then ', ' || '$lookingfor' || ',' else ', '|| A.Lookingfor || ','   end,', ' || A.Lookingfor || ',' ) > 0  AnD
// 	 Instr(case when length('$intlevel') <> 0 then ', ' || '$intlevel' || ',' else ', '|| A.InterestLevel || ','   end,', ' || A.InterestLevel || ',' ) > 0  AnD
// 	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
//    PotentialValue >=$balanceabove And
// 	  date(A.CreatedDateTime) BETWEEN '$fromdate' AND '$enddate'
    
// """);
 log("result::::" + result.toString());
    return List.generate(result.length, (i) {
      return EnquiriesData(
         InterestLevel: result[i]['InterestLevel'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        contactName: result[i]['ContactName'].toString(), 
        altermobileNo: result[i]['AltermobileNo'].toString(), 
        customerGroup: result[i]['CustomerGroup'].toString(), 
        Mgr_UserName: result[i]['MgrUserName'].toString(), 
        comapanyname: result[i]['Comapanyname'].toString(), 
        visitTime: result[i]['VisitTime'].toString(), 
        remindOn: result[i]['RemindOn'].toString(), 
        isClosed: result[i]['IsClosed'].toString(), 
        isVisitRequired: result[i]['IsVisitRequired'].toString(), 
        storecode: result[i]['Storecode'].toString(), 
        area: result[i]['Area'].toString(), 
        district: result[i]['District'].toString(), 
        itemCode: result[i]['ItemCode'].toString(), 
        itemname: result[i]['Itemname'].toString(), 
        leadConverted:result[i]['LeadConverted'] == 0
              ? false
              :  true, 
        createdBy: int.parse(result[i]['CreatedBy'].toString()), 
        createdDateTime: result[i]['CreatedDateTime'].toString(), 
        updatedBy: int.parse(result[i]['UpdatedBy'].toString()), 
        updatedDateTime: result[i]['UpdatedDateTime'].toString(), 
        enquirydscription: result[i]['Enquirydscription'].toString(), 
        quantity:result[i]['Quantity']==null?0.0: double.parse(result[i]['Quantity'].toString()), 
        EnqID: int.parse(result[i]['EnqID'].toString()), 
        CardCode: result[i]['CardCode'].toString(), 
        Status: result[i]['Status'].toString(), 
        CardName: result[i]['CardName'].toString(), 
        AssignedTo_User: result[i]['AssignedToUser'].toString(), 
        EnqDate: result[i]['EnqDate'].toString(), 
        Followup: result[i]['Followup'].toString(), 
        Mgr_UserCode: result[i]['MgrUserCode'].toString(), 
        AssignedTo_UserName: result[i]['AssignedToUserName'].toString(), 
        EnqType: result[i]['EnqType'].toString(), 
        Lookingfor: result[i]['Lookingfor'].toString(), 
        PotentialValue: double.parse(result[i]['PotentialValue'].toString()), 
        Address_Line_1: result[i]['AddressLine1'].toString(), 
        Address_Line_2: result[i]['AddressLine2'].toString(), 
        Pincode: result[i]['Pincode'].toString(), 
        City: result[i]['City'].toString(), 
        State: result[i]['State'].toString(), 
        Country: result[i]['Country'].toString(), 
        Manager_Status_Tab: result[i]['ManagerStatusTab'].toString(), 
        Slp_Status_Tab: result[i]['SlpStatusTab'].toString(), 
        email: result[i]['Email'].toString(), 
        referal: result[i]['Referal'].toString(), 
        customermobile: result[i]['Customermobile'].toString()
        
      );
    });
}

// Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CustomerName || ','   end,', ' || A.CustomerName || ',' ) > 0  AnD
static Future<List<GetAllLeadData>> getleadfilterapply(Database db,String assignto,String cusname,String cusgroup,String enqstatus,String intlevel,String ordertype,double? balanceabove,String fromdate,String enddate)async{

   final List<Map<String, Object?>> result= await db.rawQuery("""
   SELECT *  from Leadfilter A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
    
	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.Cusgroup || ','   end,', ' || A.Cusgroup || ',' ) > 0  AnD
	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.Status || ','   end,', ' || A.Status || ',' ) > 0  AnD
	 Instr(case when length('$intlevel') <> 0 then ', ' || '$intlevel' || ',' else ', '|| A.InterestLevel || ','   end,', ' || A.InterestLevel || ',' ) > 0  AnD
	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   Value >=$balanceabove And
	  date(A.CreatedDate) BETWEEN '$fromdate' AND '$enddate'
    
""");

 log("result::::" + """
   SELECT *  from Leadfilter A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
    Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CustomerName || ','   end,', ' || A.CustomerName || ',' ) > 0  AnD
	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.Cusgroup || ','   end,', ' || A.Cusgroup || ',' ) > 0  AnD
	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.Status || ','   end,', ' || A.Status || ',' ) > 0  AnD
	 Instr(case when length('$intlevel') <> 0 then ', ' || '$intlevel' || ',' else ', '|| A.InterestLevel || ','   end,', ' || A.InterestLevel || ',' ) > 0  AnD
	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   Value >=$balanceabove And
	  date(A.CreatedDate) BETWEEN '$fromdate' AND '$enddate'
    
""");
    return List.generate(result.length, (i) {
      return GetAllLeadData(
        InterestLevel: result[i]['InterestLevel'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        LeadDocEntry:int.parse( result[i]['LeadDocEntry'].toString()), 
        LeadNum: int.parse(result[i]['LeadNum'].toString()), 
        Mobile: result[i]['Mobile'].toString(), 
        CustomerName: result[i]['CustomerName'].toString(), 
        DocDate: result[i]['DocDate'].toString(), 
        City: result[i]['City'].toString(), 
        NextFollowup: result[i]['NextFollowup'].toString(), 
        Product: result[i]['Product'].toString(), 
        Value: double.parse(result[i]['Value'].toString()), 
        Status: result[i]['Status'].toString(), 
        LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
        LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
        FollowupEntry:int.parse( result[i]['FollowupEntry'].toString()), 
        customermob: result[i]['Customermob'].toString(), 
        cusEmail: result[i]['CusEmail'].toString(), 
        companyname: result[i]['Companyname'].toString(), 
        cusgroup: result[i]['Cusgroup'].toString(), 
        storecode: result[i]['Storecode'].toString(), 
        add1: result[i]['Add1'].toString(),
         add2: result[i]['Add2'].toString(), 
         area: result[i]['Area'].toString(), 
        district: result[i]['District'].toString(), 
        state: result[i]['State'].toString(), 
        country: result[i]['Country'].toString(), 
        pincode: result[i]['Pincode'].toString(), 
        gender: result[i]['Gender'].toString(), 
        agegroup: result[i]['Agegroup'].toString(), 
        cameAs: result[i]['CameAs'].toString(), 
        headcount: int.parse(result[i]['Headcount'].toString()), 
        maxbudget:double.parse( result[i]['Maxbudget'].toString()), 
        assignedTo: result[i]['AssignedTo'].toString(), 
        refferal: result[i]['Refferal'].toString(), 
        purchasePlan: result[i]['PurchasePlan'].toString(), 
        dealDescription: result[i]['DealDescription'].toString(), 
        lastFollowupDate: result[i]['LastFollowupDate'].toString(), 
        createdBy: int.parse(result[i]['CreatedBy'].toString()), 
        createdDate: result[i]['CreatedDate'].toString(), 
        updatedBy: int.parse(result[i]['UpdatedBy'].toString()), 
        updatedDate: result[i]['UpdatedDate'].toString(), 
        traceId: result[i]['TraceId'].toString()
        );
    });
}


static Future<List<OpenLeadfiltermodel>> getopenleadfilterapply(Database db,String assignto,String cusname,String cusgroup,String enqstatus,String intlevel,String ordertype,double? balanceabove,String fromdate,String enddate)async{

   final List<Map<String, Object?>> result= await db.rawQuery("""
   SELECT *  from openLeadfilter A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
    
	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.Cusgroup || ','   end,', ' || A.Cusgroup || ',' ) > 0  AnD
	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.Status || ','   end,', ' || A.Status || ',' ) > 0  AnD
	 Instr(case when length('$intlevel') <> 0 then ', ' || '$intlevel' || ',' else ', '|| A.InterestLevel || ','   end,', ' || A.InterestLevel || ',' ) > 0  AnD
	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   Value >=$balanceabove And
	  date(A.CreatedDate) BETWEEN '$fromdate' AND '$enddate'
    
""");

 
    return List.generate(result.length, (i) {
      return OpenLeadfiltermodel(
        InterestLevel: result[i]['InterestLevel'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        LeadDocEntry:int.parse( result[i]['LeadDocEntry'].toString()), 
        LeadNum: int.parse(result[i]['LeadNum'].toString()), 
        Mobile: result[i]['Mobile'].toString(), 
        CustomerName: result[i]['CustomerName'].toString(), 
        DocDate: result[i]['DocDate'].toString(), 
        City: result[i]['City'].toString(), 
        NextFollowup: result[i]['NextFollowup'].toString(), 
        Product: result[i]['Product'].toString(), 
        Value: double.parse(result[i]['Value'].toString()), 
        Status: result[i]['Status'].toString(), 
        LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
        LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
        FollowupEntry:int.parse( result[i]['FollowupEntry'].toString()), 
        customermob: result[i]['Customermob'].toString(), 
        cusEmail: result[i]['CusEmail'].toString(), 
        companyname: result[i]['Companyname'].toString(), 
        cusgroup: result[i]['Cusgroup'].toString(), 
        storecode: result[i]['Storecode'].toString(), 
        add1: result[i]['Add1'].toString(),
         add2: result[i]['Add2'].toString(), 
         area: result[i]['Area'].toString(), 
        district: result[i]['District'].toString(), 
        state: result[i]['State'].toString(), 
        country: result[i]['Country'].toString(), 
        pincode: result[i]['Pincode'].toString(), 
        gender: result[i]['Gender'].toString(), 
        agegroup: result[i]['Agegroup'].toString(), 
        cameAs: result[i]['CameAs'].toString(), 
        headcount: int.parse(result[i]['Headcount'].toString()), 
        maxbudget:double.parse( result[i]['Maxbudget'].toString()), 
        assignedTo: result[i]['AssignedTo'].toString(), 
        refferal: result[i]['Refferal'].toString(), 
        purchasePlan: result[i]['PurchasePlan'].toString(), 
        dealDescription: result[i]['DealDescription'].toString(), 
        lastFollowupDate: result[i]['LastFollowupDate'].toString(), 
        createdBy: int.parse(result[i]['CreatedBy'].toString()), 
        createdDate: result[i]['CreatedDate'].toString(), 
        updatedBy: int.parse(result[i]['UpdatedBy'].toString()), 
        updatedDate: result[i]['UpdatedDate'].toString(), 
        traceId: result[i]['TraceId'].toString()
        );
    });
}

  static Future<List<Map<String, Object?>>> getoutstndPdfSecList(
      Database db, String cuscode) async {
    List<Map<String, Object?>> result2 = await db.rawQuery("""
Select Sum(C1) C1,Sum(C2) C2,Sum(C3) C3,Sum(C4) C4, Sum(C5) C5
From (
Select  Case When julianday('now') - julianday(TransDate) < 31 Then OL.BalanceToPay Else 0 End 'C1',
Case When julianday('now') - julianday(TransDate) between 31 and 60 Then OL.BalanceToPay Else 0 End 'C2',
Case When julianday('now') - julianday(TransDate) between 61 and 90 Then OL.BalanceToPay Else 0 End 'C3',
Case When julianday('now') - julianday(TransDate) between 91 and 120 Then OL.BalanceToPay Else 0 End 'C4',
Case When julianday('now') - julianday(TransDate) > 120 Then OL.BalanceToPay Else 0 End 'C5'
From Outstanding O
Inner Join Outstandingline OL on O.CustomerCode = OL.CustomerCode
Where O.CustomerCode = '$cuscode' And OL.BalanceToPay > 0) Tbl
"""); //8015073303
    log("resuklutt second::$result2");
    return result2;
  }

  static Future<List<Map<String, Object?>>> getOutLFtr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableoutstanding
WHERE $column IS NOT '';
''');

    //  log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getEnqftr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableEnquiryfilter
WHERE $column IS NOT '';
''');

    //  log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
  }
  static Future<List<Map<String, Object?>>> getleadftr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableLeadfilter
WHERE $column IS NOT '';
''');

    //  log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
  }

   static Future<List<Map<String, Object?>>> getopenleadftr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableopenLeadfilter
WHERE $column IS NOT '';
''');

    //  log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
  }

  static Future insertopenleadMaster(
      List<leadopenDBmodel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("tableopenlead len: " + values.length.toString());
    log("tableopenlead len: " + data.length.toString());

    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableopenlead, es);
      log("tableopenlead Batchhhh Item...");
    });
    await batch.commit();
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

  static Future<List<ItemMasterDBModel>> getFavData(
      String fav, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $fav,IsSelected,Favorite
 FROM ItemMaster
WHERE $fav IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
        calcType: '',
        payOn: '',
          // id:int.parse( result[i]['Id'].toString()) ,
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
          whsStock: 0.0, // double.parse( result[i]['WhsStock'].toString()),
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
          eol: false,
          veryFast: false,
          fast: false,
          slow: false,
          verySlow: false,
          serialNumber: false,
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
          allowNegativeStock: false,
          allowOrderBelowCost: false,
          isFixedPrice: false,
          validTill: '',
          color: '');
    });
  }


  static Future<List<ItemMasterDBModel>> onFieldScanned(
      String itemcode,Database db
      ) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From ItemMaster A
      Where 
      Instr(case when length('$itemcode') <> 0 then ', ' || '$itemcode' || ',' else ', '|| A.ItemCode || ','  end,', ' || A.ItemCode || ',' ) > 0
      
""");

    
    

    log(("""
 SELECT * From ItemMaster A
      Where 
      A.ItemCode <> 'null' and coalesce(A.ItemCode,'') <> '' AND
      
      ('$itemcode' = '' OR A.ItemCode in ($itemcode)) 
      
"""));

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
        calcType:result[i]['calcType'].toString() ,
        payOn:result[i]['payOn'].toString() ,
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
          taxRate: result[i]['TaxRate'] == null
              ? 0
              : int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: result[i]['eol'] == null
              ? false
              : bool.parse(result[i]['eol'].toString()),
          veryFast: result[i]['VeryFast'] == null
              ? false
              : bool.parse(result[i]['VeryFast'].toString()),
          fast: result[i]['Fast'] == null
              ? false
              : bool.parse(result[i]['Fast'].toString()),
          slow: result[i]['Slow'] == null
              ? false
              : bool.parse(result[i]['Slow'].toString()),
          verySlow: result[i]['VerySlow'] == null
              ? false
              : bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: result[i]['SerialNumber'] == null
              ? false
              : bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: result[i]['PriceStockId'] == null
              ? 0
              : int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: result[i]['Sp'] == null
              ? 0.0
              : double.parse(result[i]['Sp'].toString()),
          ssp1: result[i]['Ssp1'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1'].toString()),
          ssp2: result[i]['Ssp2'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2'].toString()),
          ssp3: result[i]['Ssp3'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3'].toString()),
          ssp4: result[i]['Ssp4'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4'].toString()),
          ssp5: result[i]['Ssp5'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5'].toString()),
          ssp1Inc: result[i]['Ssp1Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1Inc'].toString()),
          ssp2Inc: result[i]['Ssp2Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc: result[i]['Ssp3Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3Inc'].toString()),
          ssp4Inc: result[i]['Ssp4Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4Inc'].toString()),
          ssp5Inc: result[i]['Ssp5Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5Inc'].toString()),
          allowNegativeStock: result[i]['AllowNegativeStock'] == null
              ? false
              : bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost: result[i]['AllowOrderBelowCost'] == null
              ? false
              : bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: result[i]['IsFixedPrice'] == null
              ? false
              : bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString());
    });
  }

  static Future<List<ItemMasterDBModel>> onFieldSeleted(
      String brand,
      String category,
      String segment,
      String isselectedBrand,
      String isSelectedCate,
      String isSelectedsegment,
      String fromAmt,
      String toAmount,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
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
    String data = """
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
        calcType:result[i]['calcType'].toString() ,
        payOn:result[i]['payOn'].toString() ,
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
          taxRate: result[i]['TaxRate'] == null
              ? 0
              : int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: result[i]['eol'] == null
              ? false
              : bool.parse(result[i]['eol'].toString()),
          veryFast: result[i]['VeryFast'] == null
              ? false
              : bool.parse(result[i]['VeryFast'].toString()),
          fast: result[i]['Fast'] == null
              ? false
              : bool.parse(result[i]['Fast'].toString()),
          slow: result[i]['Slow'] == null
              ? false
              : bool.parse(result[i]['Slow'].toString()),
          verySlow: result[i]['VerySlow'] == null
              ? false
              : bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: result[i]['SerialNumber'] == null
              ? false
              : bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: result[i]['PriceStockId'] == null
              ? 0
              : int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: result[i]['Sp'] == null
              ? 0.0
              : double.parse(result[i]['Sp'].toString()),
          ssp1: result[i]['Ssp1'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1'].toString()),
          ssp2: result[i]['Ssp2'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2'].toString()),
          ssp3: result[i]['Ssp3'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3'].toString()),
          ssp4: result[i]['Ssp4'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4'].toString()),
          ssp5: result[i]['Ssp5'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5'].toString()),
          ssp1Inc: result[i]['Ssp1Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1Inc'].toString()),
          ssp2Inc: result[i]['Ssp2Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc: result[i]['Ssp3Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3Inc'].toString()),
          ssp4Inc: result[i]['Ssp4Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4Inc'].toString()),
          ssp5Inc: result[i]['Ssp5Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5Inc'].toString()),
          allowNegativeStock: result[i]['AllowNegativeStock'] == null
              ? false
              : bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost: result[i]['AllowOrderBelowCost'] == null
              ? false
              : bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: result[i]['IsFixedPrice'] == null
              ? false
              : bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString());
    });
  }

// static Future<List<ItemMasterDBModel>> onFieldApply(

//       String isselectedBrand,
//       String isSelectedCate,

//       Database db) async {
//     final List<Map<String, Object?>> result = await db.rawQuery("""
//  SELECT * From $tableoutstanding A
//       Where
//       A.AssignedTo <> 'null' and coalesce(A.AssignedTo,'') <> '' AND
//       A.CustomerName <> 'null' and coalesce(A.CustomerName,'') <> '' AND

//       ('$isselectedBrand' = '' OR A.Brand in ($brand))
//       AND ('$isSelectedCate' = '' OR A.Category in ($category))

// """);

//     // log("Saved AllocATE: " + result.toList().toString());
//     // log("Saved AllocATE length: " + result.length.toString());

//     ///
//     String data = """
//  SELECT * From ItemMaster A
//       Where
//       A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
//       A.Segment <> 'null' and coalesce(A.Segment,'') <> '' AND
//       A.Category <> 'null' and coalesce(A.Category,'') <> '' AND
//       ('$isselectedBrand' = '' OR A.Brand in ($brand))
//       AND ('$isSelectedCate' = '' OR A.Category in ($category))
//       AND ('$isSelectedsegment' = '' OR A.Segment in ($segment))
// """;

//     log(data.toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//           id: int.parse(result[i]['Id'].toString()),
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
//            itemDescription:result[i]['ItemDescription'].toString(),
//         modelNo:result[i]['ModelNo'].toString(),
//         partCode:result[i]['PartCode'].toString(),
//         skucode:result[i]['Skucode'].toString(),
//         brandCode:result[i]['BrandCode'].toString(),
//         itemGroup:result[i]['ItemGroup'].toString(),
//         specification:result[i]['Specification'].toString(),
//         sizeCapacity:result[i]['SizeCapacity'].toString(),
//         clasification:result[i]['Clasification'].toString(),
//         uoM:result[i]['UoM'].toString(),
//         taxRate:result[i]['TaxRate']==null? 0:int.parse(result[i]['TaxRate'].toString()),
//         catalogueUrl1:result[i]['CatalogueUrl1'].toString(),
//         catalogueUrl2:result[i]['CatalogueUrl2'].toString(),
//         imageUrl1:result[i]['ImageUrl1'].toString(),
//         imageUrl2:result[i]['ImageUrl2'].toString(),
//         textNote:result[i]['TextNote'].toString(),
//         status:result[i]['Status'].toString(),
//         movingType:result[i]['MovingType'].toString(),
//         eol:result[i]['eol']==null?false :bool.parse(result[i]['eol'].toString()),
//         veryFast:result[i]['VeryFast']==null?false :bool.parse(result[i]['VeryFast'].toString()),
//         fast:result[i]['Fast']==null?false :bool.parse(result[i]['Fast'].toString()),
//         slow:result[i]['Slow']==null?false :bool.parse(result[i]['Slow'].toString()),
//         verySlow:result[i]['VerySlow']==null?false :bool.parse(result[i]['VerySlow'].toString()),
//         serialNumber:result[i]['SerialNumber']==null?false :bool.parse(result[i]['SerialNumber'].toString()),
//         priceStockId:result[i]['PriceStockId']==null?0:int.parse(result[i]['PriceStockId'].toString()),
//         storeCode:result[i]['StoreCode'].toString(),
//         whseCode:result[i]['WhseCode'].toString(),
//        sp:result[i]['Sp']==null?0.0:double.parse(result[i]['Sp'].toString()),
//         ssp1:result[i]['Ssp1']==null?0.0:double.parse(result[i]['Ssp1'].toString()),
//         ssp2:result[i]['Ssp2']==null?0.0:double.parse(result[i]['Ssp2'].toString()),
//         ssp3:result[i]['Ssp3']==null?0.0:double.parse(result[i]['Ssp3'].toString()),
//         ssp4:result[i]['Ssp4'].toString(),
//         ssp5:result[i]['Ssp5'].toString(),
//         ssp1Inc:result[i]['Ssp1Inc'].toString(),
//         ssp2Inc:result[i]['Ssp2Inc'].toString(),
//         ssp3Inc:result[i]['Ssp3Inc'].toString(),
//         ssp4Inc:result[i]['Ssp4Inc'].toString(),
//         ssp5Inc:result[i]['Ssp5Inc'].toString(),
//         allowNegativeStock:result[i]['AllowNegativeStock']==null?false :bool.parse(result[i]['AllowNegativeStock'].toString()),

//         allowOrderBelowCost:result[i]['AllowOrderBelowCost']==null?false :bool.parse(result[i]['AllowOrderBelowCost'].toString()),
//         isFixedPrice:result[i]['IsFixedPrice']==null?false :bool.parse(result[i]['IsFixedPrice'].toString()),
//         validTill:result[i]['ValidTill'].toString(),
//         color:result[i]['color'].toString()
//           );
//     });
//   }
  /// view all

  static Future<List<ItemMasterDBModel>> getViewAllData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $data,IsSelected
 FROM ItemMaster
WHERE $data IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          // id: int.parse(result[i]['Id'].toString()),
           calcType:"" ,
        payOn:"" ,
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
          eol: false,
          veryFast: false,
          fast: false,
          slow: false,
          verySlow: false,
          serialNumber: false,
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
          allowNegativeStock: false,
          allowOrderBelowCost: false,
          isFixedPrice: false,
          validTill: '',
          color: '' //double.parse( result[i]['WhsStock'].toString()),
          );
    });
  }

  static Future<List<ItemMasterDBModel>> getSearchData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
Select * from ItemMaster where (ItemCode || ' - ' || ItemName) Like '%$data%';
''');

    log("Search data: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
         calcType:result[i]['calcType'].toString() ,
        payOn:result[i]['payOn'].toString() ,
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
          taxRate: result[i]['TaxRate'] == null
              ? 0
              : int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: result[i]['eol'] == null
              ? false
              : bool.parse(result[i]['eol'].toString()),
          veryFast: result[i]['Fast'] == null
              ? false
              : bool.parse(result[i]['Fast'].toString()),
          fast: result[i]['VeryFast'] == null
              ? false
              : bool.parse(result[i]['VeryFast'].toString()),
          slow: result[i]['Slow'] == null
              ? false
              : bool.parse(result[i]['Slow'].toString()),
          verySlow: result[i]['VerySlow'] == null
              ? false
              : bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: result[i]['SerialNumber'] == null
              ? false
              : bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: result[i]['PriceStockId'] == null
              ? 0
              : int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: result[i]['Sp'] == null
              ? 0.0
              : double.parse(result[i]['Sp'].toString()),
          ssp1: result[i]['Ssp1'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1'].toString()),
          ssp2: result[i]['Ssp2'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2'].toString()),
          ssp3: result[i]['Ssp3'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3'].toString()),
          ssp4: result[i]['Ssp4'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4'].toString()),
          ssp5: result[i]['Ssp5'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5'].toString()),
          ssp1Inc: result[i]['Ssp1Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1Inc'].toString()),
          ssp2Inc: result[i]['Ssp2Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc: result[i]['Ssp3Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3Inc'].toString()),
          ssp4Inc: result[i]['Ssp4Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4Inc'].toString()),
          ssp5Inc: result[i]['Ssp5Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5Inc'].toString()),
          allowNegativeStock: result[i]['AllowNegativeStock'] == null
              ? false
              : bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost: result[i]['AllowOrderBelowCost'] == null
              ? false
              : bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: result[i]['IsFixedPrice'] == null
              ? false
              : bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString());
    });
  }

  //update
  static Future<void> updateItemMaster(
      String ID, ItemMasterDBModel itemMaserPriceAvail, Database db) async {
// print("mgrPrice: "+itemMaserPriceAvail.mgrPrice.toString());
// print("refreshedRecordDate: "+itemMaserPriceAvail.refreshedRecordDate.toString());
// print("slpPrice "+itemMaserPriceAvail.slpPrice.toString());
// print("whsStock "+itemMaserPriceAvail.whsStock.toString());
// print("storeStock: "+itemMaserPriceAvail.storeStock.toString());
// print("storeID ID: "+ID.toString());

    final List<Map<String, Object?>> result = await db.rawQuery('''
      UPDATE $tableItemMaster
SET MgrPrice = ${itemMaserPriceAvail.mgrPrice},
 SlpPrice = ${itemMaserPriceAvail.slpPrice} ,
 StoreStock = ${itemMaserPriceAvail.storeStock} ,
 WhsStock = ${itemMaserPriceAvail.whsStock},
 RefreshedRecordDate = "${itemMaserPriceAvail.refreshedRecordDate}" WHERE IMId = "$ID";
    ''');
  }

  static Future<List<leadopenDBmodel>> getleadopenparticular(
      int data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
Select * from tableopenlead where LeadDocEntry=$data;
''');

    log("Search data: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return leadopenDBmodel(
          City: result[i]['City'].toString(),
          CustomerName: result[i]['CustomerName'].toString(),
          DocDate: result[i]['DocDate'].toString(),
          FollowupEntry: int.parse(result[i]['FollowupEntry'].toString()),
          LastUpdateMessage: result[i]['LastUpdateMessage'].toString(),
          LastUpdateTime: result[i]['LastUpdateTime'].toString(),
          LeadDocEntry: int.parse(result[i]['LeadDocEntry'].toString()),
          LeadNum: int.parse(result[i]['LeadNum'].toString()),
          Mobile: result[i]['Mobile'].toString(),
          NextFollowup: result[i]['NextFollowup'].toString(),
          Product: result[i]['Product'].toString(),
          Status: result[i]['Status'].toString(),
          Value: double.parse(result[i]['Value'].toString()),
          add1: result[i]['Add1'].toString(),
          add2: result[i]['Add2'].toString(),
          agegroup: result[i]['Agegroup'].toString(),
          area: result[i]['Area'].toString(),
          assignedTo: result[i]['AssignedTo'].toString(),
          cameAs: result[i]['CameAs'].toString(),
          companyname: result[i]['Companyname'].toString(),
          country: result[i]['Country'].toString(),
          createdBy: int.parse(result[i]['CreatedBy'].toString()),
          createdDate: result[i]['CreatedDate'].toString(),
          cusEmail: result[i]['CusEmail'].toString(),
          cusgroup: result[i]['Cusgroup'].toString(),
          customermob: result[i]['Customermob'].toString(),
          dealDescription: result[i]['DealDescription'].toString(),
          district: result[i]['District'].toString(),
          gender: result[i]['Gender'].toString(),
          headcount: int.parse(result[i]['Headcount'].toString()),
          lastFollowupDate: result[i]['LastFollowupDate'].toString(),
          maxbudget: double.parse(result[i]['Maxbudget'].toString()),
          pincode: result[i]['Pincode'].toString(),
          purchasePlan: result[i]['PurchasePlan'].toString(),
          refferal: result[i]['Refferal'].toString(),
          state: result[i]['State'].toString(),
          storecode: result[i]['Storecode'].toString(),
          traceId: result[i]['TraceId'].toString(),
          updatedBy: int.parse(result[i]['UpdatedBy'].toString()),
          updatedDate: result[i]['UpdatedDate'].toString());
    });
  }

  static Future<List<leadopenDBmodel>> getopenlead(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(""" Select * from tableopenlead
""");
    return List.generate(result.length, (i) {
      return leadopenDBmodel(
          City: result[i]['City'].toString(),
          CustomerName: result[i]['CustomerName'].toString(),
          DocDate: result[i]['DocDate'].toString(),
          FollowupEntry: int.parse(result[i]['FollowupEntry'].toString()),
          LastUpdateMessage: result[i]['LastUpdateMessage'].toString(),
          LastUpdateTime: result[i]['LastUpdateTime'].toString(),
          LeadDocEntry: int.parse(result[i]['LeadDocEntry'].toString()),
          LeadNum: int.parse(result[i]['LeadNum'].toString()),
          Mobile: result[i]['Mobile'].toString(),
          NextFollowup: result[i]['NextFollowup'].toString(),
          Product: result[i]['Product'].toString(),
          Status: result[i]['Status'].toString(),
          Value: double.parse(result[i]['Value'].toString()),
          add1: result[i]['Add1'].toString(),
          add2: result[i]['Add2'].toString(),
          agegroup: result[i]['Agegroup'].toString(),
          area: result[i]['Area'].toString(),
          assignedTo: result[i]['AssignedTo'].toString(),
          cameAs: result[i]['CameAs'].toString(),
          companyname: result[i]['Companyname'].toString(),
          country: result[i]['Country'].toString(),
          createdBy: int.parse(result[i]['CreatedBy'].toString()),
          createdDate: result[i]['CreatedDate'].toString(),
          cusEmail: result[i]['CusEmail'].toString(),
          cusgroup: result[i]['Cusgroup'].toString(),
          customermob: result[i]['Customermob'].toString(),
          dealDescription: result[i]['DealDescription'].toString(),
          district: result[i]['District'].toString(),
          gender: result[i]['Gender'].toString(),
          headcount: int.parse(result[i]['Headcount'].toString()),
          lastFollowupDate: result[i]['LastFollowupDate'].toString(),
          maxbudget: double.parse(result[i]['Maxbudget'].toString()),
          pincode: result[i]['Pincode'].toString(),
          purchasePlan: result[i]['PurchasePlan'].toString(),
          refferal: result[i]['Refferal'].toString(),
          state: result[i]['State'].toString(),
          storecode: result[i]['Storecode'].toString(),
          traceId: result[i]['TraceId'].toString(),
          updatedBy: int.parse(result[i]['UpdatedBy'].toString()),
          updatedDate: result[i]['UpdatedDate'].toString());
    });
  }

  static Future<List<ItemMasterDBModel>> getAllProducts(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From ItemMaster 
""");
    // log("result::::" + result.toString());
    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
         calcType:result[i]['calcType'].toString() ,
        payOn:result[i]['payOn'].toString() ,
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
          taxRate: result[i]['TaxRate'] == null
              ? 0
              : int.parse(result[i]['TaxRate'].toString()),
          catalogueUrl1: result[i]['CatalogueUrl1'].toString(),
          catalogueUrl2: result[i]['CatalogueUrl2'].toString(),
          imageUrl1: result[i]['ImageUrl1'].toString(),
          imageUrl2: result[i]['ImageUrl2'].toString(),
          textNote: result[i]['TextNote'].toString(),
          status: result[i]['Status'].toString(),
          movingType: result[i]['MovingType'].toString(),
          eol: result[i]['eol'] == null
              ? false
              : bool.parse(result[i]['eol'].toString()),
          veryFast: result[i]['VeryFast'] == null
              ? false
              : bool.parse(result[i]['VeryFast'].toString()),
          fast: result[i]['Fast'] == null
              ? false
              : bool.parse(result[i]['Fast'].toString()),
          slow: result[i]['Slow'] == null
              ? false
              : bool.parse(result[i]['Slow'].toString()),
          verySlow: result[i]['VerySlow'] == null
              ? false
              : bool.parse(result[i]['VerySlow'].toString()),
          serialNumber: result[i]['SerialNumber'] == null
              ? false
              : bool.parse(result[i]['SerialNumber'].toString()),
          priceStockId: result[i]['PriceStockId'] == null
              ? 0
              : int.parse(result[i]['PriceStockId'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          whseCode: result[i]['WhseCode'].toString(),
          sp: result[i]['Sp'] == null
              ? 0.0
              : double.parse(result[i]['Sp'].toString()),
          ssp1: result[i]['Ssp1'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1'].toString()),
          ssp2: result[i]['Ssp2'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2'].toString()),
          ssp3: result[i]['Ssp3'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3'].toString()),
          ssp4: result[i]['Ssp4'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4'].toString()),
          ssp5: result[i]['Ssp5'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5'].toString()),
          ssp1Inc: result[i]['Ssp1Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp1Inc'].toString()),
          ssp2Inc: result[i]['Ssp2Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp2Inc'].toString()),
          ssp3Inc: result[i]['Ssp3Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp3Inc'].toString()),
          ssp4Inc: result[i]['Ssp4Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp4Inc'].toString()),
          ssp5Inc: result[i]['Ssp5Inc'] == null
              ? 0.0
              : double.parse(result[i]['Ssp5Inc'].toString()),
          allowNegativeStock: result[i]['AllowNegativeStock'] == null
              ? false
              : bool.parse(result[i]['AllowNegativeStock'].toString()),
          allowOrderBelowCost: result[i]['AllowOrderBelowCost'] == null
              ? false
              : bool.parse(result[i]['AllowOrderBelowCost'].toString()),
          isFixedPrice: result[i]['IsFixedPrice'] == null
              ? false
              : bool.parse(result[i]['IsFixedPrice'].toString()),
          validTill: result[i]['ValidTill'].toString(),
          color: result[i]['color'].toString());
    });
  }
//outstanding get
//  SELECT  * from $tableoutstanding A
//       Where
//       case when length('$assignto') <> 0 then A.AssignedTo else '$assignto' end = '$assignto' AND
//       case when length('$cusname') <> 0 then A.CustomerName else '$cusname' end = '$cusname'
// case when length('$assignto') <> 0 then A.AssignedTo else '$assignto' end = '$assignto' AND
      // case when length('$cusname') <> 0 then A.CustomerName else '$cusname' end = '$cusname' AnD
	 
  static Future<List<outstandingDBModel>> getfilterapply(
      Database db,
      String assignto,
      String cusname,
      String tranref,
      String loanref,
      int? age,
      int? balanceabove) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
   SELECT AssignedTo,CustomerName,CustomerCode, sum(TransAmount) TransAmount ,
 sum(AmountPaid) AmountPaid,sum(BalanceToPay) BalanceToPay  from Outstandingline A
      Where 
       Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
    Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CustomerName || ','   end,', ' || A.CustomerName || ',' ) > 0  AnD
	  
       case when length('$tranref') <> 0 then A.TransNum else '$tranref' end = '$tranref' AnD
	  case when length('$loanref') <> 0 then A.LoanRef else '$loanref' end = '$loanref' 
	  And BalanceToPay >=$balanceabove And julianday('now') - julianday(TransDueDate) > $age
	  GROUP by AssignedTo,CustomerName
""");
    log("result::::" + """
   SELECT AssignedTo,CustomerName,CustomerCode, sum(TransAmount) TransAmount ,
 sum(AmountPaid) AmountPaid,sum(BalanceToPay) BalanceToPay  from Outstandingline A
      Where 
       Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
    Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CustomerName || ','   end,', ' || A.CustomerName || ',' ) > 0  AnD
	  
       case when length('$tranref') <> 0 then A.TransNum else '$tranref' end = '$tranref' AnD
	  case when length('$loanref') <> 0 then A.LoanRef else '$loanref' end = '$loanref' 
	  And BalanceToPay >$balanceabove And julianday('now') - julianday(TransDueDate) > $age
	  GROUP by AssignedTo,CustomerName
""".toString());
    return List.generate(result.length, (i) {
      return outstandingDBModel(
        alternateMobileNo: '',
        amountPaid: double.parse(result[i]['AmountPaid'].toString()),
        assignedTo: result[i]['AssignedTo'].toString(),
        balanceToPay: double.parse(result[i]['BalanceToPay'].toString()),
        collectionInc: 0.0,
        companyName: '',
        contactName: "",
        customerCode: result[i]['CustomerCode'].toString(),
        customerEmail: "",
        customerGroup: '',
        customerMobile: "",
        customerName: result[i]['CustomerName'].toString(),
        gstNo: "",
        penaltyAfterDue: 0.0,
        storeCode: '',
        transAmount: double.parse(result[i]['TransAmount'].toString()),
      );
    });
  }

  static Future<List<outstandingDBModel>> getoutstandingMaster(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableoutstanding 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return outstandingDBModel(
        alternateMobileNo: result[i]['AlternateMobileNo'].toString(),
        amountPaid: double.parse(result[i]['AmountPaid'].toString()),
        assignedTo: result[i]['AssignedTo'].toString(),
        balanceToPay: double.parse(result[i]['BalanceToPay'].toString()),
        collectionInc: double.parse(result[i]['CollectionInc'].toString()),
        companyName: result[i]['CompanyName'].toString(),
        contactName: result[i]['ContactName'].toString(),
        customerCode: result[i]['CustomerCode'].toString(),
        customerEmail: result[i]['CustomerEmail'].toString(),
        customerGroup: result[i]['CustomerGroup'].toString(),
        customerMobile: result[i]['CustomerMobile'].toString(),
        customerName: result[i]['CustomerName'].toString(),
        gstNo: result[i]['GstNo'].toString(),
        penaltyAfterDue: double.parse(result[i]['PenaltyAfterDue'].toString()),
        storeCode: result[i]['StoreCode'].toString(),
        transAmount: double.parse(result[i]['TransAmount'].toString()),
      );
    });
  }

  static Future<List<Map<String, Object?>>> getmapvaluestocollection(
      Database db, String cuscode) async {
    List<Map<String, Object?>> result2 = await db.rawQuery("""
 select CustomerCode,CustomerName,AlternateMobileNo,ContactName,CustomerEmail,GstNo,
Bil_Address1,Bil_Address2,Bil_Area,Bil_City,Bil_Country,Bil_Pincode,Bil_State,StoreCode,AssignedTo


 from Outstandingline where CustomerCode='$cuscode'
""");
    log("resuklutt::" + result2.toString());
    return result2;
    // if(result2.isNotEmpty){
    //   return outstandKPI(
    //     totaloutstanding:double.parse(result2[0]['totaloutstanding'].toString()) ,
    //     overdue: double.parse(result2[0]['overdue'].toString()) ,
    //     upcoming: double.parse(result2[0]['upcoming'].toString())
    //     );
    // }else{
    //   return outstandKPI(
    //     totaloutstanding: 0,
    //     overdue: 0,
    //     upcoming: 0
    //     );
    // }
  }

  static Future<List<Map<String, Object?>>> getoutstandingKPI(
      Database db) async {
    List<Map<String, Object?>> result2 = await db.rawQuery("""
 SELECT sum (BalanceToPay) totaloutstanding,
case when DATE('now')>TransDueDate then sum(BalanceToPay) else 0 END overdue ,
case when DATE('now')<=TransDueDate then sum(BalanceToPay) else 0 END upcoming 
from Outstandingline
""");
    log("resuklutt::" + result2.toString());
    return result2;
    // if(result2.isNotEmpty){
    //   return outstandKPI(
    //     totaloutstanding:double.parse(result2[0]['totaloutstanding'].toString()) ,
    //     overdue: double.parse(result2[0]['overdue'].toString()) ,
    //     upcoming: double.parse(result2[0]['upcoming'].toString())
    //     );
    // }else{
    //   return outstandKPI(
    //     totaloutstanding: 0,
    //     overdue: 0,
    //     upcoming: 0
    //     );
    // }
  }

  static Future<List<EnquiriesData>> getEnqdatafilter(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableEnquiryfilter 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return EnquiriesData(
          InterestLevel: result[i]['InterestLevel'].toString(),
          OrderType: result[i]['OrderType'].toString(),
          contactName: result[i]['ContactName'].toString(),
          altermobileNo: result[i]['AltermobileNo'].toString(),
          customerGroup: result[i]['CustomerGroup'].toString(),
          Mgr_UserName: result[i]['MgrUserName'].toString(),
          comapanyname: result[i]['Comapanyname'].toString(),
          visitTime: result[i]['VisitTime'].toString(),
          remindOn: result[i]['RemindOn'].toString(),
          isClosed: result[i]['IsClosed'].toString(),
          isVisitRequired: result[i]['IsVisitRequired'].toString(),
          storecode: result[i]['Storecode'].toString(),
          area: result[i]['Area'].toString(),
          district: result[i]['District'].toString(),
          itemCode: result[i]['ItemCode'].toString(),
          itemname: result[i]['Itemname'].toString(),
          leadConverted: result[i]['LeadConverted'] == 0 ? false : true,
          createdBy: int.parse(result[i]['CreatedBy'].toString()),
          createdDateTime: result[i]['CreatedDateTime'].toString(),
          updatedBy: int.parse(result[i]['UpdatedBy'].toString()),
          updatedDateTime: result[i]['UpdatedDateTime'].toString(),
          enquirydscription: result[i]['Enquirydscription'].toString(),
          quantity: result[i]['Quantity'] == null
              ? 0.0
              : double.parse(result[i]['Quantity'].toString()),
          EnqID: int.parse(result[i]['EnqID'].toString()),
          CardCode: result[i]['CardCode'].toString(),
          Status: result[i]['Status'].toString(),
          CardName: result[i]['CardName'].toString(),
          AssignedTo_User: result[i]['AssignedToUser'].toString(),
          EnqDate: result[i]['EnqDate'].toString(),
          Followup: result[i]['Followup'].toString(),
          Mgr_UserCode: result[i]['MgrUserCode'].toString(),
          AssignedTo_UserName: result[i]['AssignedToUserName'].toString(),
          EnqType: result[i]['EnqType'].toString(),
          Lookingfor: result[i]['Lookingfor'].toString(),
          PotentialValue: double.parse(result[i]['PotentialValue'].toString()),
          Address_Line_1: result[i]['AddressLine1'].toString(),
          Address_Line_2: result[i]['AddressLine2'].toString(),
          Pincode: result[i]['Pincode'].toString(),
          City: result[i]['City'].toString(),
          State: result[i]['State'].toString(),
          Country: result[i]['Country'].toString(),
          Manager_Status_Tab: result[i]['ManagerStatusTab'].toString(),
          Slp_Status_Tab: result[i]['SlpStatusTab'].toString(),
          email: result[i]['Email'].toString(),
          referal: result[i]['Referal'].toString(),
          customermobile: result[i]['Customermobile'].toString());
    });
  }


 static Future<List<GetAllLeadData>> getLeaddatafilter(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableLeadfilter 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return GetAllLeadData(
        InterestLevel: result[i]['InterestLevel'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        LeadDocEntry:int.parse( result[i]['LeadDocEntry'].toString()), 
        LeadNum: int.parse(result[i]['LeadNum'].toString()), 
        Mobile: result[i]['Mobile'].toString(), 
        CustomerName: result[i]['CustomerName'].toString(), 
        DocDate: result[i]['DocDate'].toString(), 
        City: result[i]['City'].toString(), 
        NextFollowup: result[i]['NextFollowup'].toString(), 
        Product: result[i]['Product'].toString(), 
        Value: double.parse(result[i]['Value'].toString()), 
        Status: result[i]['Status'].toString(), 
        LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
        LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
        FollowupEntry:int.parse( result[i]['FollowupEntry'].toString()), 
        customermob: result[i]['Customermob'].toString(), 
        cusEmail: result[i]['CusEmail'].toString(), 
        companyname: result[i]['Companyname'].toString(), 
        cusgroup: result[i]['Cusgroup'].toString(), 
        storecode: result[i]['Storecode'].toString(), 
        add1: result[i]['Add1'].toString(),
         add2: result[i]['Add2'].toString(), 
         area: result[i]['Area'].toString(), 
        district: result[i]['District'].toString(), 
        state: result[i]['State'].toString(), 
        country: result[i]['Country'].toString(), 
        pincode: result[i]['Pincode'].toString(), 
        gender: result[i]['Gender'].toString(), 
        agegroup: result[i]['Agegroup'].toString(), 
        cameAs: result[i]['CameAs'].toString(), 
        headcount: int.parse(result[i]['Headcount'].toString()), 
        maxbudget:double.parse( result[i]['Maxbudget'].toString()), 
        assignedTo: result[i]['AssignedTo'].toString(), 
        refferal: result[i]['Refferal'].toString(), 
        purchasePlan: result[i]['PurchasePlan'].toString(), 
        dealDescription: result[i]['DealDescription'].toString(), 
        lastFollowupDate: result[i]['LastFollowupDate'].toString(), 
        createdBy: int.parse(result[i]['CreatedBy'].toString()), 
        createdDate: result[i]['CreatedDate'].toString(), 
        updatedBy: int.parse(result[i]['UpdatedBy'].toString()), 
        updatedDate: result[i]['UpdatedDate'].toString(), 
        traceId: result[i]['TraceId'].toString()
        );
    });
  }


  static Future<List<OpenLeadfiltermodel>> getopenLeaddatafilter(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableopenLeadfilter 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return OpenLeadfiltermodel(
        InterestLevel: result[i]['InterestLevel'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        LeadDocEntry:int.parse( result[i]['LeadDocEntry'].toString()), 
        LeadNum: int.parse(result[i]['LeadNum'].toString()), 
        Mobile: result[i]['Mobile'].toString(), 
        CustomerName: result[i]['CustomerName'].toString(), 
        DocDate: result[i]['DocDate'].toString(), 
        City: result[i]['City'].toString(), 
        NextFollowup: result[i]['NextFollowup'].toString(), 
        Product: result[i]['Product'].toString(), 
        Value: double.parse(result[i]['Value'].toString()), 
        Status: result[i]['Status'].toString(), 
        LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
        LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
        FollowupEntry:int.parse( result[i]['FollowupEntry'].toString()), 
        customermob: result[i]['Customermob'].toString(), 
        cusEmail: result[i]['CusEmail'].toString(), 
        companyname: result[i]['Companyname'].toString(), 
        cusgroup: result[i]['Cusgroup'].toString(), 
        storecode: result[i]['Storecode'].toString(), 
        add1: result[i]['Add1'].toString(),
         add2: result[i]['Add2'].toString(), 
         area: result[i]['Area'].toString(), 
        district: result[i]['District'].toString(), 
        state: result[i]['State'].toString(), 
        country: result[i]['Country'].toString(), 
        pincode: result[i]['Pincode'].toString(), 
        gender: result[i]['Gender'].toString(), 
        agegroup: result[i]['Agegroup'].toString(), 
        cameAs: result[i]['CameAs'].toString(), 
        headcount: int.parse(result[i]['Headcount'].toString()), 
        maxbudget:double.parse( result[i]['Maxbudget'].toString()), 
        assignedTo: result[i]['AssignedTo'].toString(), 
        refferal: result[i]['Refferal'].toString(), 
        purchasePlan: result[i]['PurchasePlan'].toString(), 
        dealDescription: result[i]['DealDescription'].toString(), 
        lastFollowupDate: result[i]['LastFollowupDate'].toString(), 
        createdBy: int.parse(result[i]['CreatedBy'].toString()), 
        createdDate: result[i]['CreatedDate'].toString(), 
        updatedBy: int.parse(result[i]['UpdatedBy'].toString()), 
        updatedDate: result[i]['UpdatedDate'].toString(), 
        traceId: result[i]['TraceId'].toString()
        );
    });
  }

  static Future<List<outstandinglineDBModel>> getoutstandingchild(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From $tableoutstandingline 
""");
    log("result::::" + result.length.toString());
    return List.generate(result.length, (i) {
      return outstandinglineDBModel(
          bil_Address1: result[i]['Bil_Address1'].toString(),
          bil_Address2: result[i]['Bil_Address2'].toString(),
          bil_Address3: result[i]['Bil_Address3'].toString(),
          bil_Area: result[i]['Bil_Area'].toString(),
          bil_City: result[i]['Bil_City'].toString(),
          bil_Country: result[i]['Bil_Country'].toString(),
          bil_District: result[i]['Bil_District'].toString(),
          bil_Pincode: result[i]['Bil_Pincode'].toString(),
          bil_State: result[i]['Bil_State'].toString(),
          collectionType: result[i]['CollectionType'].toString(),
          createdBy: result[i]['CreatedBy'] == null
              ? 0
              : int.parse(result[i]['CreatedBy'].toString()),
          createdOn: result[i]['CreatedOn'].toString(),
          customerPORef: result[i]['CustomerPORef'].toString(),
          docentry: result[i]['Docentry'] == null
              ? 0
              : int.parse(result[i]['Docentry'].toString()),
          transDate: result[i]['TransDate'].toString(),
          transDueDate: result[i]['TransDueDate'].toString(),
          transNum: result[i]['TransNum'].toString(),
          transRef1: result[i]['TransRef1'].toString(),
          transType: result[i]['TransType'].toString(),
          updatedBy: result[i]['UpdatedBy'] == null
              ? 0
              : int.parse(result[i]['UpdatedBy'].toString()),
          updatedOn: result[i]['UpdatedOn'].toString(),
          loanRef: result[i]['LoanRef'].toString(),
          status: result[i]['Status'].toString(),
          traceid: result[i]['Traceid'].toString(),
          alternateMobileNo: result[i]['AlternateMobileNo'].toString(),
          amountPaid: double.parse(result[i]['AmountPaid'].toString()),
          assignedTo: result[i]['AssignedTo'].toString(),
          balanceToPay: double.parse(result[i]['BalanceToPay'].toString()),
          collectionInc: double.parse(result[i]['CollectionInc'].toString()),
          companyName: result[i]['CompanyName'].toString(),
          contactName: result[i]['ContactName'].toString(),
          customerCode: result[i]['StoreCode'].toString(),
          customerEmail: result[i]['CustomerEmail'].toString(),
          customerGroup: result[i]['CustomerCode'].toString(),
          customerMobile: result[i]['CustomerMobile'].toString(),
          customerName: result[i]['CustomerName'].toString(),
          gstNo: result[i]['GstNo'].toString(),
          penaltyAfterDue:
              double.parse(result[i]['PenaltyAfterDue'].toString()),
          storeCode: result[i]['StoreCode'].toString(),
          transAmount: double.parse(result[i]['TransAmount'].toString()));
    });
  }

  static Future<List<outstandKPI>> getoutstandingchildInvoice(
      Database db, String? cusCode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """SELECT TransNum,Docentry,TransDate,TransRef1,julianday('now') - julianday(TransDueDate) age,BalanceToPay,TransAmount from Outstandingline where CustomerCode='$cusCode'
 
""");

//Docentry
// SELECT * From $tableoutstandingline where CustomerCode=$cusCode
    log("result::::$cusCode::" + result.length.toString());
    return List.generate(result.length, (i) {
      return outstandKPI(
          TransNum: result[i]['TransNum'].toString(),
          TransDate: result[i]['TransDate'].toString(),
          TransRef1: result[i]['TransRef1'].toString(),
          age: double.parse(result[i]['age'].toString()),
          BalanceToPay: double.parse(result[i]['BalanceToPay'].toString()),
          TransAmount: double.parse(result[i]['TransAmount'].toString()),
          docentry: int.parse(result[i]['Docentry'].toString()));
    });
  }

  static Future<List<Map<String, Object?>>> getoutontapKPI(
      Database db, String? cusCode) async {
    List<Map<String, Object?>> result = await db.rawQuery("""
SELECT sum (BalanceToPay) totaloutstanding,case when DATE('now')>TransDueDate then sum(BalanceToPay) else 0 END overdue ,
case when DATE('now')<=TransDueDate then sum(BalanceToPay) else 0 END upcoming ,Bil_City,Bil_State,CustomerName,CustomerCode from Outstandingline WHERE CustomerCode="$cusCode"
 
""");

//Docentry
// SELECT * From $tableoutstandingline where CustomerCode=$cusCode
    log("result::::$cusCode::" + result.length.toString());
    return result;
    // List.generate(result.length, (i) {
    //   return ontapKpi(
    //     totaloutstanding: result[i]['totaloutstanding'].toString(),
    //     overdue: result[i]['overdue'].toString(),
    //     TransRef1: result[i]['TransRef1'].toString(),
    //     upcoming: double.parse(result[i]['upcoming'].toString()),
    //     Bil_City: result[i]['Bil_City'].toString(),
    //     Bil_State: result[i]['Bil_State'].toString(),
    //             CustomerName: result[i]['CustomerName'].toString(),
    //             CustomerCode:result[i]['CustomerCode'].toString()

    //     );
    // }
    // );
  }
//old
//   static Future<List<outstandKPI>> getoutstandingchildInvoice(
//       Database db, String? cusCode) async {
//     final List<Map<String, Object?>> result = await db.rawQuery(
//         """SELECT TransNum,TransDate,TransRef1,julianday('now') - julianday(TransDate) age,BalanceToPay,TransAmount from $tableoutstandingline where CustomerCode='$cusCode'

// """);
// // SELECT * From $tableoutstandingline where CustomerCode=$cusCode
//     log("result::::" + result.length.toString());
//     return List.generate(result.length, (i) {
//       return outstandKPI(
//         TransNum: result[i]['TransNum'].toString(),
//         TransDate: result[i]['TransDate'].toString(),
//         TransRef1: result[i]['TransRef1'].toString(),
//         age: double.parse(result[i]['age'].toString()),
//         BalanceToPay: result[i]['BalanceToPay'].toString(),
//         TransAmount: result[i]['TransAmount'].toString()
//         );

//     });
//   }
  //enqtype methods

  static Future insertEnqType(List<EnquiryTypeData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertEnqType ");
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqType, es);
      log("Enq Batchhhh Item...");
    });
    stopwatch.stop();
    log('API insertEnqType ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     insertIsoEnqtpe, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static Future insertCusTagType(
      List<CustomerTagTypeData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertCusTagType ");

    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableCusTagType, es);
      // log("Enq Batchhhh Item...");
    });
    stopwatch.stop();
    log('API insertCusTagType ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     insertIsoEnqtpe, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static Future insertlevelofType(List<LevelofData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertlevelofType ");

    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableLevelof, es);
      // log("Enq Batchhhh Item...");
    });
    stopwatch.stop();
    log('API insertlevelofType ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();
  }

  static Future insertOrderTypeta(
      List<OrderTypeData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertOrderTypeta ");
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOrderType, es);
      // log("Enq Batchhhh Item...");
    });
    stopwatch.stop();
    log('API insertOrderTypeta ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();
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
    List<EnquiryTypeData> valu = value[1];
    var data = valu.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len2222: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableCusTagType, es);
      // log("Enq Batchhhh Item22222...");
    });
    await batch.commit();
  }

  static Future<List<EnquiryTypeData>> getEnqData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

  static Future<List<LevelofData>> getlevelofData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM Levelof;
''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return LevelofData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  static Future<List<OrderTypeData>> getordertypeData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM OrderType;
''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return OrderTypeData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }
  // Instr(case when length('$cusname') <> 0 then ', ' || '$cusname' || ',' else ', '|| A.CustomerName || ','   end,', ' || A.CustomerName || ',' ) > 0  AnD
  static Future<List<GetAllOrderData>> getorderfilterapply(Database db,String assignto,String cusgroup,String cusname,String enqstatus,String ordertype,double? balanceabove,String fromdate,String enddate)async{

   final List<Map<String, Object?>> result= await db.rawQuery("""
   SELECT *  from Orderfilter A
      Where 
    Instr(case when length('$assignto') <> 0 then ', ' || '$assignto' || ',' else ', '|| A.AssignedTo || ','  end,', ' || A.AssignedTo || ',' ) > 0 AND
	  Instr(case when length('$cusgroup') <> 0 then ', ' || '$cusgroup' || ',' else ', '|| A.CustomerGroup || ','   end,', ' || A.CustomerGroup || ',' ) > 0  AnD
    
	 Instr(case when length('$enqstatus') <> 0 then ', ' || '$enqstatus' || ',' else ', '|| A.OrderStatus || ','   end,', ' || A.OrderStatus || ',' ) > 0  AnD
	 Instr(case when length('$ordertype') <> 0 then ', ' || '$ordertype' || ',' else ', '|| A.OrderType || ','   end,', ' || A.OrderType || ',' ) > 0  AnD
   Value >=$balanceabove And
	  date(A.Createdon) BETWEEN '$fromdate' AND '$enddate'
    
""");

 log("result::::" + result.toString());
    return List.generate(result.length, (i) {
      return GetAllOrderData(
        CustomerGroup: result[i]['CustomerGroup'].toString(), 
        OrderType: result[i]['OrderType'].toString(), 
        createdon: result[i]['Createdon'].toString(), 
        isDelivered:int.parse(result[i]['IsDelivered'].toString()) , 
        isInvoiced:int.parse( result[i]['IsInvoiced'].toString()),
         OrderDocEntry: int.parse(result[i]['OrderDocEntry'].toString()), 
         OrderNum: int.parse(result[i]['OrderNum'].toString()), 
         Mobile: result[i]['Mobile'].toString(), 
         CustomerName: result[i]['CustomerName'].toString(), 
         DocDate: result[i]['DocDate'].toString(), 
         AssignedTo: result[i]['AssignedTo'].toString(), 
         AttachURL1: result[i]['AttachURL1'].toString(), 
         AttachURL2: result[i]['AttachURL2'].toString(), 
         AttachURL3: result[i]['AttachURL3'].toString(), 
         BaseDocDate: result[i]['BaseDocDate'].toString(), 
         BaseID: int.parse(result[i]['BaseID'].toString()), 
         BaseType: result[i]['BaseType'].toString(), 
         CurrentStatus: result[i]['CurrentStatus'].toString(), 
         DealID: result[i]['DealID'].toString(), 
         Del_Address2: result[i]['Del_Address2'].toString(), 
         Del_Address3: result[i]['Del_Address3'].toString(), 
         Del_Area: result[i]['del_Area'].toString(), 
         Del_City: result[i]['Del_City'].toString(), 
         Del_Country: result[i]['Del_Country'].toString(), 
         Del_District: result[i]['Del_District'].toString(), 
         Del_Pincode: result[i]['Del_Pincode'].toString(), 
         Del_State: result[i]['Del_State'].toString(), 
         DeliveryFrom: result[i]['DeliveryFrom'].toString(), 
         Discount: double.parse(result[i]['Discount'].toString()), 
         FollowupEntry: int.parse(result[i]['FollowupEntry'].toString()), 
         LastUpdateMessage: result[i]['LastUpdateMessage'].toString(), 
         GrossTotal: double.parse(result[i]['GrossTotal'].toString()), 
         LastUpdateTime: result[i]['LastUpdateTime'].toString(), 
         OrderStatus: result[i]['OrderStatus'].toString(), 
         Product: result[i]['Product'].toString(), 
         RoundOff: double.parse(result[i]['RoundOff'].toString()), 
         Status: result[i]['Status'].toString(), 
         StoreCode: result[i]['StoreCode'].toString(), 
         SubTotal: double.parse(result[i]['SubTotal'].toString()), 
         TaxAmount: double.parse(result[i]['TaxAmount'].toString()), 
         Value: double.parse(result[i]['Value'].toString()), 
         alternateMobileNo: result[i]['AlternateMobileNo'].toString(), 
         bil_Address1: result[i]['Bil_Address1'].toString(), 
         bil_Address2: result[i]['Bil_Address2'].toString(), 
         bil_Address3: result[i]['Bil_Address3'].toString(), 
         bil_Area: result[i]['Bil_Area'].toString(), 
         bil_City: result[i]['Bil_City'].toString(), 
         bil_Country: result[i]['Bil_Country'].toString(), 
         bil_District: result[i]['Bil_District'].toString(), 
         bil_Pincode: result[i]['Bil_Pincode'].toString(), 
         bil_State: result[i]['Bil_State'].toString(), 
         companyName: result[i]['CompanyName'].toString(), 
         contactName: result[i]['ContactName'].toString(), 
         customerEmail: result[i]['CustomerEmail'].toString(), 
         customerPORef: result[i]['CustomerPORef'].toString(), 
         del_Address1: result[i]['Del_Address1'].toString(), 
         deliveryDueDate: result[i]['DeliveryDueDate'].toString(), 
         enqid: result[i]['Enqid'].toString(), 
         gSTNo: result[i]['GSTNo'].toString(), 
         leadid: result[i]['Leadid'].toString(), 
         pAN: result[i]['PAN'].toString(), 
         paymentDueDate: result[i]['PaymentDueDate'].toString()
         );
    });
}
 static Future insertOrderdata(
      List<GetAllOrderData> values, Database db) async {
    
  final stopwatch = Stopwatch()..start();
  log("start DBBBB");
    var data = values.map((e) => e.toMap()).toList();
   

    var batch = db.batch();
   
    
    data.forEach((es) async {
      batch.insert(tableorderfilter, es);
      
    });
    
    log("tableEnquiryfilter..."+tableorderfilter.length.toString());
    await batch.commit();
     stopwatch.stop();
            log('API DB ${stopwatch.elapsedMilliseconds} milliseconds');
         
    // await db.close();
  }

  static Future<List<CustomerTagTypeData>> getCusTagData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM CusTagType;
''');

    log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return CustomerTagTypeData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  static Future<List<Map<String, Object?>>> getLoginVerifiDBData(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $loginverificationDB
''');

    log("restriction::" + result.toString());

    return result;
  }

  static Future<void> truncareopenleadMaster(Database db) async {
    await db.rawQuery('delete from $tableopenlead');
  }

  static Future<void> truncareEnqfilter(Database db) async {
    await db.rawQuery('delete from $tableEnquiryfilter');
  }

  static Future<void> truncareleadfilter(Database db) async {
    await db.rawQuery('delete from $tableLeadfilter');
  }
  static Future<void> truncareopenleadfilter(Database db) async {
    await db.rawQuery('delete from $tableopenLeadfilter');
  }
  static Future<void> truncareorderfilter(Database db) async {
    await db.rawQuery('delete from $tableorderfilter');
  }

  static Future<void> truncareoutstandingmaste(Database db) async {
    await db.rawQuery('delete from $tableoutstanding');
  }

  static Future<void> truncateLoginVerficationDB(Database db) async {
    await db.rawQuery('delete from $loginverificationDB');
    // await db.close();
  }

  static Future insertLoginVerifiDetails(
      List<VerificationData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("tableopenlead len: " + values.length.toString());
    log("tableopenlead len: " + data.length.toString());

    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(loginverificationDB, es);
      log("loginverificationDB Batchhhh Item...");
    });
    await batch.commit();
  }

  static Future<void> truncareoutstandingline(Database db) async {
    await db.rawQuery('delete from $tableoutstandingline');
  }

  static Future<void> truncareItemMaster(Database db) async {
    await db.rawQuery('delete from $tableItemMaster');
  }

  static Future<void> truncareEnqType(Database db) async {
    await db.rawQuery('delete from $tableEnqType');
  }

  static Future<void> truncarelevelofType(Database db) async {
    await db.rawQuery('delete from $tableLevelof');
  }

  static Future<void> truncareorderType(Database db) async {
    await db.rawQuery('delete from $tableOrderType');
  }

  static Future<void> truncareCusTagType(Database db) async {
    await db.rawQuery('delete from $tableCusTagType');
  }

  static Future<void> truncareEnqReffers(Database db) async {
    await db.rawQuery('delete from $tableEnqReffers');
  }

  static Future insertEnqReffers(
      List<EnqRefferesData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertEnqReffers ");
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqReffers, es);
      log("Enq Batchhhh Item...");
    });
    stopwatch.stop();
    log('API insertEnqReffers ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoReferral, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoReferral(List<dynamic> value) async {
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

  static Future<List<EnqRefferesData>> getEnqRefferes(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

  static Future insertUserList(List<UserListData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertUserList ");
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableUserList, es);
      print("Data...");
    });
    stopwatch.stop();
    log('API insertUserList ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoUserList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoUserList(List<dynamic> value) async {
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

  static Future<List<UserListData>> getUserList(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $tableUserList;
''');
    log("result" + result.toString());
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

  static Future insertLeadStatusList(
      List<GetLeadStatusData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertLeadStatusList ");
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      print("LeadStatusList...");
    });
    stopwatch.stop();
    log('API insertLeadStatusList ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoLeadStatusList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoLeadStatusList(List<dynamic> value) async {
    List<GetLeadStatusData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      // log("Enq LeadStatus Batchhhh Item555..");
    });
    await batch.commit();
  }

  static Future<List<GetLeadStatusData>> getLeadStatusOpen(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

  static Future<List<GetLeadStatusData>> getLeadStatusWon(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

  static Future<List<GetLeadStatusData>> getLeadStatusLost(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT * FROM $tableLeadStatusReason where StatusType = '3';
      ''');

    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: int.parse(result[i]['StatusType'].toString()),
      );
    });
  }

  static Future insertOfferZone(List<OfferZoneData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:insertOfferZone ");
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZone, es);
      // log("offerzone...$data");
    });
    stopwatch.stop();
    log('API insertOfferZone ${stopwatch.elapsedMilliseconds} milliseconds');

    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static Future insertOfferZonechild1(
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

  static Future insertitemlist1(Itemlistdata1 values, Database db) async {
    // var data = ;
    var batch = db.batch();
    // var  es={'tablelist1':data};
    // log("tablelist1...$data");
    // data.forEach((es) async {
    //   batch.insert(tableitemlist1, es);
    //   //
    // });
    batch.insert(tableitemlist1, values.toMap());
    await batch.commit();
  }

  static Future insertitemlist2(Itemlistdata2 values, Database db) async {
    // var data = ;
    var batch = db.batch();
    //  var  es={'tablelist1':data};
    // data.forEach((es) async {
    //   batch.insert(tableitemlist1, es);
    //   // log("offerzone...$data");
    // });
    batch.insert(tableitemlist2, values.toMap());
    await batch.commit();
  }

  static Future insertOfferZonechild2(
      List<offerstorelist> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZonechild2, es);
      log("offerzonedb...$data");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoOfferZone(
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
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $tableOfferZonechild1

''');

// log("message"+result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getofferDatastore(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $tableOfferZonechild2
''');

// log("message"+result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getofferFavData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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
//  static Future<List<OfferZoneData>> getofferFavData(Database db) async {
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

  static Future insertNotification(
      List<NotificationModel> values, Database db) async {
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

  static Future<List<NotificationModel>> getNotification(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

  static Future<int?> getUnSeenNotificationCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  static updateNotify(int id, String time, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
  }

  static deleteNotify(int id, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $tableNotification WHERE DocEntry = $id;
    ''');
    // await db.close();
  }

  static deleteNotifyAll(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  static Future<void> truncateOfferZone(Database db) async {
    await db.rawQuery('delete from $tableOfferZone');
    // await db.close();
  }

  static Future<void> truncatetableitemlist1(Database db) async {
    await db.rawQuery('delete from $tableitemlist1');
    // await db.close();
  }

  static Future<void> truncatetableitemlist2(Database db) async {
    await db.rawQuery('delete from $tableitemlist2');
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

  static Future<void> truncateUserList(Database db) async {
    await db.rawQuery('delete from $tableUserList');
    // await db.close();
  }

  static Future<void> truncateLeadstatus(Database db) async {
    await db.rawQuery('delete from $tableLeadStatusReason');
    // await db.close();
  }

  Future<void> truncateNotification(Database db) async {
    await db.rawQuery('delete from $tableNotification');
    //  await db.close();
  }

  //Open Lead

  static Future insertOpenLead(List<OpenLeadData> values, Database db) async {
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
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT * from OpenLeadT;
    ''');
    log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return result;
  }

  static Future<void> truncateOpenLead(Database db) async {
    await db.rawQuery('delete from $tableOpenLead');
    //  await db.close();
  }

  //

  static Future<List<Map<String, Object?>>> getOpenLFtr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
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

   static Future<List<Map<String, Object?>>> getstorecode(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $column
 FROM $tableItemMaster
WHERE $column IS NOT '';
''');

    log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
   
  }

  static Future<List<OpenLeadData>> onFilteredOpenLead(
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
    final List<Map<String, Object?>> result = await db.rawQuery("""
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

    String data = """
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

  static Future<List<OpenLeadData>> onSearchOpenLead(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
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

//New Query

  static Future<List<CustomerData>> getCustomerData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT * FROM $tableCustomerMaster;
    ''');

    // log("Saved AllocATE: " + result.toList().toString());

    return List.generate(result.length, (i) {
      log("Saved AllocATE length: " + result[i]['gst'].toString());

      return CustomerData(
          id: result[i]['id'] == null
              ? 0
              : int.parse(result[i]['id'].toString()),
          cardcode: result[i]['cardcode'] == null
              ? ""
              : result[i]['cardcode'].toString(),
          cardname: result[i]['cardname'] == null
              ? ""
              : result[i]['cardname'].toString(),
          cantactName: result[i]['contactName'] == null
              ? ""
              : result[i]['cantactName'].toString(),
          mobile:
              result[i]['mobile'] == null ? "" : result[i]['mobile'].toString(),
          alterMobileno: result[i]['alterMobileno'] == null
              ? ""
              : result[i]['alterMobileno'].toString(),
          email:
              result[i]['email'] == null ? "" : result[i]['email'].toString(),
          gst: result[i]['gst'] == null ? "" : result[i]['gst'].toString(),
          address1: result[i]['address1'] == null
              ? ""
              : result[i]['address1'].toString(),
          address2: result[i]['address2'] == null
              ? ""
              : result[i]['address2'].toString(),
          zipcode: result[i]['zipcode'] == null
              ? ""
              : result[i]['zipcode'].toString(),
          city: result[i]['city'] == null ? "" : result[i]['city'].toString(),
          state:
              result[i]['state'] == null ? "" : result[i]['state'].toString(),
          area: result[i]['area'] == null ? "" : result[i]['area'].toString(),
          tag: result[i]['tag'] == null ? "" : result[i]['tag'].toString());
    });
  }

  static Future<List<stateHeaderData>> getstateData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT * FROM $tableStateMaster;
    ''');

    // log("Saved AllocATE: " + result.toList().toString());

    return List.generate(result.length, (i) {
      log("Saved AllocATE length: " + result[i]['gst'].toString());

      return stateHeaderData(
        statecode: result[i]['statecode'].toString(),
        stateName: result[i]['statename'] == null
            ? ""
            : result[i]['statename'].toString(),
        countrycode: result[i]['cuntrycode'] == null
            ? ""
            : result[i]['cuntrycode'].toString(),
        countryname: result[i]['countryname'] == null
            ? ""
            : result[i]['countryname'].toString(),
      );
    });
  }

  static Future<List<CustomerTagTypeData>> getCusTagDataDetails(
      Database db, String custagName) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM CusTagType where Name='$custagName' ;
''');

    log("Selected custag: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return CustomerTagTypeData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  static Future<List<GetOrderStatusData>> getOrderStatusOpen(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT * FROM $tableOrderStatusReason where StatusType = 'Open';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());
    return List.generate(result.length, (i) {
      return GetOrderStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future<List<GetOrderStatusData>> getOrderStatusLost(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT * FROM $tableOrderStatusReason where StatusType = 'Lost';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetOrderStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future<List<GetOrderStatusData>> getOrderStatusWon(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT * FROM $tableOrderStatusReason where StatusType = 'Won';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetOrderStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future inserCustomerMaster(
      List<CustomerData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableCustomerMaster, es);
      print("LeadStatusList...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoLeadStatusList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static Future inserstateMaster(
      List<stateHeaderData> values, Database db) async {
    final stopwatch = Stopwatch()..start();
    log("Start:inserstateMaster ");
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableStateMaster, es);
      print("LeadStatusList...");
    });
    stopwatch.stop();
    log('API inserstateMaster ${stopwatch.elapsedMilliseconds} milliseconds');
    await batch.commit();
  }

  static Future<void> trunstateMaster(Database db) async {
    await db.rawQuery('delete from $tableStateMaster');
    // await db.close();
  }

  static Future<void> truncustomerMaster(Database db) async {
    await db.rawQuery('delete from $tableCustomerMaster');
    // await db.close();
  }

//New FS
  static Future<List<Map<String, Object?>>> getValidateCheckIn(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT * FROM  SiteCheckIn where substr(DateTime,1,10) = DATE("now") and SiteType = "CheckIn" ''');
    //log("getSalesHeadHoldvalueDB:" + result.toString());
    return result;
  }

  static Future insertSiteCheckIn(
      Database db, List<SiteCheckInDBModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SiteCheckIn", es);
    });
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SiteCheckIn ''');
    log("SitecheckIn:::" + result.toString());
    await batch.commit();
  }

  static Future changeCheckIntoCheckOut(Database db, int checkId) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' UPDATE SiteCheckIn  SET SiteType = "CheckOut" Where CheckInId= $checkId ''');
    //log("Updated Coupon list::" + result.toString());
    return result;
  }

  //
  static Future insertScreenShot(
      List<ScreenShotModel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("insertScreenShot len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableScreenShot, es);
      log("insertScreenShot Batchhhh Item...");
    });
    await batch.commit();
    // await db.close();
  }

  static Future<int?> getItemMasterCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT count(*) from $tableItemMaster ;
    ''');
    int? count = Sqflite.firstIntValue(result);
    print('Itemmaster Count:' + count.toString());
    //  await db.close();
    return count;
  }

  static Future<int?> getCustomerMasterCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT count(*) from $tableCustomerMaster ;
    ''');
    int? count = Sqflite.firstIntValue(result);
    print('customermaster Count:' + count.toString());

    //  await db.close();
    return count;
  }
}
