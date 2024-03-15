class Joke {
  String id;
  String data;
  String jokeBody;

  Joke({required this.id, required this.data, required this.jokeBody});

  factory Joke.FromJson(Map<String, dynamic> json) {
    return Joke(id: json['id'], data: json['created_at'], jokeBody: json['value']);
  }

  factory Joke.FromMap(Map<String, dynamic> json) {
    return Joke(id: json['id'], data: json['created_at'], jokeBody: json['value']);
  }

  @override
  String toString() {
    return '\nid: $id,\ndata: $data,\njokeBody: $jokeBody';
  }
}