import 'package:free_lottery/application_layer/service/localizetion/translate.dart';
import 'package:free_lottery/presentation_layer/resources/routes_pages.dart';
import 'package:free_lottery/presentation_layer/resources/theme_manager.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      locale: const Locale('en'),
      theme: getApplicationTheme(),
      // home: TestScreen(),
      getPages: getPage,
    );
  }
}
