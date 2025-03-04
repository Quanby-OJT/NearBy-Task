import 'package:flutter/material.dart';
import 'package:flutter_fe/view/service_acc/service_acc_main_page.dart';
import 'package:flutter_fe/view/sign_up_acc/email_confirmation.dart';
import 'package:flutter_fe/view/business_acc/business_acc_main_page.dart';
import 'package:flutter_fe/view/welcome_page/welcome_page_view_main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final storage = GetStorage();
  final userId = storage.read('user_id');
  final role = storage.read('role');
  runApp(MyApp(isLoggedIn: userId != null, role: role));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? role;

  const MyApp({Key? key, required this.isLoggedIn, this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _getInitialRoute(),
      getPages: [
        GetPage(name: '/welcome', page: () => WelcomePageViewMain()),
        GetPage(name: '/service-home', page: () => ServiceAccMain()),
        GetPage(name: '/client-home', page: () => BusinessAccMain()),
        GetPage(name: '/email-confirmation', page: () => EmailConfirmation())
      ]
    );
  }

  String _getInitialRoute(){
    if(!isLoggedIn) return '/welcome';

    if(role == 'client'){
      return '/client-home';
    }else if(role == 'tasker'){
      return '/service-home';
    }else{
      return '/home';
    }
  }
}
