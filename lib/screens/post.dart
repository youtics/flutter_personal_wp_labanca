import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:transparent_image/transparent_image.dart';

class DetallePost extends StatelessWidget {
  const DetallePost({Key? key}) : super(key: key);

  static const routeName = 'detalle';

  @override
  Widget build(BuildContext context) {
    Map post = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title']['rendered']),
      ),
      body: ListView(
        children: <Widget>[
          new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post["featured_media"] != 0
                  ? post["_embedded"]["wp:featuredmedia"][0]["source_url"]
                  : "https://labancaria.obliviondev.com.ar/wp-content/uploads/2022/02/GRIS-SUAVE.png"),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              post['title']['rendered'],
              style: TextStyle(fontSize: 24),
            ),
          ),
          HtmlWidget(post['content']['rendered']),
        ],
      ),
    );
  }
}
