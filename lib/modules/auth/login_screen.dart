import 'dart:io' show Platform;
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab/Language/appLocalizations.dart';
import 'package:my_cab/constance/constance.dart';
import 'package:my_cab/constance/global.dart' as globals;
import 'package:my_cab/constance/themes.dart';
import 'package:my_cab/extension/string_extension.dart';
import 'package:my_cab/modules/auth/phone_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  // Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('US');
  bool isSignUp = true;
  String phoneNumber = '';
  String countryCode = "+91";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordconfirmController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  static Future<void> getDeviceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceName="";
    String deviceType="";
    String identifier="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceType = build.version.toString();
        identifier = build.androidId;  //UUID for Android
        await prefs.setString('deviceType', "android");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceType = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
        await prefs.setString('deviceType', "ios");
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    await prefs.setString('deviceName', deviceName);
    await prefs.setString('identifier', identifier);
    //if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animationController..forward();
  }
  @override
  Widget build(BuildContext context) {
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
                                  Positioned(
                                    bottom: (MediaQuery.of(context).size.height / 8),
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: AnimatedBuilder(
                                          animation: animationController,
                                          builder: (BuildContext context, Widget? child) {
                                            return Transform(
                                              transform: new Matrix4.translationValues(
                                                  0.0,
                                                  80 *
                                                      (1.0 -
                                                          (AlwaysStoppedAnimation(
                                                            Tween(begin: 0.0, end: 1.0).animate(
                                                              CurvedAnimation(
                                                                parent: animationController,
                                                                curve: Curves.fastOutSlowIn,
                                                              ),
                                                            ),
                                                          ).value)
                                                              .value),
                                                  0.0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(36.0),
                                                ),
                                                elevation: 12,
                                                child: Image.asset(ConstanceData.appIcon),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
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
                      height: (MediaQuery.of(context).size.height / 2) - (MediaQuery.of(context).size.height < 600 ? 124 : 86),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                              margin: EdgeInsets.all(0),
                              elevation: 8,
                              child: ListView(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                          onTap: () {
                                            setState(() {
                                              isSignUp = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    AppLocalizations.of('Sign Up'),
                                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: isSignUp ? Theme.of(context).textTheme.headline6!.color : Theme.of(context).disabledColor,
                                                        ),
                                                  ),
                                                ),
                                                isSignUp
                                                    ? Padding(
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Card(
                                                          elevation: 0,
                                                          color: Theme.of(context).primaryColor,
                                                          child: SizedBox(
                                                            height: 6,
                                                            width: 48,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                          onTap: () {
                                            setState(() {
                                              isSignUp = false;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    AppLocalizations.of('Sign In'),
                                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: !isSignUp ? Theme.of(context).textTheme.headline6!.color : Theme.of(context).disabledColor,
                                                        ),
                                                  ),
                                                ),
                                                !isSignUp
                                                    ? Padding(
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Card(
                                                          elevation: 0,
                                                          color: Theme.of(context).primaryColor,
                                                          child: SizedBox(
                                                            height: 6,
                                                            width: 48,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  AnimatedCrossFade(
                                    alignment: Alignment.topCenter,
                                    reverseDuration: Duration(milliseconds: 420),
                                    duration: Duration(milliseconds: 420),
                                    crossFadeState: !isSignUp ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                    firstCurve: Curves.fastOutSlowIn,
                                    secondCurve: Curves.fastOutSlowIn,
                                    sizeCurve: Curves.fastOutSlowIn,
                                    firstChild: IgnorePointer(
                                      ignoring: !isSignUp,
                                      child: Column(
                                        children: [
                                          _userUI(),
                                          _emailUI(),
                                          _passwordUI(),
                                          _passwordConfirmUI(),
                                          _countryView(),
                                          _getSignUpButtonUI(),
                                          _facebookUI()
                                        ],
                                      )
                                    ),
                                    secondChild: IgnorePointer(
                                      ignoring: isSignUp,
                                      child: Column(
                                        children: <Widget>[
                                          _emailUI(),
                                          _passwordUI(),
                                          _getSignUpButtonUI(),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                        ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _facebookUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: HexColor("#4267B2"),
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of('Connect with facebook'),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: TextField(
                maxLines: 1,
                controller: _emailController,
                onChanged: (String txt) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "name@example.com",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: TextField(
                maxLines: 1,
                controller: _nameController,
                onChanged: (String txt) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "User Name",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: TextField(
                maxLines: 1,
                controller: _passwordController,
                onChanged: (String txt) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordConfirmUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: TextField(
                maxLines: 1,
                controller: _passwordconfirmController,
                onChanged: (String txt) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Password Confirmation",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _countryView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                width: 80,
                height: 60,
                child: Center(
                  child: CountryPickerDropdown(
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    onValuePicked: (Country country) {
                      print("${country.name}");
                      countryCode = "+${country.phoneCode}";
                    },
                    itemBuilder: (Country country) {
                      return Row(
                        children: <Widget>[
                          CountryPickerUtils.getDefaultFlagImage(country),
                          Expanded(child: Text("  +${country.phoneCode}")),
                        ],
                      );
                    },
                    itemHeight: null,
                    isExpanded: true,
                    icon: SizedBox(),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).dividerColor,
              height: 32,
              width: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 16),
                child: Container(
                  height: 48,
                  child: TextField(
                    maxLines: 1,
                    controller: _phoneController,
                    onChanged: (String txt) {
                      phoneNumber = txt.removeZeroInNumber;
                    },
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: new InputDecoration(
                      errorText: null,
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(" Phone Number"),
                      hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSignUpButtonUI() {
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
            onTap:isSignUp? () {
                  // Sign Upppppppppp
              signup();
            }:
            (){
              //sign IN
              // Sign Innnnnnnnnnnn
              signup();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PhoneVerification()),
              // );
            },
            child: Center(
              child: Text(
                isSignUp ? AppLocalizations.of('Sign Up') : AppLocalizations.of('Next'),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getCountryString(String str) {
    var newString = '';
    var isFirstdot = false;
    for (var i = 0; i < str.length; i++) {
      if (isFirstdot == false) {
        if (str[i] != ',') {
          newString = newString + str[i];
        } else {
          isFirstdot = true;
        }
      }
    }
    return newString;
  }

  signup() {
    FirebaseMessaging.instance.getToken().then((Dtoken) async {
      final prefs = await SharedPreferences.getInstance();

      await getDeviceDetails();

      String s = _phoneController.text[0] =="0"?"${_phoneController.text.substring(1)}":"${_phoneController.text}";
      String x = "$countryCode$s";
      Map<String, dynamic> body = {
        "device_type": await prefs.getString('deviceType'),
        "device_id": await prefs.getString("identifier"),
        "device_token": Dtoken,
        "login_by": "manual",
        "first_name": _nameController.text,
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
        "dialCodesDigits":countryCode,
        "mobile": "${x}"
      };
      Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneVerification(body: body,)));
  });
}
}
