import 'package:flutter/material.dart';
import 'package:responsiprakpam/base_network.dart';
import 'package:responsiprakpam/detail_matches.dart';
import 'package:responsiprakpam/detail_matches_model.dart';
import 'package:responsiprakpam/matches_model.dart';

class ListMatches extends StatefulWidget {
  const ListMatches({Key? key}) : super(key: key);

  @override
  _ListMatchesState createState() => _ListMatchesState();
}

class _ListMatchesState extends State<ListMatches> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PIALA DUNIA 2022",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text("PIALA DUNIA 2022", textAlign: TextAlign.center),
          centerTitle: true,
          backgroundColor: Colors.red[900],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: BaseNetwork.getList('matches'),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                // debugPrint(snapshot.data);
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                return _buildSuccessSection(snapshot.data);
              }
              return _buildLoadingSection();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  // Widget _buildSuccessSection(List<dynamic> data) {
  //   return ListView.builder(
  //       itemCount: data.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return _buildCityCountries(data[index]);
  //       });
  // }

  Widget TextBesar(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 30,
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> matches) {
    return Stack(
      children: [
        ListView.builder(itemCount: 48, itemBuilder: (BuildContext context, int index) {
          final MatchesModel matchesModel = MatchesModel.fromJson(matches[index]);

          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailMatches(id: matchesModel.id!)));
              },

              child: Container(
                //height: (MediaQuery.of(context).size.height)/4,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: _listMatchCard(matchesModel),
                    )
                  ],
                ),
              ),
            splashColor: Colors.red[300],
          );

        },
        ),
      ],
    );
  }

  Widget _listMatchCard(MatchesModel detail) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,8,20,5),
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red[100],
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://countryflagsapi.com/png/${detail.homeTeam?.name}",
                width: 100,
                // height: 20,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '${detail.homeTeam?.name}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            "${detail.homeTeam?.goals} - ${detail.awayTeam?.goals}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://countryflagsapi.com/png/${detail.awayTeam?.name}",
                width: 100,
                // height: 20,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '${detail.awayTeam?.name}',
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}