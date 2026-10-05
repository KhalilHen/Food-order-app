///!! Tempoary removed for V1.0
// import '../utils/utils.dart';
// import 'package:hf_customer_app/controller/menu_controller.dart';
// import 'package:hf_customer_app/core/custom-widgets/menu_options_widget.dart';
// import 'package:hf_customer_app/models/menu_item.dart';
// import 'package:hf_customer_app/models/menu_item_option_group.dart';
// class CustomMenuGroupWidget extends StatefulWidget {
//   final MenuItem item;

//   const CustomMenuGroupWidget({super.key, required this.item});

//   @override
//   CustomMenuGroupWidgetState createState() => CustomMenuGroupWidgetState();
// }

// class CustomMenuGroupWidgetState extends State<CustomMenuGroupWidget> {
//   final menuController = MenuItemController();

//   @override
//   // final MenuItem item;
//   // CustomMenuGroupWidget({   required this.item})
//   // CustomMenuGroupWidget({})
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: menuController.fetchMenuItemGroup(widget.item.id),
//       builder: (context, snapshot) {
//         {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const CircularProgressIndicator();

//             case ConnectionState.done:
//               if (snapshot.hasData || snapshot.data!.isEmpty) {
//                 final menuOptionGroups = snapshot.data!
//                     .where((group) => group.isActive)
//                     .toList();

//                 // ** This goes to the custom widget which completly controls how the group options look
//                 return Column(
//                   children: menuOptionGroups
//                       .map((group) => buildMenuGroup(group))
//                       .toList(),
//                 );
//               }

//             case ConnectionState.none:
//               // TODO: Handle this case.
//               throw UnimplementedError();
//             case ConnectionState.active:
//               return const CircularProgressIndicator();
//           }
//           return const Text(
//             "Der ging iets mis met het ophalen van de opties contact support a.u.b",
//           );
//         }
//       },
//     );
//   }

//   Widget buildMenuGroup(MenuItemOptionGroup group) {
//     // TODO Fix that the options aren't reloaded when a quantity changes
//     // ! Some additional fixs https://claude.ai/chat/acc0c6f2-ae76-4d23-854a-3d1ec455dea8
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               group.name,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             if (group.isRequired)
//               const Padding(
//                 padding: EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   '*',
//                   style: TextStyle(color: Colors.red, fontSize: 18),
//                 ),
//               ),
//           ],
//         ),
//         const SizedBox(height: 8),

//         //TODO Here comes the different selections of each item
//         CustomMenuOptionsWidget(item: group),

//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
