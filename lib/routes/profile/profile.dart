import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class GBProfile extends StatefulWidget {
  @override
  _GBProfileState createState() => _GBProfileState();
}

class _GBProfileState extends State<GBProfile> {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            BoxPanel(
              margin: EdgeInsets.symmetric(
                horizontal: 15.0,
              ).copyWith(bottom: 5.0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ).copyWith(
                  top: 0.0,
                  left: 5.0,
                  right: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Profile Section
                    Container(
                      height: AppTheme.viewportHeight(context) * 0.22,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Container(),
                          //Name Field and Email
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: BoxPanel(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              color: Theme.of(context).colorScheme.onBackground,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09),
                                  Text(
                                    'Timothy Brown',
                                    style: tt.headline4.copyWith(
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  Text(
                                    'Boxerbuzz559@gmail.com',
                                    style: tt.headline5.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                          //Image space
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    Helpers.getAvatar('boxerbuzz559@gmail.com'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //KYC Section
                    BoxPanel(
                      color: Theme.of(context).colorScheme.onBackground,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'To access more features and higher limit\'s.',
                                  style: tt.headline4,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/right_arrow.svg',
                                color: AppTheme.getColor(context),
                                height: 24.0,
                                width: 24.0,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 5.0,
                              ),
                              child: Text(
                                'Complete your KYC',
                                style: tt.headline5.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            ProfileItem(
              image: R.I.icUser,
              title: 'Edit Profile',
              color: R.C.kPrimaryColor,
              subTitle: 'Edit your personal information',
              onTap: () {},
            ),
            ProfileItem(
              image: R.I.icNotification,
              title: 'Notifications',
              color: Colors.cyan,
              subTitle: 'Change your notification settings',
              onTap: () {},
            ),
            ProfileItem(
              image: R.I.icCard,
              title: 'Card',
              color: Colors.indigo,
              subTitle: 'Manage Cards',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GBCards(),
                ),
              ),
            ),
            ProfileItem(
              image: R.I.icBank,
              title: 'Bank',
              color: R.C.kGreenColor,
              subTitle: 'Bank related settings',
              onTap: () {},
            ),
            ProfileItem(
              image: R.I.icLock,
              title: 'Security',
              color: R.C.kRedColor,
              subTitle: 'Secure your account',
              onTap: () {},
            ),
            ProfileItem(
              image: R.I.icSupport,
              title: 'Support',
              color: Colors.amber,
              subTitle: 'Contact our support team',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GBSupport(),
                ),
              ),
            ),
            ProfileItem(
              image: R.I.icLogOut,
              title: 'Logout',
              color: R.C.kTextMediumColor,
              subTitle: 'Logout from your account',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      title: Row(
        children: <Widget>[
          Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GBSettings(),
                      ),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icSettings,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => GBNotifyScreen())),
                    child: IconWidget(
                      iconPath: R.I.icNotification,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      elevation: 0,
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final String subTitle;
  final onTap;

  ProfileItem({this.title, this.image, this.color, this.subTitle, this.onTap});
  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      color: Theme.of(context).colorScheme.onBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonIconButton(
            icon:
                IconWidget(iconPath: image, padding: 0.0, color: Colors.white),
            btnColor: color,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  subTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    ).ripple(onTap: onTap);
  }
}
