import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/add_expenses.dart';

class Expensedetails extends StatelessWidget {
  const Expensedetails({super.key, required this.trip});
  final Tripmodel trip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 28, 28),
        body: FutureBuilder(
            future: getExpenses(trip.id!),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        title: Text(
                          '${data[index]['amount']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 19),
                        ),
                        subtitle: Text(
                          'amount paid by ${data[index]['reason']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Text('₹ ${data[index]['sponsor']}'.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green)),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('You Have no Expenses'));
              }
            }),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 130),
          child: ElevatedButton.icon(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Expenses(
                        trip: trip,
                      )));
              getExpenses(trip.id!);
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Expense'),
          ),
        ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:traverse_1/data/functions/properties_trip.dart';
// import 'package:traverse_1/data/models/trip/trip_model.dart';
// import 'package:traverse_1/screens/trip_details/add_expenses.dart';

// class Expensedetails extends StatelessWidget {
//   const Expensedetails({super.key, required this.trip});
//   final Tripmodel trip;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 30, 28, 28),
//         body: ValueListenableBuilder(valueListenable:  propertydata,builder: (context, value, child) =>
//               ListView.builder(
//                   itemCount: data!.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: ListTile(
//                         title: Text(
//                           '${data[index]['amount']}',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 19),
//                         ),
//                         subtitle: Text(
//                           'amount paid by ${data[index]['reason']}',
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         trailing: Text('₹ ${data[index]['sponsor']}'.toString(),
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.green)),
//                       ),
//                     );
//                   },
//                 );

//             ),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 130),
//           child: ElevatedButton.icon(
//             onPressed: () async {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => Expenses(
//                         trip: trip,
//                       )));
//               getExpenses(trip.id!);
//             },
//             icon: const Icon(Icons.add),
//             label: const Text('Add Expense'),
//           ),
//         ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:traverse_1/data/functions/properties_trip.dart';
// import 'package:traverse_1/data/models/trip/trip_model.dart';
// import 'package:traverse_1/screens/trip_details/add_expenses.dart';

// class Expensedetails extends StatelessWidget {
//   const Expensedetails({Key? key, required this.trip}) : super(key: key);
//   final Tripmodel trip;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 30, 28, 28),
//       body: ValueListenableBuilder(
//         valueListenable: propertydata,
//         builder: (context, value, child) {
//           if (propertydata.value.isEmpty) {
//             return Center(child: const Text('You Have no Expenses'));
//           } else {
//             return ListView.builder(
//               itemCount: propertydata.value.length,
//               itemBuilder: (context, index) {
//                 final data = propertydata.value[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: ListTile(
//                     title: Text(
//                       data.reason,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 19,
//                       ),
//                     ),
//                     subtitle: Text(
//                       'amount paid by ${data.sponsor}',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     trailing: Text(
//                       '₹ ${data.amount}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 130),
//         child: ElevatedButton.icon(
//           onPressed: () async {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Expenses(
//                 trip: trip,
//               ),
//             ));
//           },
//           icon: const Icon(Icons.add),
//           label: const Text('Add Expense'),
//         ),
//       ),
//     );
//   }
// }
