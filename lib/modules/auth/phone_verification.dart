import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_cab/Language/appLocalizations.dart';
import 'package:my_cab/constance/constance.dart';
import 'package:my_cab/constance/global.dart' as globals;
import 'package:my_cab/constance/routes.dart';
import 'package:my_cab/constance/themes.dart';
import 'package:my_cab/Helper/request_helper.dart';
import 'package:my_cab/Helper/url_helper.dart'as url_helper;
import 'package:my_cab/modules/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneVerification extends StatefulWidget {
  @override
  Map<String, dynamic> body;
  PhoneVerification({required this.body});
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  var otpController = new TextEditingController();
  var verificationId1;
  static String smsCode = "";
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animationController..forward();
  }

  @override
  Widget build(BuildContext context) {
    var body = widget.body;
    String phone = body['mobile'];
    sendverifyphone(phone, smsCode);
    globals.locale = Localizations.localeOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, minWidth: MediaQuery.of(context).size.width),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ClipRect(
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, Widget? child) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Transform(
                                    transform: new Matrix4.translationValues(
                                        0.0,
                                        160 *
                                                (1.0 -
                                                    (AlwaysStoppedAnimation(Tween(begin: 0.4, end: 1.0)
                                                                .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)))
                                                            .value)
                                                        .value) -
                                            16,
                                        0.0),
                                    child: Image.asset(
                                      ConstanceData.buildingImageBack,
                                      color: HexColor("#FF8B8B"),
                                    ),
                                  ),
                                  Transform(
                                    transform: new Matrix4.translationValues(
                                        0.0,
                                        160 *
                                            (1.0 -
                                                (AlwaysStoppedAnimation(Tween(begin: 0.8, end: 1.0)
                                                            .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)))
                                                        .value)
                                                    .value),
                                        0.0),
                                    child: Image.asset(
                                      ConstanceData.buildingImage,
                                      color: HexColor("#FFB8B8"),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: (MediaQuery.of(context).size.height / 2) - (MediaQuery.of(context).size.width < 360 ? 124 : 86),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 8,
                        child: Column(
                          children: <Widget>[
                            _loginTextUI(),
                            _emailUI(),
                            _getVerifyUI(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Container(
                      padding: EdgeInsets.only(top: 0, left: 8),
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: new BorderRadius.circular(AppBar().preferredSize.height),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 26,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 8),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of('Phone Verification'),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emailUI() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
          child: getOtpTextUI(otptxt: otpController.text),
        ),
        Opacity(
          opacity: 0.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: otpController,
                            maxLength: 6,
                            onChanged: (String txt) {},
                            onTap: () {},
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: new InputDecoration(
                              errorText: null,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginTextUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 30, bottom: 30),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          AppLocalizations.of('Enter your OTP code here'),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _getVerifyUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              verifyPhone(widget.body);
              Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (Route<dynamic> route) => false);
            },
            child: Center(
              child: Text(
                AppLocalizations.of("Verify now"),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getOtpTextUI({String otptxt = ""}) {
    // ignore: deprecated_member_use
    List<Widget> otplist = [];
    Widget getUI({String otxt = ""}) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Theme.of(context).dividerColor, width: 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(otxt, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < 6; i++) {
      otplist.add(getUI(otxt: otptxt.length > i ? otptxt[i] : "-"));
    }
    return Row(
      children: otplist,
    );
  }

  sendverifyphone(String phone,String smsCode) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: "${phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        print("hi $credential");
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      }, verificationFailed: (FirebaseAuthException error) {
    },
      codeAutoRetrievalTimeout: (String verificationId){
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        // Create a PhoneAuthCredential with the code
        setState(() {
          verificationId1 = verificationId;
        });

        // Sign the user in (or link) with the credential
      },
    );
  }

  verifyPhone(Map<String, dynamic> body) async {

    final prefs = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId1, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value) async {
      if(value.user != null){
        url_helper.Constants url_help = new url_helper.Constants();
        request_helper request_help = new request_helper();
        Uri uri = Uri.parse(url_help.register);
        await request_help.requestPost(uri, body).then((response) async{
          if (response.statusCode == 200) {
            print(json.decode(response.body));
            // if(json.decode(response.body)["error"] == true){
            //   hideLoading();
            //   showError("The email has already been taken.");
            //
            // }else {
            //login?

            await prefs.setString("access_token", json.decode(response.body)[0]["access_token"]); //elmo4kela fe el satr daaaaaaaaaaaaa
            // print(json.decode(response.body)["id"].runtimeType);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),  (route) => false);
            // }
          }
          else {
            //showError("registration error");
          }
        });
      }
    });
  }
}
