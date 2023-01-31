import 'package:knovator/src/view/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderBindings {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  ];
}
