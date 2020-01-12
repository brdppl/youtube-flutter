class Video {
  String id;
  String title;
  String description;
  String img;
  String channel;

  Video({this.id, this.title, this.description, this.img, this.channel});

  factory Video.toMap(Map<String, dynamic> map){
    return Video(
      id: map['id']['videoId'],
      title: map['snippet']['title'],
      description: map['snippet']['description'],
      img: map['snippet']['thumbnails']['high']['url'],
      channel: map['snippet']['channelTitle']
    );
  }
}