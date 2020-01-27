import 'package:flutter/material.dart';
import 'package:youtube_clone/api.dart';
import 'package:youtube_clone/models/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {

  String search;
  Inicio(this.search);
  
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listVideos(String search) {
    Api api = Api();
    return api.pesquisar(search);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listVideos(widget.search),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if(snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {

                  List<Video> videos = snapshot.data;
                  Video video = videos[index];

                  return GestureDetector(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_YOUTUBE_KEY,
                        videoId: video.id,
                        autoPlay: true,
                        fullScreen: true
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(video.img),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        ListTile(
                          title: Text(video.title),
                          subtitle: Text(video.channel),
                        )
                      ],
                    )
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 2,
                    color: Colors.grey,
                  );
                },
                itemCount: snapshot.data.length
              );
            } else {
              return Center(
                child: Text('Não foi encontrado nenhum vídeo.'),
              );
            }
            break;
        }
      },
    );
  }
}