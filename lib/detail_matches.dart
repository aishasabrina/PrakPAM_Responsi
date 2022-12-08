
import 'package:flutter/material.dart';
import 'package:responsiprakpam/matches_model.dart';
import 'package:responsiprakpam/base_network.dart';
import 'package:responsiprakpam/detail_matches_model.dart';

class DetailMatches extends StatefulWidget {

  final String id;
  const DetailMatches({Key? key, required this.id}) : super(key: key);


  @override
  State<DetailMatches> createState() => _DetailMatchesState();
}

class _DetailMatchesState extends State<DetailMatches> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text("Match ID: ${widget.id}",),
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: BaseNetwork.get('matches/${widget.id}'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              // debugPrint(snapshot.data);
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              final DetailMatchesModel detailMatchesModel = DetailMatchesModel.fromJson(snapshot.data);
              return _buildSuccessSection(detailMatchesModel);
            }
            return _buildLoadingSection();
          },
        ),
      ),

    );
  }
  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DetailMatchesModel detail) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _listMatchCard(detail),
          _detailMatch(detail),
          SizedBox(
            height: 10,
          ),
          _statisticsCard(detail),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Colors.redAccent[100],
            elevation: 10,
            shadowColor: Colors.redAccent[200],
            child: ListTile(
              title: Text('Referees', textAlign: TextAlign.center,),
            ),
          ),
          _refereesCard(detail)
        ],
      ),

    );
  }

  Widget _listMatchCard(DetailMatchesModel detail) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://countryflagsapi.com/png/${detail.homeTeam?.name}",
                width: 150,
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
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://countryflagsapi.com/png/${detail.awayTeam?.name}",
                width: 150,
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

  Widget _detailMatch(DetailMatchesModel detail){
    return Card(
      color: Colors.redAccent[100],
      elevation: 10,
      shadowColor: Colors.redAccent[200],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Text(
                "Stadium : ${detail.venue} ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0,),
              ),
              Text(
                "Location : ${detail.location} ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget _statisticsCard(DetailMatchesModel detail){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
              color: Colors.redAccent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Statistics",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                // Ball Possession
                Column(
                  children: [
                    const Text(
                      "Ball Possession",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.ballPossession}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.ballPossession}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Shot
                Column(
                  children: [
                    const Text(
                      "Shot",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.attemptsOnGoal}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.attemptsOnGoal}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Shot on Goal == kiksOnTarget
                Column(
                  children: [
                    const Text(
                      "Shot on Goal",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.kicksOnTarget}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.kicksOnTarget}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Corners == corner
                Column(
                  children: [
                    const Text(
                      "Corners",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.corners}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.corners}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Offside == offsides
                Column(
                  children: [
                    const Text(
                      "Offsides",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.offsides}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.offsides}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Fouls == foulsRecieved
                Column(
                  children: [
                    const Text(
                      "Fouls",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${detail.homeTeam?.statistics?.foulsReceived}',
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${detail.awayTeam?.statistics?.foulsReceived}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Pass Acurracy == ???
                Column(
                  children: [
                    Text(
                      "Pass Accuracy",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '??',
                          //'${detail.homeTeam?.statistics?.foulsReceived}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '??',
                          //'${detail.awayTeam?.statistics?.foulsReceived}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _refereesCard(DetailMatchesModel detail){
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 150,
          child: ListView.builder(
              itemBuilder: (context, index){
                return InkWell(
                  child: Container(
                    width: 150,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/0/0a/FIFA_series_logo_%282020-present%29.svg',
                              width: 150, alignment: Alignment.center,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "${detail.officials?[index].name}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${detail.officials?[index].role}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: detail.officials?.length,
          ),
        ),
      ),
    );
  }

}

