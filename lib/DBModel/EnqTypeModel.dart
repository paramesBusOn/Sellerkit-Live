// ignore_for_file: file_names
const String tableEnqType = "EnqType";

class EnqTypeDBModel {
  static const String code = "Code";
  static const String name = "Name";
}
// ignore_for_file: file_names
const String tableCusTagType = "CusTagType";

class CusTagTypeDBModel {
  static const String code = "Code";
  static const String name = "Name";
}
const String tableLevelof = "Levelof";

class CusLevelDBModel {
  static const String code = "Code";
  static const String name = "Name";
}
const String tableOrderType = "OrderType";

class OrderTypeDBModel {
  static const String code = "Code";
  static const String name = "Name";
}

const String tableOrderStatusReason = "OrderStatusReason";

class OrderStatusReason {
  static const String code = "Code";
  static const String name = "Name";
  static const String statusType = "StatusType";
}


// reffers table

const String tableEnqReffers = "EnqRefferes";

class EnqReffersDBModel {
  static const String code = "Code";
  static const String name = "Name";
}

const String tableUserList = "UserList";

class UserListDBModel {
  // static const String userKey = "UserKey";
  static const String managerSlp = "managerSlp";
  static const String userName = "UserName";
  static const String salesEmpID = "SalesEmpID";
  static const String slpcode = "slpCode";
  static const String color = "Color";
  static const String storeid = "StoreID";
  static const String userCode = "UserCode";
  
}

const String tableOfferZone = "OfferZone";
class OfferZoneColumns {
  static const String mediaurl1 = "mediaurl1";
  static const String mediaurl2 = "mediaurl2";
  static const String offerZoneId = "OfferID";
  static const String itemCode = "ItemCode";
  static const String offerName = "OfferName";
  static const String offerDetails = "OfferDetails";
  static const String incentive = "Incentive";
  static const String validTill = "ValidTill";
}

const String tableOfferZonechild1 = "OfferZonechild1";
class offerzoneColumnchild1{
static const String id = "Id";
  static const String offerid = "Offerid";
  static const String itemid = "Itemid";
  static const String itemName = "ItemName";
  static const String brand = "Brand";
  static const String category = "Category";
  static const String subCategory = "SubCategory";
  static const String itemDescription = "ItemDescription";

  
}
const String tableOfferZonechild2 = "OfferZonechild2";
class offerzoneColumnchild2{
 static const String id2 = "Id2";
   static const String offerId2 = "OfferId2";
   static const String storeId = "StoreId";
}

const String tableLeadStatusReason = "LeadStatusReason";

class LeadStatusReason {
  static const String code = "Code";
  static const String name = "Name";
  static const String statusType = "StatusType";
}

const String tableNotification = "Notification";

class Notification {
  static const String docEntry= "DocEntry";
  static const String title = "Title";
  static const String imgurl = "ImgUrl";
  static const String description= "Description";
  static const String receiveTime = "ReceiveTime";
  static const String seenTime = "SeenTime";
  static const String naviScn= "NavigateScreen";
  static const String jobid= "Jobid";
}
