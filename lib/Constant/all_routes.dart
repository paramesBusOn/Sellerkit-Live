
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Pages/Accounts/NewCustomer.dart';
import 'package:sellerkit/Pages/Accounts/screens/accoounts_details.dart';
import 'package:sellerkit/Pages/Collection/NewCollectionEntry.dart';
import 'package:sellerkit/Pages/Collection/Screens/CollectionList.dart';
import 'package:sellerkit/Pages/DayStartEnd/Screens/DayEnd.dart';
import 'package:sellerkit/Pages/DayStartEnd/Screens/DayStart.dart';
import 'package:sellerkit/Pages/DayStartEnd/Widgets/CameraPage.dart';
import 'package:sellerkit/Pages/Leads/NewLead.dart';
// import 'package:sellerkit/Pages/Leads/Widgets/OpenLead.dart';
import 'package:sellerkit/Pages/LeaveApprove/Screens/LeaveAppList.dart';
import 'package:sellerkit/Pages/LeaveApprove/Screens/LeaveApprovePage.dart';
import 'package:sellerkit/Pages/LeaveRequest/Screen/LeaveReqPage.dart';
import 'package:sellerkit/Pages/LeaveRequest/Screen/LeaveReqTab.dart';
import 'package:sellerkit/Pages/Login/Screen/LoginScreen.dart';
import 'package:sellerkit/Pages/OnBoarding/OnBoardingScreen.dart';
import 'package:sellerkit/Pages/OpenLead/Screen/FilterOpenLeadPage.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/Screens/TabScreen.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/newpricereq.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import 'package:sellerkit/Pages/Outstanding/Screens/OutstandingScreen.dart';
import 'package:sellerkit/Pages/PriceAvailability/Screen/PriceDetailsPage.dart';
import 'package:sellerkit/Pages/Quoatation/Succcesspage.dart';
import 'package:sellerkit/Pages/Quoatation/newqoute.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/tabquote.dart';
import 'package:sellerkit/Pages/Settlement/Screens/SettlementTabPage.dart';
import 'package:sellerkit/Pages/SiteIn/Screens/SiteInPage.dart';
import 'package:sellerkit/Pages/SiteIn/Widgets/NewSiteIn.dart';
import 'package:sellerkit/Pages/SiteOut/Screens/SiteOut.dart';
import 'package:sellerkit/Pages/Splash/Screen/SplashPage.dart';
import 'package:sellerkit/Pages/Notification/Screens/Notifications.dart';
import 'package:sellerkit/Pages/VisitPlans/Screens/NewVisitPlan.dart';
import 'package:sellerkit/Pages/VisitPlans/visitplanScreen.dart';
import 'package:sellerkit/Widgets/restricted_page.dart';
import '../Pages/Accounts/Screens/Accounts.dart';
import '../Pages/ChagnePasswordScreen/widgets/ConfirmPassword.dart';
import '../Pages/Dashboard/Screens/Dashboard.dart';
import '../Pages/Dashboard/widgets/PhotoViwer.dart';
import '../Pages/DownloadDatasPage.dart/DownloadDataPage.dart';
import '../Pages/Enquiries/EnquiriesUser/EnquiryPageUser.dart';
import '../Pages/Enquiries/NewEnquiry.dart';
import '../Pages/FeedCreation/Screen/FeedCrtscreen.dart';
import '../Pages/Followup/Screens/FollowUpNew.dart';
import '../Pages/Followup/Screens/FollowUpScreen.dart';
import '../Pages/Followup/Screens/FollowUpTabScreen.dart';
import '../Pages/ForgotPassword/Screens/ForgotPassword.dart';
import '../Pages/Reports/Reports/screens/ReportsPage.dart';
import '../Pages/TargetPage/Screen/Target.dart';
import '../Pages/Leads/Screens/LeadSuccessPage.dart';
import '../Pages/Leads/Screens/TabLeads.dart';
import '../Pages/MyEarnings/Screens/MyEarnings.dart';
import '../Pages/MyPerformance/Screens/MyPerformance.dart';
import '../Pages/OfferZone/Screens/OfferZone.dart';
// import '../Pages/OpenLead/Screen/FilterOpenLeadPage.dart';
import '../Pages/OpenLead/Screen/OpenLeadPage.dart';
// import '../Pages/Orders/NewLead.dart';
// import '../Pages/Orders/Screens/LeadSuccessPage.dart';
import '../Pages/OrderBooking/NewOrder.dart';
import '../Pages/OrderBooking/Screens/OrderSuccessPage.dart';
import '../Pages/OrderBooking/Screens/TabOrders.dart';
import '../Pages/PriceAvailability/Screen/ViewAllPriceListPage.dart';
import '../Pages/PriceAvailability/Screen/PriceListFstPage.dart';
import '../Pages/Profile/Screen/Newprofile.dart';
import '../Pages/ScoreCard/Screens/ScoreCard1Screens.dart';
import '../Pages/ScaningPage/Screens/ScreenShot.dart';
import '../Pages/ScreenShotPage/Screen/ScreenShotPage.dart';
import '../Pages/Stock Availability/screens/StockDetailsPage.dart';
import '../Pages/Stock Availability/screens/StockListFPage.dart';
import '../Pages/Stock Availability/screens/ViewAllStockListPage.dart';
import '../Pages/Walkins/Screens/Walkins.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => const Dashboard(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
         GetPage<dynamic>(
        name: ConstantRoutes.specialpricereq,
        page: () => const SpecialPriceReq(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.newpriceReq,
        page: () =>const NewpriceReq(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.splash,
        page: () => SplashPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.forgotregister,
        page: () =>const ForgotRegisterPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.download,
        page: () => DownloadPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

        GetPage<dynamic>(
        name: ConstantRoutes.qrscanner,
        page: () => Qrscanner(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.onBoard,
        page: () =>const OnBoardingScreen(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.leaveReqtab,
        page: () => const leaveReqtab(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    //Resource

    GetPage<dynamic>(
        name: ConstantRoutes.stock,
        page: () =>const StockAvail(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.stockListOfDetails,
        page: () => StockListOfDetails(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.listStockAvailability,
        page: () =>const ListStockAvailability(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceList,
        page: () =>const PriceAvailability(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceListViewAll,
        page: () => PriceListOfDetails(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.priceListViewData,
        page: () =>const ListPriceAvailability(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
// orders
    GetPage<dynamic>(
        name: ConstantRoutes.ordertab,
        page: () => OrdersTabPage(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.successorder,
        page: () => OrderSuccessPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.successQuotes,
        page: () => QuotesSuccessPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.ordernew,
        page: () => OrderBookNew(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    // performance

    GetPage<dynamic>(
        name: ConstantRoutes.performance,
        page: () =>const MyPerformance(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.scoreCardScreenOne,
        page: () =>const ScoreCardScreenOne(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.earnings,
        page: () => MyEarnings(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    //pre sales
    // GetPage<dynamic>(
    //     name: ConstantRoutes.enquiriesManager,
    //     page: () => EnquiryManagerPage(),
    //     transition: Transition.fade,
    //     transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.enquiriesUser,
        page: () => EnquiryUserPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.walkins,
        page: () =>const WalkinsPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leads,
        page: () => LeadBookNew(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leadstab,
        page: () => LeadsTabPage(), //LeadBook(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.newEnq,
        page: () => NewEnquiry(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.successLead,
        page: () => LeadSuccessPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followup,
        page: () => FollowUpPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followupNew,
        page: () =>const FollowUpNew(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.followupTab,
        page: () => FollowUpTab(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.openLeadPage,
        page: () => OpenLeadPageFoll(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
    name: ConstantRoutes.filtrOPLP,
    page: () => FilterOpenLeadPage(),
    transition: Transition.fade,
    transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.newprofile,
        page: () => NewProfile(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.targets,
        page: () => const Target(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.testing,
        page: () =>const Testing(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.accounts,
        page: () =>const Accounts(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.accountsDetails,
        page: () => AccountsDetailspage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.offerZone,
        page: () =>const OfferZone(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.confirmPassWord,
        page: () =>const ConfirmPasswordPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.photoViewer,
        page: () => PhotoViewer(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.feedsCreation,
        page: () => FeedCrt(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.scanQrcode,
        page: () => ScanningPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.screenshot,
        page: () =>const ScreenShotPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
//
    GetPage<dynamic>(
        name: ConstantRoutes.daystartend,
        page: () =>const DayStartEndPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.cameraPage,
        page: () =>const cameraPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.visitplan,
        page: () => visitplanPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newvisitplan,
        page: () => NewVisitPlan(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newcustomerReg,
        page: () =>const NewCustomerReg(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.collectionlist,
        page: () =>const Collections(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newcollection,
        page: () => NewCollectionEntry(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    // GetPage<dynamic>(
    //     name: ConstantRoutes.collectioSuccess,
    //     page: () => CollectionSuccessPage(),
    //     transition: Transition.fade,
    //     transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.settlement,
        page: () => SettlementTabPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.sitein,
        page: () =>const SiteInPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.newsitein,
        page: () => NewSiteIn(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
         GetPage<dynamic>(
        name: ConstantRoutes.restrictionValue,
        page: () =>const RestrictionPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.siteOut,
        page: () => SiteOut(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.dayEndPage,
        page: () =>const DayEndPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leaveReq,
        page: () => LeaveReqPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leaveApprove,
        page: () =>const LeaveApprovePage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.leaveApprList,
        page: () =>const LeaveAppList(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),

    // GetPage<dynamic>(
    //     name: ConstantRoutes.quatation,
    //     page: () => quotepage(),
    //     transition: Transition.fade,
    //     transitionDuration: Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.quotespage,
        page: () =>const quotepage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.quotesnew,
        page: () => QuoteNew(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.outstanding,
        page: () =>const OutStandingPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.chagnePassword,
        page: () =>const ConfirmPasswordPage(),
        transition: Transition.fade,
        transitionDuration:const Duration(seconds: 1)),
        GetPage<dynamic>(
        name: ConstantRoutes.reports,
        page: () =>  const ReportsPage(title: '',),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1))
  ];
}
