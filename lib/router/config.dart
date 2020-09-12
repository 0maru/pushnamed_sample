import 'package:pushnamed_sample/pages/feed.dart';
import 'package:pushnamed_sample/pages/home.dart';
import 'package:pushnamed_sample/pages/page_with_body.dart';
import 'package:pushnamed_sample/router/router.dart';

final router = Router.create({
  '/': (context, _) => Home(),
  '/feed/123/': (context, args) => Feed.fromRouteArguments(args.body),
  '/feed/:id/': (context, args) => Feed.fromRouteArguments({'key': args['id']}),
  '/withBody': (context, args) => PageWithBody(body: args.body),
});
