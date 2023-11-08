class Channel {
  final int id;
  final String name;
  final String channelType;
  final String? image;

  Channel(
      {required this.id,
      required this.name,
      required this.channelType,
      this.image});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        id: json['liveaudio']['id'] as int,
        name: json['name'] as String,
        channelType: json['channeltype'] as String,
        image: json['image'] as String?);
  }
}
