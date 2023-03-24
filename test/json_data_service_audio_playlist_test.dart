import 'dart:io';
import 'package:flutter_explore/json_data_service.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('JsonDataService', () {
    test('saveToFile and loadFromFile for one Audio instance', () async {
      // Create a temporary directory to store the serialized Audio object
      Directory tempDir = await Directory.systemTemp.createTemp('AudioTest');
      String filePath = path.join(tempDir.path, 'audio.json');

      // Create an Audio instance
      Audio originalAudio = Audio(
        enclosingPlaylist: null,
        originalVideoTitle: 'Test Video Title',
        videoUrl: 'https://www.youtube.com/watch?v=testVideoID',
        audioDownloadDate: DateTime(2023, 3, 24),
        videoUploadDate: DateTime(2023, 3, 1),
        audioDuration: Duration(minutes: 5, seconds: 30),
      );

      // Save the Audio instance to a file
      JsonDataService.saveToFile(model: originalAudio, path: filePath);

      // Load the Audio instance from the file
      Audio deserializedAudio =
          JsonDataService.loadFromFile(path: filePath, type: Audio);

      // Compare the deserialized Audio instance with the original Audio instance
      expect(deserializedAudio.originalVideoTitle,
          originalAudio.originalVideoTitle);
      expect(deserializedAudio.validVideoTitle, originalAudio.validVideoTitle);
      expect(deserializedAudio.videoUrl, originalAudio.videoUrl);
      expect(deserializedAudio.audioDownloadDate.toIso8601String(),
          originalAudio.audioDownloadDate.toIso8601String());
      expect(deserializedAudio.videoUploadDate.toIso8601String(),
          originalAudio.videoUploadDate.toIso8601String());
      expect(deserializedAudio.audioDuration, originalAudio.audioDuration);
      expect(deserializedAudio.fileName, originalAudio.fileName);

      // Cleanup the temporary directory
      await tempDir.delete(recursive: true);
    });
    test('saveToFile and loadFromFile for one Audio instance with null audioDuration', () async {
      // Create a temporary directory to store the serialized Audio object
      Directory tempDir = await Directory.systemTemp.createTemp('AudioTest');
      String filePath = path.join(tempDir.path, 'audio.json');

      // Create an Audio instance
      Audio originalAudio = Audio(
        enclosingPlaylist: null,
        originalVideoTitle: 'Test Video Title',
        videoUrl: 'https://www.youtube.com/watch?v=testVideoID',
        audioDownloadDate: DateTime(2023, 3, 24),
        videoUploadDate: DateTime(2023, 3, 1),
      );

      // Save the Audio instance to a file
      JsonDataService.saveToFile(model: originalAudio, path: filePath);

      // Load the Audio instance from the file
      Audio deserializedAudio =
          JsonDataService.loadFromFile(path: filePath, type: Audio);

      // Compare the deserialized Audio instance with the original Audio instance
      expect(deserializedAudio.originalVideoTitle,
          originalAudio.originalVideoTitle);
      expect(deserializedAudio.validVideoTitle, originalAudio.validVideoTitle);
      expect(deserializedAudio.videoUrl, originalAudio.videoUrl);
      expect(deserializedAudio.audioDownloadDate.toIso8601String(),
          originalAudio.audioDownloadDate.toIso8601String());
      expect(deserializedAudio.videoUploadDate.toIso8601String(),
          originalAudio.videoUploadDate.toIso8601String());
      expect(deserializedAudio.audioDuration, Duration(milliseconds: 0));
      expect(deserializedAudio.fileName, originalAudio.fileName);

      // Cleanup the temporary directory
      await tempDir.delete(recursive: true);
    });
    test('saveToFile and loadFromFile for one new Audio instance', () async {
      // Create a temporary directory to store the serialized Audio object
      Directory tempDir = await Directory.systemTemp.createTemp('AudioTest');
      String filePath = path.join(tempDir.path, 'audio.json');
      // Create a Playlist with 2 Audio instances
      Playlist testPlaylist = Playlist(
        url: 'https://www.example.com/playlist-url',
      );

      testPlaylist.title = 'Test Playlist';
      testPlaylist.downloadPath = 'path/to/downloads';

      Audio audio1 = Audio(
        enclosingPlaylist: testPlaylist,
        originalVideoTitle: 'Test Video 1',
        videoUrl: 'https://www.example.com/video-url-1',
        audioDownloadDate: DateTime.now(),
        videoUploadDate: DateTime.now().subtract(Duration(days: 10)),
      );

      Audio audio2 = Audio(
        enclosingPlaylist: testPlaylist,
        originalVideoTitle: 'Test Video 2',
        videoUrl: 'https://www.example.com/video-url-2',
        audioDownloadDate: DateTime.now(),
        videoUploadDate: DateTime.now().subtract(Duration(days: 5)),
        audioDuration: Duration(minutes: 5, seconds: 30),
      );

      testPlaylist.addDownloadedAudio(audio1);
      testPlaylist.addDownloadedAudio(audio2);

      // Save Playlist to a file
      JsonDataService.saveToFile(model: testPlaylist, path: filePath);

      // Load Playlist from the file
      Playlist loadedPlaylist =
          JsonDataService.loadFromFile(path: filePath, type: Playlist);

      // Compare original and loaded Playlist
      expect(loadedPlaylist.title, testPlaylist.title);
      expect(loadedPlaylist.downloadPath, testPlaylist.downloadPath);
      expect(loadedPlaylist.url, testPlaylist.url);

      // Compare Audio instances in original and loaded Playlist
      expect(loadedPlaylist.downloadedAudioLst.length, 2);

      for (int i = 0; i < loadedPlaylist.downloadedAudioLst.length; i++) {
        Audio originalAudio = testPlaylist.downloadedAudioLst[i];
        Audio loadedAudio = loadedPlaylist.downloadedAudioLst[i];

        expect(
            loadedAudio.originalVideoTitle, originalAudio.originalVideoTitle);
        expect(loadedAudio.videoUrl, originalAudio.videoUrl);
        expect(loadedAudio.audioDownloadDate, originalAudio.audioDownloadDate);
        expect(loadedAudio.videoUploadDate, originalAudio.videoUploadDate);
        expect(loadedAudio.fileName, originalAudio.fileName);
        if (i == 1) {
          expect(loadedAudio.audioDuration, Duration(minutes: 5, seconds: 30));
        }
      }

      // Cleanup the temporary directory
      await tempDir.delete(recursive: true);
    });
  });
}
