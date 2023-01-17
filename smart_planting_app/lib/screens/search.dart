import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens//user.dart';
import 'package:smart_planting_app/screens/activityFeed.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';

final docUser = FirebaseFirestore.instance.collection('users');

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot>? searchResultsFuture;

  clearSearch() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: searchResultsFuture == null? buildNoContent() :
      buildSearchResults(),
    );
  }

  AppBar buildSearchField() {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.green,
      backgroundColor: Colors.green,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(

          hintText: "Search for a user...",
          filled:  false,
          prefixIcon: const Icon(
            Icons.account_box_outlined,
            size: 28,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              clearSearch();
            },
          )
        ),

        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.network('https://hicomcare.com.au/Images/icon-finder.png?t=1', height: 300,),
            const SizedBox(height: 40,),
            Text("Find Users", textAlign: TextAlign.center, style: TextStyle(
              color: Colors.green.shade400,
              fontSize: 60,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic
            ))
          ],
        ),
      ),
    );
  }

  handleSearch(String query) async {
    Future<QuerySnapshot> users = docUser
        .where("username", isGreaterThanOrEqualTo: query)
        .get();

    print(users);

    setState(() {
      searchResultsFuture = users;
    });
  }

  Widget buildUser(AppUser user) => ListTile(
    leading: CircleAvatar(child: Image.asset('asset/profile.png'),),
    title: Text(user.username),
  );

  Stream<List<AppUser>> readUsers() => docUser.snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => AppUser.fromJson(doc.data())).toList());

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data!.docs.forEach((doc) {
          AppUser user = AppUser.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      }
    );
  }

}

class UserResult extends StatelessWidget {
  final AppUser user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showProfile(context, profileId: user.id),
            child: Container(
              color: Colors.green.shade50,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                ),
                title: Text(user.username, style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ),
          const Divider(
            color: Colors.white54,
            height: 1,
          )
        ],
      ),
    );
  }
}
