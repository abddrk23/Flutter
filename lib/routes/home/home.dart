import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhino_pizzeria_challenge/models/user_model.dart';
import 'package:rhino_pizzeria_challenge/services/add_user.dart';
import 'package:rhino_pizzeria_challenge/services/sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, bool? isAdmin}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('products').snapshots();
  final userData = FirebaseAuth.instance.currentUser;
  final userModel = UserModel();
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    addUser(userModel, userData!);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'IsAdmin:',
              style: TextStyle(color: Colors.black),
            ),
            Checkbox(
              value: isAdmin,
              onChanged: (value) {
                setState(() {
                  isAdmin = value!;
                });
                isAdmin
                    ? addUser(userModel, userData!, isAdmin: isAdmin)
                    : null;
              },
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'GoogleMap');
          },
          icon: const Icon(
            Icons.map_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final provider =
                  Provider.of<SignInProvider>(context, listen: false);
              await provider.signOutGoogle();
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'AddNew');
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * 0.05,
                  vertical: _size.height * 0.01,
                ),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: _size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(userData!.photoURL!),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data['title']),
                            Text(data['description']),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05,
                          ),
                          child: const Text('Price'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
