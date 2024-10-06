import "package:e_commerce/config/path_export.dart";
import "package:e_commerce/utilities/bloc/cart_product_list/cart_product_list_bloc.dart";



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var container = Containers();
  await container.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductListBloc(),
        ),
        BlocProvider(
          create: (context) => AddCartBloc(),
        ),
        BlocProvider(
          create: (context) => CartProductListBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Color(0xFF5D4037)
            ),
            color: Color(0xFFFFFFFF),
            titleTextStyle: TextStyle(color: Color(0xFF5D4037),fontSize: 20,fontWeight: FontWeight.bold)
          ),
          scaffoldBackgroundColor:const Color(0xFFEFEBE9)
        ),
        initialRoute: PageRoutes().defaultRoute(),
        routes: PageRoutes().routes(),
      ),
    );
  }
}
