

import 'package:syncoplan_project/core/widgets/bottom_nav_bar.dart';
import 'package:syncoplan_project/features/home/screens/home_screen.dart';
import 'package:syncoplan_project/features/user_profile/screens/user_profile_screen.dart';

class Constants {
  static const logoPath = 'lib/assets/logo.png';
  static const loginEmotePath = 'lib/assets/loginEmote.png';
  static const googlePath = 'lib/assets/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://img.freepik.com/free-psd/3d-icon-with-aquatic-animal_23-2150049501.jpg?w=740&t=st=1696756699~exp=1696757299~hmac=c10d5c7f0ff7d3d829510bb5fb8815a747d90a1feb3dde43ca5b528438c1a68b';
  static const avatarGroupDefault =
      'https://img.freepik.com/premium-vector/3d-simple-group-user-icon-isolated_169241-7000.jpg';
  static const avatarUser = 
      'https://img.freepik.com/free-psd/3d-icon-with-aquatic-animal_23-2150049501.jpg?w=740&t=st=1696756699~exp=1696757299~hmac=c10d5c7f0ff7d3d829510bb5fb8815a747d90a1feb3dde43ca5b528438c1a68b';

  static const tabWidgets = [
    HomeScreen(),
    UserProfileScreen(),
    HomeScreen(),
    UserProfileScreen()
  ];

}

