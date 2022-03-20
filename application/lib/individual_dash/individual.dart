import 'package:application/commonscreens/login.dart';
import 'package:application/individual_dash/ipersonal.dart';
import 'package:application/individual_dash/irecord.dart';
import 'package:application/individual_dash/istatistic.dart';
import 'package:application/model/i_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:application/Widgets/colors.dart' as color;

class Individual extends StatefulWidget {
  const Individual({Key? key}) : super(key: key);

  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //Istat
    final Istat = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 39, 187, 59),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Istatistic()));
          },
          child: const Text(
            "Statistical Data",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    //Ipersonal
    final Iperson = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 39, 187, 59),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Ipersonal()));
          },
          child: const Text(
            "Personal Data",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    //Medical records
    final Irec = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 39, 187, 59),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Irecord()));
          },
          child: const Text(
            "Medical Records",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    /*Individual dashboard-> Statistical details 
Individual dashboard-> Personal details 
Individual dashboard-> Medical records */
    return Scaffold(
      backgroundColor: color.Appcolor.white,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Health Tech",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 10, 139, 75),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),
            const Text(
              "Individual dashboard  ",
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w500),
            ),
            ActionChip(
                label: const Text("Logout"),
                onPressed: () {
                  logout(context);
                }),
            const SizedBox(
              height: 25,
            ),
            Istat,
            const SizedBox(
              height: 20,
            ),
            Iperson,
            const SizedBox(
              height: 20,
            ),
            Irec,
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Ilogin()));
  }
}
