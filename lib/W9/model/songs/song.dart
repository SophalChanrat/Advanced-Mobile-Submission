class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageUrl;
  String artistName;
  String artistGenre;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageUrl,
    this.artistName = '',
    this.artistGenre = '',
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artistId, duration: $duration, imageUrl: $imageUrl)';
  }
}
