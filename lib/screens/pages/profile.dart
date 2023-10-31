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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/images/profile.jpeg"),
                    width: 160,
                    height: 160,
                  ),
                  Container(
                    child: const Icon(Icons.edit),
                    margin: EdgeInsets.only(top: 140),
                  ),
                ],
              ),
              // TODO
              _profileDetail(),
              const Text("自己紹介"),
              // TODO
              _introduction(),
              const Text("好きな種目"),
              // TODO
              _favoriteMenu(),
              const Text("トレーニング回数"),
              // TODO
              _trainingTimes(),
              const Text("大会実績"),
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
