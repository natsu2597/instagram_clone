import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_method.dart';



class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  })
  async {
      String res = 'Some error occured';
      try{
          if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty )
          {
          UserCredential cred =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
          print(cred.user!.uid);

          String photoUrl = await StoragMethod().uploadImageStorage('profilePics', file, false);
          await _firestore.collection('users').doc(cred.user!.uid).set({
            'username' : username,
            'uid': cred.user!.uid,
            'email': email,
            'bio': bio,
            'followers': [],
            'following': [],
            'photoUrl' : photoUrl,
          });
          res = 'Success';
          

          }

      }
      on FirebaseAuthException catch(err){
        if(err.code == 'invalid-email'){
          res = 'The email id is invalid';
        }
        
      }
      catch(err){
        res = err.toString();
      }
      return res;
  }
}