import 'package:first_step_in_layout/drawer.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          drawer: DrawerOnly(),
          body: PersonWidget(),
        ));
  }
}

// Первый виджет для отображения UI
//  Второй для управления состоянием
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int current_time = 7;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(current_time.toString() + "am"),
    );
  }
}

//Flutter рекомедує кожен новий нами створений клас виносити в новий документ при цьому клас має наслідуватись від флатерівського класу

class PersonWidget extends StatefulWidget {
  @override
  _PersonWidgetState createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {
  List<Widget> litems = [];

  _PersonWidgetState() {
    litems.add(
      _buildSimenticContainer(
          "https://d.newsweek.com/en/full/1600783/summer-solstice-day.jpg",
          "Stage 1",
          "Try to be better than your dream"),
    );
    litems.add(
      _buildSimenticContainer(
          "https://www.womensecret.info/wp-content/uploads/2018/06/913.jpg",
          "Stage 2",
          "What do you chose: a new job or brackfast"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerOnly(),
      appBar: AppBar(
        title: Text("Украина, Киев"),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        _buildHead("Hi, a new day"),

        //погана практика виносоти реалізацію в окремий метод
        //але для вивчення поки так
        // child: _buildMainColumn(),
        Expanded(
            child: new ListView.builder(
                itemCount: litems.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return Center(child: litems[Index]);
                })),
      ]),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            setState(() {
              this.litems.add(_buildSimenticContainer(
                  "https://d.newsweek.com/en/full/1600783/summer-solstice-day.jpg",
                  "Stage 3",
                  "Work hard to make more money"));
            });

            // Respond to button press
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildMainColumn() => ListView(
        children: [
          _buildHead("Hi, a new day"),
          Center(
              child: _buildSimenticContainer(
                  "https://d.newsweek.com/en/full/1600783/summer-solstice-day.jpg",
                  "Stage 1",
                  "Try to be better than your dream")),
          Center(
            child: _buildSimenticContainer(
                "https://www.womensecret.info/wp-content/uploads/2018/06/913.jpg",
                "Stage 2",
                "What do you chose: a new job or brackfast"),
          ),
        ],
      );

  Widget _buildSimenticContainer(
          String imageUrl, String label, String description) =>
      Container(
        child: Column(children: <Widget>[
          _buildImage(imageUrl),
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: _buildDescriptionFirstPhase(label, description),
          ),
          // для групування и красивого отображения + 3d по этому есть тень
          Card(
            //elevation + 3d по этому есть тень
            elevation: 10,
            margin: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: _buildAction(),
            ),
          ),
          _buildTextContainer(),
        ]),
      );

  Widget _buildTextContainer() => Container(
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 10),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(width: 3.0, color: Colors.orange),
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries """,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildHead(String lable) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Color.fromRGBO(229, 116, 56, 0.4)])),
        child: Center(
          child: Text(
            lable,
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );

  Widget _buildImage(String image_link) => Container(
        margin: const EdgeInsets.only(top: 0),
        child: Image.network(image_link, fit: BoxFit.fill),
      );

  Widget _buildDescriptionFirstPhase(String label, String text) => ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FavoriteWidget(),
        ],
      ));

  Widget _buildAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: _buildButton(
                'Sleep', 0, Icons.airline_seat_individual_suite, Colors.green),
          ),
          _buildButton(
              'Get up', 2, Icons.airline_seat_flat_angled, Colors.blue),
          _buildButton('Wake up', 0, Icons.mood_bad, Colors.orange),
        ],
      );

  Widget _buildButton(
          String lable, int numberActive, IconData icon, Color color) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: color,
          ),
          FirstStageButton(lable, numberActive, color)
        ],
      );
}

class FirstStageButton extends StatefulWidget {
  String lable;
  int flagIdentificator;
  Color color;

  FirstStageButton(this.lable, this.flagIdentificator, this.color);
  @override
  _FirstStageButtonState createState() => _FirstStageButtonState();
}

class _FirstStageButtonState extends State<FirstStageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (widget.flagIdentificator == 1)
          ? BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 3.0, color: Colors.yellow),
            ))
          : (widget.flagIdentificator == 2)
              ? BoxDecoration(
                  border: Border(
                  bottom: BorderSide(width: 3.0, color: Colors.blue),
                ))
              : (widget.flagIdentificator == 3)
                  ? BoxDecoration(
                      border: Border(
                      bottom: BorderSide(width: 3.0, color: Colors.orange),
                    ))
                  : null,
      child: Text(
        widget.lable,
        style: TextStyle(fontWeight: FontWeight.bold, color: widget.color),
        softWrap: false,
        overflow: TextOverflow.ellipsis, //text продолажеться ...
      ),
    );
  }
}
