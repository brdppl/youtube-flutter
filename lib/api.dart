import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_clone/models/Video.dart';

const API_YOUTUBE_KEY = 'AIzaSyBzyQtltwiSxztx-7uDjmHWGt5raniKaP0';
const CHANNEL_ID = 'UCVHFbqXqoYvEWM1Ddxl0QDg';
const BASE_URL = 'https://www.googleapis.com/youtube/v3';

class Api {

  Future<List<Video>> pesquisar(String search) async {
    http.Response response = await http.get(
      '$BASE_URL/search?part=snippet&type=video&maxResults=20&order=date&key=$API_YOUTUBE_KEY&channelId=$CHANNEL_ID&q=$search'
    );

    if(response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Video> videos = data['items'].map<Video>(
        (map) {
          return Video.toMap(map);
        }
      ).toList();

      return videos;
      
    } else {
      print('erro' + response.body);
    }
  }

}