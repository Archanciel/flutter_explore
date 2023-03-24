import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

/// Contains informations of the audio extracted from the video
/// referenced in the enclosing playlist. In fact, the audio is
/// directly downloaded from Youtube.
class Audio {
  static DateFormat downloadDatePrefixFormatter = DateFormat('yyMMdd');
  static DateFormat uploadDateSuffixFormatter = DateFormat('yy-MM-dd');

  // Playlist in which the video is referenced
  Playlist? enclosingPlaylist;

  // Video title displayed on Youtube
  final String originalVideoTitle;

  // Video title which does not contain invalid characters which
  // would cause the audio file name to genertate an file creation
  // exception
  final String validVideoTitle;

  // Url referencing the video from which rhe audio was extracted
  final String videoUrl;

  // Audio download date
  final DateTime audioDownloadDate;

  // Date at which the video containing the audio was added on
  // Youtube
  final DateTime videoUploadDate;

  // Stored audio file name
  final String fileName;

  // Duration of downloaded audio
  final Duration? audioDuration;

  // Audio file size in bytes
  int audioFileSize = 0;

  // Duration in which the audio was downloaded
  late Duration _downloadDuration;
  Duration get downloadDuration => _downloadDuration;
  set downloadDuration(Duration downloadDuration) {
    _downloadDuration = downloadDuration;
    downloadSpeed = (audioFileSize == 0)
        ? 0.0
        : audioFileSize / _downloadDuration.inSeconds;
  }

  // Speed at which the audio was downloaded in bytes per second
  late double downloadSpeed;

  // State of the audio

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    _isPaused = false;
  }

  bool _isPaused = false;
  bool get isPaused => _isPaused;

  // AudioPlayer of the current audio
  late AudioPlayer audioPlayer;

  double playSpeed = 1.25;

  Audio({
    required this.enclosingPlaylist,
    required this.originalVideoTitle,
    required this.videoUrl,
    required this.audioDownloadDate,
    required this.videoUploadDate,
    this.audioDuration,
  })  : validVideoTitle =
            replaceUnauthorizedDirOrFileNameChars(originalVideoTitle),
        fileName =
            '${buildDownloadDatePrefix(audioDownloadDate)}${replaceUnauthorizedDirOrFileNameChars(originalVideoTitle)} ${buildUploadDateSuffix(videoUploadDate)}.mp3';

  Audio.json({
    required this.enclosingPlaylist,
    required this.originalVideoTitle,
    required this.validVideoTitle,
    required this.videoUrl,
    required this.audioDownloadDate,
    required this.videoUploadDate,
    required this.audioDuration,
    required this.fileName,
  });

  // Factory constructor: creates an instance of Audio from a JSON object
  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio.json(
      enclosingPlaylist:
          null, // You'll need to handle this separately, see note below
      originalVideoTitle: json['originalVideoTitle'],
      validVideoTitle: json['validVideoTitle'],
      videoUrl: json['videoUrl'],
      audioDownloadDate: DateTime.parse(json['audioDownloadDate']),
      videoUploadDate: DateTime.parse(json['videoUploadDate']),
      audioDuration: Duration(milliseconds: json['audioDuration']),
      fileName: json['fileName'],
    );
  }

  // Method: converts an instance of Audio to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'originalVideoTitle': originalVideoTitle,
      'validVideoTitle': validVideoTitle,
      'videoUrl': videoUrl,
      'audioDownloadDate': audioDownloadDate.toIso8601String(),
      'videoUploadDate': videoUploadDate.toIso8601String(),
      'audioDuration': audioDuration?.inMilliseconds,
      'fileName': fileName,
    };
  }

  void invertPaused() {
    _isPaused = !_isPaused;
  }

  String get filePathName {
    return '${enclosingPlaylist!.downloadPath}${Platform.pathSeparator}$fileName';
  }

  static String buildDownloadDatePrefix(DateTime downloadDate) {
    String formattedDateStr = downloadDatePrefixFormatter.format(downloadDate);

    return '$formattedDateStr-';
  }

  static String buildUploadDateSuffix(DateTime uploadDate) {
    String formattedDateStr = uploadDateSuffixFormatter.format(uploadDate);

    return formattedDateStr;
  }

  static String replaceUnauthorizedDirOrFileNameChars(String rawFileName) {
    // Replace '|' by ' if '|' is located at end of file name
    if (rawFileName.endsWith('|')) {
      rawFileName = rawFileName.substring(0, rawFileName.length - 1);
    }

    // Replace '||' by '_' since YoutubeDL replaces '||' by '_'
    rawFileName = rawFileName.replaceAll('||', '|');

    // Replace '//' by '_' since YoutubeDL replaces '//' by '_'
    rawFileName = rawFileName.replaceAll('//', '/');

    final charToReplace = {
      '\\': '',
      '/': '_', // since YoutubeDL replaces '/' by '_'
      ':': ' -', // since YoutubeDL replaces ':' by ' -'
      '*': ' ',
      // '.': '', point is not illegal in file name
      '?': '',
      '"': "'", // since YoutubeDL replaces " by '
      '<': '',
      '>': '',
      '|': '_', // since YoutubeDL replaces '|' by '_'
      // "'": '_', apostrophe is not illegal in file name
    };

    // Replace all multiple characters in a string based on translation table created by dictionary
    String validFileName = rawFileName;
    charToReplace.forEach((key, value) {
      validFileName = validFileName.replaceAll(key, value);
    });

    // Since YoutubeDL replaces '?' by ' ', determining if a video whose title
    // ends with '?' has already been downloaded using
    // replaceUnauthorizedDirOrFileNameChars(videoTitle) + '.mp3' can be executed
    // if validFileName.trim() is NOT done.
    return validFileName.trim();
  }
}


