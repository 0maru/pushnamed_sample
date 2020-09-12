import 'package:pushnamed_sample/main.dart';
import 'package:pushnamed_sample/router/router.dart';

final router = Router.create({
  '/': (context, _) => Home(),
  '/post/:id': (context, args) => Feed.fromRouteArguments(args.body),
  '/withBody': (context, args) => PageWithBody(body: args.body),
});
