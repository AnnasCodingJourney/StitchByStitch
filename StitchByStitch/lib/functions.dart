import 'package:flutter/material.dart';
import 'package:flutter_application_1/event_data.dart';
import 'package:flutter_application_1/notifications_data.dart';
import 'package:provider/provider.dart';

// Had to create a custom Nav Bar class otherwise calling it elsewhere in the code wouldn't work.
class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    // Navbar constructor
    super.key, // This helps with updating the element  - https://api.flutter.dev/flutter/foundation/Key-class.html
    required this.currentPageIndex, // This is a value that's passed in and keeps track of the navigation item.
    required this.onTap, // This is a function that is required for interactivity with the navbar items.
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Semantics(
        label: "Bottom Navigation Bar",
        hint: "Used to navigate between pages",
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) {
            onTap(index);
          },
          //indicatorColor: Color.fromRGBO(137, 57, 57,1), // https://rgbacolorpicker.com/hex-to-rgba Taken from Figma Hexcode and converted
          destinations: <Widget>[
            // Destination 1 - Home/Main page
            NavigationDestination(
              // Semantics really don't like `Consts`
              icon: Semantics(
                label: "Home",
                hint:
                    "Go to the Home/Social Feed page", // Created the differen between being on the home page
                child: Icon(Icons.home_outlined),
              ),

              selectedIcon: Semantics(
                label: "Home",
                hint:
                    "Currently on the Home/Social Feed page", // And navigating to the home page
                child: Icon(Icons.home_outlined),
              ),
              label: "Home",
            ),

            // Destination 2 - Notifications page
            NavigationDestination(
              icon: Consumer2<NotificationData, EventData>(
                builder: (context, notificationData, eventData, child) {
                  int totalNotifications =
                      notificationData.notifications.length +
                          eventData.registeredEvents.length; // (C-GPT)

                  return Semantics(
                    hint: totalNotifications > 0
                        ? "You have $totalNotifications new notifications" // Checks if there is notifications
                        : "No new notifications", // Returns this if there are none
                    child: Badge(
                      label: Text(totalNotifications.toString()),
                      child: const Icon(Icons.notifications_sharp),
                    ),
                  );
                },
              ),
              label: 'Notifications',
            ),

            // Destination 3 - Tutorials
            NavigationDestination(
              // This doesn't work with `semantics` and `const`
              icon: Semantics(
                hint: "View available Tutorials",
                label: 'Tutorials',
                child: Badge(child: Icon(Icons.import_contacts)),
              ),
              label: "Tutorials",
            ),

            // Destination 4 - Events
            NavigationDestination(
              icon: Semantics(
                label: "Events",
                hint: "View upcoming events",
                child: Badge(label: Text("!"), child: Icon(Icons.group)),
              ),
              label: 'Events',
            ),
          ],
        ));
  }
}
