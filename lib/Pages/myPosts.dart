
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/Pages/explorePage.dart';
import 'package:cse_ccnust/Pages/reviewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {


  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {

  Future<List<DocumentSnapshot>> getData()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qs = await firestore.collection('Review').orderBy('createdAt',descending: true).where('uid',isEqualTo: uid).get();
    return qs.docs;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,

        title: Center(
          child: Image.asset(
            'assets/T.gif',
            fit: BoxFit.contain,
            height: 40,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color:Colors.black,

              )),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.yellow,Colors.yellowAccent]
          ),
        ),
        child: FutureBuilder(
          future: getData(),
          builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if(!snapshot.hasData){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (_, index){
                  DocumentSnapshot data = snapshot.data![index];
                  return Card(

                    child: ListTile(
                      title: Text(data['res_name'],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                      subtitle: Text(data['food_name']),
                      trailing: Wrap(
                        children: [
                          IconButton(onPressed: (){
                            //Navigator.push(context, CupertinoPageRoute(builder: (builder)=>ReviewPage(location[index])));
                          }, icon: Icon(Icons.edit)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: (){
                            //Navigator.push(context, CupertinoPageRoute(builder: (builder)=>ExplorePage(location[index])));
                          }, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }
}
