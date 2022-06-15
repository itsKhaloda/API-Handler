import 'package:flutter/material.dart';
import 'package:iti_summer_course_tutorial/data/users_repo.dart';
import 'package:iti_summer_course_tutorial/models/user.dart';
import 'package:iti_summer_course_tutorial/models/update.dart';

class UserDetailsScreen extends StatefulWidget {
  final User selectedUser;
  UserDetailsScreen({required this.selectedUser});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String? job;
  final formKeyy = GlobalKey<FormState>();
  bool _isLoading = false;
  _submitForm() async {
    if (formKeyy.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        formKeyy.currentState!.save();
        print("Valid form $job");
        UpdateRequest updateRequest =
            new UpdateRequest(name: widget.selectedUser.firstName, job: job!);
        UpdateResponse response =
            await UsersRepo().updateCurrentUser(updateRequest);
        setState(() {
          _isLoading = false;
        });
        _showSnackBar(
            "Name: ${response.name}  Job: ${response.job}  UpdatedAt: ${response.updatedAt}");
        Navigator.of(context).pop(true);
        print("Update response $response");
      } catch (error) {
        setState(() {
          _isLoading = true;
        });
        _showSnackBar(error.toString());
      }
    } else {
      print("Form is not valid");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: formKeyy,
        child: Column(
          children: [
            TextFormField(
              enabled: false,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              initialValue: widget.selectedUser.firstName,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onFieldSubmitted: (String? value) {
                job = value;
              },
              onSaved: (String? value) {
                job = value;
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid job.";
                }
              },
              decoration: InputDecoration(
                labelText: "Job",
              ),
            ),
            ElevatedButton(onPressed: _submitForm, child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
