import 'package:flutter/material.dart';
import '../../exports.dart';

class GBLogin extends StatefulWidget {
  @override
  _GBLoginState createState() => _GBLoginState();
}

class _GBLoginState extends State<GBLogin> {
  GlobalKey<NavigatorState> navKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Provider<SharedFormState>(
          create: (_) => SharedFormState(),
          builder: (_, child) => WillPopScope(
            onWillPop: _handleBackPop,
            child: Navigator(
              key: navKey,
              onGenerateRoute: (route) {
                return StackPagesRoute(
                  previousPages: [],
                  enterPage: SignInForm(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _handleBackPop() async {
    if (navKey.currentState.canPop()) {
      navKey.currentState.pop();
      return false;
    }
    return true;
  }
}

ValueNotifier<String> _email;
ValueNotifier<String> _password;

class SignInForm extends StatelessWidget with FormMixin {
  final double pageSize;
  final bool isHidden;

  SignInForm({Key key, this.pageSize, this.isHidden = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormPage(
      pageSizeProportion: pageSize ?? 0.82,
      isHidden: isHidden,
      title: 'SIGN IN',
      children: [
        SizedBox(height: 10.0),
        TextInput(
          key: ValueKey('email'),
          valueNotifier: _email,
          onValidate: onItemValidate,
          label: 'Hello World',
          onChange: onItemChange,
          isRequired: true,
          helper: 'Email',
          isActive: true,
          type: InputType.email,
          initialValue: '',
        ),
        TextInput(
          key: ValueKey('password'),
          valueNotifier: _password,
          onValidate: onItemValidate,
          label: 'Hello World',
          onChange: onItemChange,
          isRequired: true,
          helper: 'Password',
          isActive: true,
          type: InputType.text,
          initialValue: '',
        ),
        SizedBox(height: 30.0),
        Row(
          children: [
            Expanded(
              child: Text(
                'Forgot password ? ',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: CommonButton(
                iconPlace: true,
                title: 'SIGN IN',
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => TabHome()),
                ),
                icon: R.I.icForward,
              ),
            ),
          ],
        ),
        SizedBox(height: 30.0),
        Row(
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 1.0,
                width: double.infinity,
                decoration: BoxDecoration(color: R.C.kShadowColor1),
              ),
            ),
            SizedBox(width: 20.0),
            Text('OR'),
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 1.0,
                width: double.infinity,
                decoration: BoxDecoration(color: R.C.kShadowColor1),
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 30.0),
        FlatButton(
          onPressed: () {},
          disabledColor: R.C.kInactiveChartColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.blueAccent.shade400,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/facebook.svg',
                  color: Colors.white,
                  height: 30,
                  width: 30.0,
                ),
                SizedBox(width: 20.0),
                Text(
                  'SIGN IN WITH FACEBOOK',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10.0),
            InkWell(
              onTap: () => _handleSubmit(context),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context) {
    Navigator.push(
      context,
      StackPagesRoute(
        previousPages: [SignInForm(pageSize: .85, isHidden: true)],
        enterPage: SignUpForm(),
      ),
    );
  }

  @override
  void onItemChange(String name, String value) {
    // TODO: implement onItemChange
  }

  @override
  void onItemValidate(String name, bool isValid, {String value}) {
    // TODO: implement onItemValidate
  }
}

class SignUpForm extends StatelessWidget with FormMixin {
  final double pageSize;
  final bool isHidden;

  SignUpForm({Key key, this.pageSize, this.isHidden = false}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormPage(
      key: _formKey,
      isHidden: isHidden,
      pageSizeProportion: pageSize ?? .82,
      title: 'SIGN UP',
      children: [
        SizedBox(height: 10.0),
        TextInput(
          key: ValueKey('email'),
          valueNotifier: _email,
          onValidate: onItemValidate,
          label: 'Hello World',
          onChange: onItemChange,
          isRequired: true,
          helper: 'Email',
          isActive: true,
          type: InputType.email,
          initialValue: '',
        ),
        TextInput(
          key: ValueKey('password'),
          valueNotifier: _password,
          onValidate: onItemValidate,
          label: 'Hello World',
          onChange: onItemChange,
          isRequired: true,
          helper: 'Password',
          isActive: true,
          type: InputType.text,
          initialValue: '',
        ),
        TextInput(
          key: ValueKey('rePassword'),
          valueNotifier: _password,
          onValidate: onItemValidate,
          label: 'Hello World',
          onChange: onItemChange,
          isRequired: true,
          helper: 'Retype Password',
          isActive: true,
          type: InputType.text,
          initialValue: '',
        ),
        SizedBox(height: 20.0),
        CommonButton(
          iconPlace: true,
          title: 'SIGN UP',
          onPressed: () => null,
          icon: R.I.icForward,
        ),
        SizedBox(height: 30.0),
        Row(
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 1.0,
                width: double.infinity,
                decoration: BoxDecoration(color: R.C.kShadowColor1),
              ),
            ),
            SizedBox(width: 20.0),
            Text('OR'),
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 1.0,
                width: double.infinity,
                decoration: BoxDecoration(color: R.C.kShadowColor1),
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 30.0),
        FlatButton(
          onPressed: () {},
          disabledColor: R.C.kInactiveChartColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.blueAccent.shade400,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/facebook.svg',
                  color: Colors.white,
                  height: 30,
                  width: 30.0,
                ),
                SizedBox(width: 20.0),
                Text(
                  'SIGN UP WITH FACEBOOK',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Have an account ?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10.0),
            InkWell(
              onTap: () => _handleLogin(context),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void onItemChange(String name, String value) {
    // TODO: implement onItemChange
  }

  @override
  void onItemValidate(String name, bool isValid, {String value}) {
    // TODO: implement onItemValidate
  }

  void _handleLogin(BuildContext context) {
    Navigator.push(
      context,
      StackPagesRoute(
        previousPages: [SignUpForm(pageSize: .85, isHidden: true)],
        enterPage: SignInForm(),
      ),
    );
  }
}

class SharedFormState {
  Map<String, String> valuesByName = {};

  SharedFormState();
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: Scaffold(
        body: Container(
          height: screenSize.height * .25,
          width: screenSize.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bg.jpg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white60,
                BlendMode.screen,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('The'.toUpperCase(), style: Styles.appTitle1),
                  Text('Crypticon', style: Styles.appTitle2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
