import 'package:flutter/material.dart';
import 'package:flutter_application_1/secondpage.dart';
import 'package:flutter_application_1/search_results_page.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
  });

//custom search bar with search functionality - had help from chatgpt on the functionality

  @override
  SearchAppBarState createState() => SearchAppBarState();
}

class SearchAppBarState extends State<SearchAppBar> {
  // Example list of items to search
  final List<String> allItems = ["Knit", "Beginner", "Events", "Registrations"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            // Profile Avatar
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Secondpage(
                            username: '',
                          )),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://moderncat.com/wp-content/uploads/2014/03/bigstock-46771525_Andrey_Kuzmin-1-940x640.jpg"),
                radius: 18,
              ),
            ),

            const SizedBox(width: 10),

            // Search Bar with SearchAnchor
            Expanded(
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBar(
                      controller: controller,
                      hintText: "Search...",
                      leading: const Icon(Icons.search),
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(130, 161, 161, 161)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                      elevation: WidgetStateProperty.all(0),
                      onSubmitted: (String value) {
                        if (value.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultsPage(query: value),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  final String input = controller.text.toLowerCase();
                  final List<String> filteredItems = allItems
                      .where((item) => item.toLowerCase().contains(input))
                      .toList();

                  return filteredItems.map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        controller.closeView(item);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResultsPage(query: item),
                          ),
                        );
                      },
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
