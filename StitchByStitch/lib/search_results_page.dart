import 'package:flutter/material.dart';
import 'package:flutter_application_1/eigth_page.dart';
import 'package:flutter_application_1/events.dart';
import 'package:flutter_application_1/registrations.dart';
import 'package:flutter_application_1/tutorials.dart';
import 'package:flutter_application_1/search_bar.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  //custom search bar -results page - had help from chatgpt on the functionality and implementation

  const SearchResultsPage({super.key, required this.query});

  @override
  SearchResultsPageState createState() => SearchResultsPageState();
}

class SearchResultsPageState extends State<SearchResultsPage> {
  final List<Map<String, String>> allItems = [
    {
      "name": "Knit",
      "description": "Find knitting tutorials here",
      "route": "/knit"
    },
    {
      "name": "Beginner",
      "description": "Introduction to Beginner Techniques",
      "route": "/beginner"
    },
    {"name": "Events", "description": "Find events here", "route": "/events"},
    {
      "name": "Registrations",
      "description": "Available registrations here",
      "route": "/registrations"
    },
  ];

  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchData(widget.query);
  }

  void _searchData(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) =>
              item["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToPage(String routeName) {
    if (routeName == "/knit") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TutorialPage()));
    } else if (routeName == "/beginner") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EigthPage()));
    } else if (routeName == "/events") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EventsScreen()));
    } else if (routeName == "/registrations") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegistrationsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(),
        toolbarHeight: kToolbarHeight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Red rectangle manage registrations button
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 137, 57, 57),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 4)
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Text(
                          "Search Results:",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 10), // Space between button and search results

            // Search Results List
            filteredItems.isEmpty
                ? Center(
                    child: Text(
                      "No results found for \"${widget.query}\"",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 137, 57, 57),
                          size: 35,
                        ),
                        title: Text(
                          filteredItems[index]["name"]!,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          filteredItems[index]["description"]!,
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          _navigateToPage(filteredItems[index]["route"]!);
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