/// This class
class Playlist {
  String id = '';
  String title = '';
  String url;
  String downloadPath = '';

  // Contains audio videos currently referrenced in the Youtube
  // playlist.
  final List<Audio> _youtubePlaylistAudioLst = [];
  List<Audio> get youtubePlaylistAudioLst => _youtubePlaylistAudioLst;

  // Contains the audios once referenced in the Youtube playlist
  // which were downloaded.
  final List<Audio> _downloadedAudioLst = [];
  List<Audio> get downloadedAudioLst => _downloadedAudioLst;

  // Contains the downloaded audios currently available on the
  // device.
  final List<Audio> _playableAudioLst = [];
  List<Audio> get playableAudios => _playableAudioLst;

  Playlist({
    required this.url,
  });

  Playlist.json({
    required this.id,
    required this.title,
    required this.url,
    required this.downloadPath,
  });
  // Factory constructor: creates an instance of Playlist from a JSON object
  factory Playlist.fromJson(Map<String, dynamic> json) {
    Playlist playlist = Playlist.json(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      downloadPath: json['downloadPath'],
    );

    // Deserialize the Audio instances in the downloadedAudioLst and playableAudioLst
    if (json['downloadedAudioLst'] != null) {
      for (var audioJson in json['downloadedAudioLst']) {
        Audio audio = Audio.fromJson(audioJson);
        playlist.addDownloadedAudio(audio);
      }
    }

    if (json['playableAudioLst'] != null) {
      for (var audioJson in json['playableAudioLst']) {
        Audio audio = Audio.fromJson(audioJson);
        playlist.addPlayableAudio(audio);
      }
    }

    return playlist;
  }

  // Method: converts an instance of Playlist to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'downloadPath': downloadPath,
      'downloadedAudioLst': _downloadedAudioLst.map((audio) => audio.toJson()).toList(),
      'playableAudioLst': _playableAudioLst.map((audio) => audio.toJson()).toList(),
    };
  }

  void addDownloadedAudio(Audio downloadedAudio) {
    downloadedAudio.enclosingPlaylist = this;
    _downloadedAudioLst.add(downloadedAudio);
  }

  void removeDownloadedAudio(Audio downloadedAudio) {
    if (downloadedAudio.enclosingPlaylist == this) {
      downloadedAudio.enclosingPlaylist = null;
    }
    _downloadedAudioLst.remove(downloadedAudio);
  }

  void addPlayableAudio(Audio playableAudio) {
    playableAudio.enclosingPlaylist = this;
    _playableAudioLst.add(playableAudio);
  }

  void removePlayableAudio(Audio playableAudio) {
    _playableAudioLst.remove(playableAudio);
  }

  @override
  String toString() {
    return title;
  }
}

typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);

class ClassNotContainedInJsonFileException implements Exception {
  String _className;
  String _jsonFilePathName;
  StackTrace _stackTrace;

  ClassNotContainedInJsonFileException({
    required String className,
    required String jsonFilePathName,
    StackTrace? stackTrace,
  })  : _className = className,
        _jsonFilePathName = jsonFilePathName,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className not stored in $_jsonFilePathName file.\nStack Trace:\n$_stackTrace');
  }
}

class ClassNotSupportedByToJsonDataServiceException implements Exception {
  String _className;
  StackTrace _stackTrace;

