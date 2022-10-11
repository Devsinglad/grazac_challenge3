import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/Provider.dart';
import 'package:grazac_challenge3/screens/admin/getTotalUser.dart';
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
      var apiData = Provider.of<ApiDB>(context, listen: false);
      apiData.AdminGetUser(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context, listen: false);
    apiData.AdminBlockUser(context);
    return Scaffold(
      body: Consumer<ApiDB>(
        builder: (context, snapshot, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              apiData.isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0xff5771F9),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.demoData[0]['getUsers'].length,
                        itemBuilder: (context, i) {
                          var info = snapshot.demoData[0]['getUsers'][i];
                          return UserDetails(
                            email: "${info["email"]}",
                            lastName: "${info['lastName']}",
                            firstName: "${info["firstName"]}",
                            phoneNumber: "${info["phoneNumber"]}",
                            account: "${info["accountNumber"]}",
                            createdAt: "${info["createdAt"]}",
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
// leading: Text("${info["firstName"]}"),
// title: Text("${info['lastName']}"),
// subtitle: Text("${info["email"]}"),
// trailing: Text("${info["accountNumber"]}"),

class UserDetails extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String account;
  final String phoneNumber;
  final String createdAt;

  UserDetails(
      {required this.email,
      required this.lastName,
      required this.firstName,
      required this.phoneNumber,
      required this.account,
      required this.createdAt,
      Key? key})
      : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.firstName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.lastName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.phoneNumber,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.account,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.createdAt,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: ElevatedButton(
            onPressed: () {
              apiData.isLoading == true
                  ? CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Color(0xff5771F9),
                      ),
                    )
                  : apiData.AdminBlockUser(context);
            },
            child: Text('Block'),
            style: ButtonStyle(backgroundColor:
                MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red;
              } else {
                return Colors.purple;
              }
            })),
          ),
        ),
        Positioned(
          right: 20,
          top: 80,
          child: InkWell(
            onTap: () {
              apiData.userData(context).then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TotalUser()));
              });
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Get Total Users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
