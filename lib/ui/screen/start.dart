import 'package:cooker/bloc/category/category_bloc.dart';
import 'package:cooker/bloc/category/category_event.dart';
import 'package:cooker/bloc/category/category_state.dart';
import 'package:cooker/di/injector.dart';
import 'package:cooker/service/api_service.dart';
import 'package:cooker/ui/screen/food_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StartScreen extends StatefulWidget {
  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    Di.setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryWidget();
  }
}

class CategoryWidget extends StatefulWidget {
  @override
  CategoryWidgetState createState() => CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(FlutterI18n.translate(
            context,
            'toolbar.title',
          )),
          trailingActions: <Widget>[
            PlatformIconButton(
              padding: EdgeInsets.zero,
              icon: Icon(context.platformIcons.share),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => KiwiContainer().resolve<CategoryBloc>(),
          child: CategoryScreen(),
        ));
  }
}

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryEvent.start);
  }

  @override
  Widget build(BuildContext context) {
    return getBlocBuilder();
  }

  Widget getBlocBuilder() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CategoryStateLoading:
            return buildListLoader();
            break;
          case CategoryStateData:
            return gridHeader((state as CategoryStateData).categories);
            break;
          case CategoryStateError:
            return buildError(
                context,
                FlutterErrorDetails(
                    exception: (state as CategoryStateError).error));
            break;
        }
        return buildListLoader();
      },
    );
  }

  Widget buildError(BuildContext context, FlutterErrorDetails error) {
    return Scaffold(
      body: Center(
        child: Text(
          "Error appeared.",
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  Widget buildListLoader() {
    return Center(child: new CircularProgressIndicator());
  }

  Widget gridHeader(List<Category> categories) {
    return new ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return new StickyHeader(
          header: new Container(
            height: 38.0,
            color: Colors.white,
            padding: new EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              categories[index].name,
              style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories[index].items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (contxt, indx) {
                final item = categories[index].items[indx];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodDetailsScreen(item)),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 6.0, bottom: 2.0),
                        child: Center(
                            child: Text(
                          item.name,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        )),
                      ),
                    ));
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
