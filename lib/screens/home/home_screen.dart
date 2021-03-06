import 'package:flutter/material.dart';
import 'package:iti_summer_course_tutorial/components/custom_card.dart';
import 'package:iti_summer_course_tutorial/data/users_repo.dart';
import 'package:iti_summer_course_tutorial/models/custom_card_model.dart';
import 'package:iti_summer_course_tutorial/models/user.dart';
import 'package:iti_summer_course_tutorial/screens/details/details_screen.dart';
import 'package:iti_summer_course_tutorial/screens/registeration/registration_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = UsersRepo().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return getHomeWidget();
  }

  Widget getHomeWidget() {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Hello Summer course"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: _navigateToRegistration,
      ),
      body: getUsersGrid(),
    );
  }

  void _navigateToRegistration() async {
    bool registerationResult = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterationScreen()));
    if (registerationResult != null && registerationResult) {
      setState(() {
        usersFuture = UsersRepo().getUsers();
      });
    }
  }

  Widget getUsersGrid() {
    return FutureBuilder<List<User>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                  users.length,
                  (index) => CustomeCard(
                        cardModel: new CustomCardModel(
                          title: users[index].firstName,
                          subtitle: users[index].email,
                          image: users[index].image,
                          onCardClick: () {
                            print("Clicked user id ${users[index].id}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(
                                  selectedUser: users[index],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
