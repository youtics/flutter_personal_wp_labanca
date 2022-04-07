import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:transparent_image/transparent_image.dart';
import 'apis/wordpress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Bancaria MDP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La Bancaria MDP'),
      ),
      body: FutureBuilder(
        future: posteos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var posts = snapshot.data;
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = snapshot.data[index];
                  //print(snapshot.data![index]["_embedded"]["wp:featuredmedia"]
                  //[0]["source_url"]);
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        new FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: posts[index]["featured_media"] != 0
                                ? posts[index]["_embedded"]["wp:featuredmedia"]
                                    [0]["source_url"]
                                : "https://labancaria.obliviondev.com.ar/wp-content/uploads/2022/02/GRIS-SUAVE.png"),
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new ListTile(
                            title: new Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: new Text(
                                    posts[index]["title"]["rendered"])),
                            subtitle: new Text(posts[index]["excerpt"]
                                    ["rendered"]
                                .replaceAll(new RegExp(r'<[^>]*>'), '')),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

/*
  void crearWorpress() {
    wp.WordPress wordPress = new wp.WordPress(
      baseUrl: 'https://labancaria.obliviondev.com.ar/',
      authenticator: wp.WordPressAuthenticator.JWT,
    );
    final response = wordPress.authenticateUser(
        username: 'Gabriel Chaldu', password: 'Pass2022utn%');
    response.then((user) {
      setState(() {});
    }).catchError((err) {
      setState(() {});
    });
  }

  void recuperarPost(wp.WordPress wordPress) {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        perPage: 20,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );
  }*/
