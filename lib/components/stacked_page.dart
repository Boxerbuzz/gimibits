import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimibits/exports.dart';

class StackPagesRoute extends PageRouteBuilder {
  final Widget enterPage;
  final List<Widget> previousPages;
  StackPagesRoute({this.previousPages, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return Stack(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              fit: StackFit.expand,
              children: <Widget>[
                Header(),
                for (int i = 0; i < previousPages.length; i++)
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(
                        0,
                        ((previousPages.length - i) * -0.05) + 0.05,
                      ),
                      end: Offset(0, (previousPages.length - i) * -0.05),
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        parent: animation,
                      ),
                    ),
                    child: previousPages[i],
                  ),
                SlideTransition(
                  position: new Tween<Offset>(
                    begin: const Offset(0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: enterPage,
                )
              ],
            );
          },
        );
}

class FormPage extends StatelessWidget {
  static Map<String, String> formState = {};

  final List<Widget> children;
  final double pageSizeProportion;
  final GlobalKey<FormState> formKey;
  final String title;
  final bool isHidden;

  const FormPage({
    Key key,
    this.title = '',
    this.formKey,
    this.isHidden = false,
    @required this.pageSizeProportion,
    @required this.children,
  }) : super(key: key);

  // Size screenSize;
  // double bottomPosition;
  // double startPosition;
  // double topListPadding = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var padding = EdgeInsets.symmetric(horizontal: 37.0).copyWith(top: 18.0);
    return Stack(
      children: <Widget>[
        if (!isHidden)
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () => _handleBackGesture(context),
              child: Container(
                width: double.infinity,
                height: screenSize.height * (1 - pageSizeProportion),
                color: Colors.transparent,
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => _handleTap(context),
            child: Container(
              padding: padding,
              width: screenSize.width,
              height: screenSize.height * pageSizeProportion,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getColor(context).withAlpha(11),
                    blurRadius: 8,
                  )
                ],
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      title,
                      style: GoogleFonts.baloo(
                        color: Theme.of(context).colorScheme.primary,
                        height: 1,
                        fontSize: 30,
                        letterSpacing: 0.22,
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _handleTap(BuildContext context) {
    //To improve user experience, we'll shift focus out of any text fields when the users taps oon the background of the form
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  _handleBackGesture(BuildContext context) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }
}
