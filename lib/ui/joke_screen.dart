import 'package:flutter/material.dart';
import 'package:adaptive_joke_app/model/joke.dart';
import 'package:adaptive_joke_app/ui/joke_listing.dart';
import 'package:adaptive_joke_app/ui/joke_details.dart';

/// Joke screen
class JokeScreen extends StatefulWidget {
  @override
  JokeScreenAppState createState() => JokeScreenAppState();
}

/// Joke screen state
class JokeScreenAppState extends State<JokeScreen> {
  static const int tabletBreakpoint = 600;
  Joke _selectedJoke;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait &&
        shortestSide < tabletBreakpoint) {
      // Mobile
      content = _buildMobileLayout();
    } else {
      // Tablet
      content = _buildTabletLayout();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Jokes"),
      ),
      body: content,
    );
  }

  Widget _buildMobileLayout() {
    return JokeListing(
      jokeSelectedCallback: (jokeSelected) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return JokeDetails(
            isInTabletLayout: false,
            joke: jokeSelected,
          );
        }));
      },
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 13.0,
            child: JokeListing(
              jokeSelectedCallback: (joke) {
                setState(() {
                  _selectedJoke = joke;
                });
              },
              jokeSelected: _selectedJoke,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: JokeDetails(isInTabletLayout: true, joke: _selectedJoke),
        )
      ],
    );
  }
}
