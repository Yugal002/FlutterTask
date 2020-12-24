import 'package:flutter/material.dart';
import 'package:flutter_task/bloc/data_bloc.dart';
import 'package:flutter_task/models/users_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dataBloc = DataBloc();

  @override
  void initState() {
    dataBloc.eventSink.add(DataAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Pattern App'),
      ),
      body: Container(
        child: StreamBuilder<List<UsersData>>(
          stream: dataBloc.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data[index];
                    //  var formattedTime = DateFormat('dd MMM - HH:mm').format(article.publishedAt);
                    return Card(
                      elevation: 3,
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                               article.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email: ' + article.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Address: ' +
                                  article.address.street +
                                  ' ' +
                                  article.address.city,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Phone.: ' + article.phone,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
