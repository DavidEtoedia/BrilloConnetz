import 'package:brillo_connetz/presentation/screens/buddies/buddies.dart';
import 'package:brillo_connetz/presentation/screens/discover/discover_screen.dart';
import 'package:brillo_connetz/presentation/screens/profile/profile_screen.dart';
import 'package:brillo_connetz/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    const ProfileScreen(),
    const BuddiesScreen(),
    const DiscoverScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList.elementAt(pageIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          elevation: 20,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                activeIcon: Icon(Icons.person),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group),
                activeIcon: Icon(Icons.group),
                label: 'Buddies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore),
                activeIcon: Icon(Icons.travel_explore),
                label: 'Discover'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings),
                label: 'Setting'),
          ],
        ));
  }
}



// // ignore: must_be_immutable
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key, this.selectedIndex = 0}) : super(key: key);
//   int? selectedIndex;

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   void onPageSelected(int index) {
//     // _page = widget.selectedIndex ?? index;
//     setState(() {
//       widget.selectedIndex = index;
//     });
//   }

//   int pageIndex = 0;

//   List<Widget> pageList = <Widget>[
//     const Placeholder(),
//     const Placeholder(),
//     const Placeholder(),
//     const Placeholder(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: pageList[widget.selectedIndex ?? 0],
       
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: widget.selectedIndex ?? 0,
//           onTap: onPageSelected,
//           //  (value) {
//           //   setState(() {
//           //     pageIndex = value;
//           //   });
//           // },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blue,
//           elevation: 20,
//           items: [
//             BottomNavigationBarItem(
//                 icon:Icon(Icons.person),
//                 activeIcon: Icon(Icons.person),
//                 label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 activeIcon: Icon(Icons.person),
//                 label: 'Template'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 activeIcon: Icon(Icons.person),
//                 label: 'Publish'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 activeIcon: Icon(Icons.person),
//                 label: 'Profile'),
//           ],
//         ));
//   }
// }
