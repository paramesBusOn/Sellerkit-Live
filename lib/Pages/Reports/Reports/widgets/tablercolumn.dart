// import 'package:flutter/material.dart';
// import 'package:sellerkit/Pages/Reports/Data/UserData.dart';
// import 'package:sellerkit/Pages/Reports/Model/userModel.dart';

// class SortablePage extends StatefulWidget {
//   @override
//   _SortablePageState createState() => _SortablePageState();
// }

// class _SortablePageState extends State<SortablePage> {
//   late List<User> users;
//   int? sortColumnIndex;
//   bool isAscending = false;

//   @override
//   void initState() {
//     super.initState();

//     this.users = List.of(allUsers);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: ScrollableWidget(child: buildDataTable()),
//       );

//   Widget buildDataTable() {
//     final columns = ['First Name', 'Last Name', 'Age'];

//     return DataTable(
//       sortAscending: isAscending,
//       sortColumnIndex: sortColumnIndex,
//       columns: getColumns(columns),
//       rows: getRows(users),
//     );
//   }

//   List<DataColumn> getColumns(List<String> columns) => columns
//       .map((String column) => DataColumn(
//             label: Text(column),
//             onSort: onSort,
//           ))
//       .toList();

//   List<DataRow> getRows(List<User> users) => users.map((User user) {
//         final cells = [user.firstName, user.lastName, user.age];

//         return DataRow(cells: getCells(cells));
//       }).toList();

//   List<DataCell> getCells(List<dynamic> cells) =>
//       cells.map((data) => DataCell(Text('$data'))).toList();

//   void onSort(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       users.sort((user1, user2) =>
//           compareString(ascending, user1.firstName, user2.firstName));
//     } else if (columnIndex == 1) {
//       users.sort((user1, user2) =>
//           compareString(ascending, user1.lastName, user2.lastName));
//     } else if (columnIndex == 2) {
//       users.sort((user1, user2) =>
//           compareString(ascending, '${user1.age}', '${user2.age}'));
//     }

//     setState(() {
//       this.sortColumnIndex = columnIndex;
//       this.isAscending = ascending;
//     });
//   }

//   int compareString(bool ascending, String value1, String value2) =>
//       ascending ? value1.compareTo(value2) : value2.compareTo(value1);
// }

// class ScrollableWidget extends StatelessWidget {
//   final Widget child;

//   const ScrollableWidget({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           child: child,
//         ),
//       );
// }

// class TabBarWidget extends StatelessWidget {
//   final String title;
//   final List<Tab> tabs;
//   final List<Widget> children;

//   const TabBarWidget({
//     Key? key,
//     required this.title,
//     required this.tabs,
//     required this.children,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => DefaultTabController(
//         length: tabs.length,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(title),
//             centerTitle: true,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.purple, Colors.blue],
//                   begin: Alignment.bottomRight,
//                   end: Alignment.topLeft,
//                 ),
//               ),
//             ),
//             bottom: TabBar(
//               isScrollable: true,
//               indicatorColor: Colors.white,
//               indicatorWeight: 5,
//               tabs: tabs,
//             ),
//             elevation: 20,
//             titleSpacing: 20,
//           ),
//           body: TabBarView(children: children),
//         ),
//       );
// }
