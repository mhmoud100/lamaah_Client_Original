import 'package:flutter/material.dart';
import 'package:my_cab/Language/appLocalizations.dart';
import 'package:my_cab/constance/constance.dart';
import 'package:my_cab/constance/themes.dart';

class TipsScreen extends StatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(right: 14, left: 14),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top + 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AppLocalizations.of('Tips'),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                SizedBox(),
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Gregory Smith'),
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          AppLocalizations.of('652-UKW'),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppLocalizations.of('Wow! A 5 Star !\nWanna add tip for Gregory?'),
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Theme.of(context).dividerColor,
                              child: Text(
                                AppLocalizations.of('\$1'),
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: HexColor("#4252FF"),
                              child: Text(
                                AppLocalizations.of('\$2'),
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Theme.of(context).dividerColor,
                              child: Text(
                                AppLocalizations.of('\$5'),
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          AppLocalizations.of('Choose other amount'),
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Colors.red,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, right: 8, left: 8),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: HexColor("#4252FF"),
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
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of('Done'),
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of('Maybe next time'),
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 420),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      color: Theme.of(context).cardColor,
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          ConstanceData.userImage,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
