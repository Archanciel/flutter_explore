import 'package:http/http.dart' as http;

// Define the IDs of the playlist and video to remove
const playlistId = 'PLzwWSJNcZTMTB9iwbu77FGokc3WsoxuV0';
const videoId = 'oxXpB9pSETo';
const apiKey = 'AIzaSyDhywmh5EKopsNsaszzMkLJ719aQa2NHBw';

/// not working
Future<void> removeVideoFromPlaylist() async {
  const url =
      'https://www.googleapis.com/youtube/v3/playlistItems?part=id&playlistId=$playlistId&videoId=$videoId&key=$apiKey';
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 204) {
    print(
        'The video with ID "$videoId" has been removed from the playlist with ID "$playlistId".');
  } else {
    print('An error occurred: ${response.reasonPhrase}');
  }
}

Future<void> main() async {
  await removeVideoFromPlaylist();
}
