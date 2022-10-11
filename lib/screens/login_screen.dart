import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/utils.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widget/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
  void loginUser()async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passController.text);
    if(res == 'success')
    {

    }
    else{
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
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
               TextInputField(textEditingController: _emailController , hintText: 'Enter Your email/username', textInputType: TextInputType.emailAddress),
               const SizedBox(
                height: 24,
               ),
               TextInputField(textEditingController: _passController, hintText: 'Enter your password', textInputType: TextInputType.text,isPass: true,),
               const SizedBox(
                height: 24,
               ),

               InkWell(
                onTap: loginUser,
                 child: Container(
                  child : _isLoading ? Center(child: CircularProgressIndicator(),) : const Text('Login'),
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