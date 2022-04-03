import 'package:http/http.dart' as http;
import 'dart:convert';

final url = 'http://labancaria2.obliviondev.com.ar/wp-json/wp/v2/posts?_embed';
//final url = 'https://mdp.utn.edu.ar/';

Future<List> posteos() async {
  final response = await http.get(url, headers: {'Accept': 'application/json'});
  var convertiajson = jsonDecode(response.body);
  return convertiajson;
}
