import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/store_model.dart';
import 'package:expense_tracker/pages/edit_expense_page.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/pages/new_expense_page.dart';
import 'package:expense_tracker/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = "it_IT";
  await initializeDateFormatting("it_IT", null);
  final database = await DatabaseRepository.newConnection();
  GetIt.instance.registerSingleton(database);
  await storeModel.value.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.route,
        onGenerateRoute: (RouteSettings settings) {
          final pageBuilder = <String, WidgetBuilder>{
            HomePage.route: (_) => const HomePage(),
            NewExpensePage.route: (_) => const NewExpensePage(),
            EditExpensePage.route: (_) => EditExpensePage(
                  settings.arguments as ExpenseModel,
                )
          }[settings.name];
          return MaterialPageRoute(builder: pageBuilder!);
        });
  }
}
