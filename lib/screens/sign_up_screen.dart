import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widget/text_input_field.dart';
import 'package:instagram_clone/resources/auth_method.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNamaeController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNamaeController.dispose();
  }

  void selectImage() async {
   Uint8List input = await pickImage(ImageSource.gallery);
   setState(() {
     _image = input;
   });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 32),
           width: double.infinity,
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(),flex: 2,),
               SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor, height: 64,),
               const SizedBox(height: 64,),
                const SizedBox(
                height: 24,
               ),
               Stack(
                children: [
                  _image != null ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ) : 
                  const  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://cdn.awwni.me/1bnn3.jpg'),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(onPressed: selectImage,
                   icon: const Icon(Icons.add_a_photo)))
                ],
               ),
               const SizedBox(
                height: 24,
               ),

               TextInputField(textEditingController: _userNamaeController , hintText: 'Enter Your username', textInputType: TextInputType.text),
               const SizedBox(
                height: 24,
               ),
               TextInputField(textEditingController: _emailController , hintText: 'Enter Your email', textInputType: TextInputType.emailAddress),
               const SizedBox(
                height: 24,
               ),
               TextInputField(textEditingController: _passController, hintText: 'Enter your password', textInputType: TextInputType.text,isPass: true,),
               const SizedBox(
                height: 24,
               ),
                TextInputField(textEditingController: _bioController, hintText: 'Enter your bio', textInputType: TextInputType.text,),
                const SizedBox(
                height: 24,
               ),
               


               InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(email: _emailController.text, password: _passController.text, username: _userNamaeController.text, bio: _bioController.text, file: _image!);
                  print(res);
                } ,
                 child: Container(
                  child : const Text('Sign-up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)
                    )
                  ),
                  color: blueColor
                  ),
                  ),
               ),
                const SizedBox(
                  height: 12,
                ),
                 Flexible(child: Container(),flex: 2,),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: const Text("Don't have an account"),
                        padding:const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                     Container(
                      child: Text("Sign-up now",style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      padding:const EdgeInsets.symmetric(vertical: 8),
                    )
                  ],
                 )


            ],
           ),
           )
           ),
    );
  }
}