  ClassNotSupportedByToJsonDataServiceException({
    required String className,
    StackTrace? stackTrace,
  })  : _className = className,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className has no entry in JsonDataService._toJsonFunctionsMap.\nStack Trace:\n$_stackTrace');
  }
}

class ClassNotSupportedByFromJsonDataServiceException implements Exception {
  String _className;
  StackTrace _stackTrace;

  ClassNotSupportedByFromJsonDataServiceException({
    required String className,
    StackTrace? stackTrace,
  })  : _className = className,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className has no entry in JsonDataService._fromJsonFunctionsMap.\nStack Trace:\n$_stackTrace');
  }
}

class JsonDataService {
  // typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
  static final Map<Type, FromJsonFunction> _fromJsonFunctionsMap = {
    Audio: (jsonDataMap) => Audio.fromJson(jsonDataMap),
    Playlist: (jsonDataMap) => Playlist.fromJson(jsonDataMap),
  };

  // typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);
  static final Map<Type, ToJsonFunction> _toJsonFunctionsMap = {
    Audio: (model) => model.toJson(),
    Playlist: (model) => model.toJson(),
  };

  static void saveToFile({
    required dynamic model,
    required String path,
  }) {
    final String jsonStr = encodeJson(model);
    File(path).writeAsStringSync(jsonStr);
  }

  static dynamic loadFromFile({
    required String path,
    required Type type,
  }) {
    final String jsonStr = File(path).readAsStringSync();

    try {
      return decodeJson(jsonStr, type);
    } catch(e) {
      throw ClassNotContainedInJsonFileException(
        className: type.toString(),
        jsonFilePathName: path,
      );
    }
  }

  static String encodeJson(dynamic data) {
    if (data is List) {
      throw Exception(
          "encodeJson() does not support encoding list's. Use encodeJsonList() instead.");
    } else {
      final type = data.runtimeType;
      final toJsonFunction = _toJsonFunctionsMap[type];
      if (toJsonFunction != null) {
        return jsonEncode(toJsonFunction(data));
      }
    }

    return '';
  }

  static dynamic decodeJson(
    String jsonString,
    Type type,
  ) {
    final fromJsonFunction = _fromJsonFunctionsMap[type];

    if (fromJsonFunction != null) {
      final jsonData = jsonDecode(jsonString);
      if (jsonData is List) {
        throw Exception(
            "decodeJson() does not support decoding list's. Use decodeJsonList() instead.");
      } else {
        return fromJsonFunction(jsonData);
      }
    }

    return null;
  }

  static void saveListToFile({
    required dynamic data,
    required String path,
  }) {
    String jsonStr = encodeJsonList(data);
    File(path).writeAsStringSync(jsonStr);
  }

  static List<T> loadListFromFile<T>({
    required String path,
    required Type type,
  }) {
    String jsonStr = File(path).readAsStringSync();

    try {
      return decodeJsonList(jsonStr, type);
    } on StateError {
      throw ClassNotContainedInJsonFileException(
        className: type.toString(),
        jsonFilePathName: path,
      );
    }
  }

  static String encodeJsonList(dynamic data) {
    if (data is List) {
      if (data.isNotEmpty) {
        final type = data.first.runtimeType;
        final toJsonFunction = _toJsonFunctionsMap[type];
        if (toJsonFunction != null) {
          return jsonEncode(data.map((e) => toJsonFunction(e)).toList());
        } else {
          throw ClassNotSupportedByToJsonDataServiceException(
            className: type.toString(),
          );
        }
      }
    } else {
      throw Exception(
          "encodeJsonList() only supports encoding list's. Use encodeJson() instead.");
    }

    return '';
  }

  static List<T> decodeJsonList<T>(
    String jsonString,
    Type type,
  ) {
    final fromJsonFunction = _fromJsonFunctionsMap[type];
    
    if (fromJsonFunction != null) {
      final jsonData = jsonDecode(jsonString);
      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          final list = jsonData.map((e) => fromJsonFunction(e)).toList();
          return list.cast<T>(); // Cast the list to the desired type
        } else {
          return <T>[]; // Return an empty list of the desired type
        }
      } else {
        throw Exception(
            "decodeJsonList() only supports decoding list's. Use decodeJson() instead.");
      }
    } else {
      throw ClassNotSupportedByFromJsonDataServiceException(
        className: type.toString(),
      );
    }
  }

  /// print jsonStr in formatted way
  static void printJsonString({
    required String methodName,
    required String jsonStr,
  }) {
    String prettyJson =
        JsonEncoder.withIndent('  ').convert(json.decode(jsonStr));
    print('$methodName:\n$prettyJson');
  }
}
