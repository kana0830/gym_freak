import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Center(
                child: Image.asset("assets/images/profile.jpeg"),
              ),
              const Icon(Icons.edit),
              // TODO
              _profileDetail(),
              // TODO
              _introduction(),
              // TODO
              _favoriteMenu(),
              // TODO
              _trainingTimes(),
              // TODO
              _tournamentResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileDetail() {
    return Container();
  }

  Widget _introduction() {
    return Container();
  }

  Widget _favoriteMenu() {
    return Container();
  }

  Widget _trainingTimes() {
    return Container();
  }

  Widget _tournamentResults() {
    return Container();
  }
}
