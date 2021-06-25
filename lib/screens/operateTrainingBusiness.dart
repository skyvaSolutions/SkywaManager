import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skywamanager/Providers/businessDataProvider.dart';

class operateTrainingBusiness extends StatefulWidget {
  final id;
  const operateTrainingBusiness({Key key, this.id}) : super(key: key);

  @override
  _operateTrainingBusinessState createState() =>
      _operateTrainingBusinessState();
}

class _operateTrainingBusinessState extends State<operateTrainingBusiness> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<businessDataProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        child: ListView(
          children: List.generate(50,  (f) => Text("Item $f")),
        ),
        onRefresh: () async {
          print("Refreshing");
          return await p.getReservationData(widget.id);
        },
      ),
    );
  }
}
