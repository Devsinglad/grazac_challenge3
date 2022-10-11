import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/Provider.dart';
import 'package:grazac_challenge3/models/getUserModel.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((value) {
      var apiData = Provider.of<ApiDB>(context);
      apiData.AdminGetUser(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<GetUserModel>(
            //future: apiData.AdminGetUser(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.getUsers?.length,
                    itemBuilder: (context, i) {
                      var info = snapshot.data?.getUsers![i];
                      return ListTile(
                        leading: Text("${info?.firstName}"),
                        title: Text("${info?.lastName}"),
                        subtitle: Text("${info?.email}"),
                        trailing: Text("${info?.accountNumber}"),
                      );
                    },
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Color(0xff5771F9),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
