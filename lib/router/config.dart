import 'package:pushnamed_sample/pages/feed.dart';
import 'package:pushnamed_sample/pages/home.dart';
import 'package:pushnamed_sample/router/router.dart';

final router = Router.create({
  Home.path: (context, _) => Home(),
  Feed.path: (context, args) => Feed.fromRouteArguments(args.body),
});
