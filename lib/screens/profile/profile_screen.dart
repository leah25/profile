import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditProfilePage extends HookWidget {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "My Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: Stack(
                //     children: [
                //       Container(
                //         width: 130,
                //         height: 130,
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //                 width: 4,
                //                 color: Theme.of(context).scaffoldBackgroundColor),
                //             boxShadow: [
                //               BoxShadow(
                //                   spreadRadius: 2,
                //                   blurRadius: 10,
                //                   color: Colors.black.withOpacity(0.1),
                //                   offset: Offset(0, 10))
                //             ],
                //             shape: BoxShape.circle,
                //             image: DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: NetworkImage(
                //                   "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                //                 ))),
                //       ),
                //       Positioned(
                //           bottom: 0,
                //           right: 0,
                //           child: Container(
                //             height: 40,
                //             width: 40,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               border: Border.all(
                //                 width: 4,
                //                 color: Theme.of(context).scaffoldBackgroundColor,
                //               ),
                //               color: Colors.green,
                //             ),
                //             child: Icon(
                //               Icons.edit,
                //               color: Colors.white,
                //             ),
                //           )),
                //     ],
                //   ),
                // ),

                buildTextField("First Name", "Dor Alex", false),
                buildTextField("Middle Name", "Dor Alex", false),
                buildTextField("Last Name", "Dor Alex", false),
                buildTextField("E-mail", "alexd@gmail.com", false),
                buildTextField("ID Number", "Dor Alex", false),
                buildTextField(" Current Password", "********", true),
                buildTextField("New Password", "*********", true),
                buildTextField("Confirm Password", "*********", true),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {},
                      child: Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: Row(
        children: [
          TextField(
            obscureText: isPasswordTextField ? showPassword : false,
            decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {
                          showPassword = !showPassword;
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          IconButton(
              icon: Icon(Icons.edit), color: Colors.grey, onPressed: () {})
        ],
      ),
    );
  }
}