import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final Dio _dio = Dio();

Future<File> getOrDownloadMedia(
    String url, {
      required bool isAudio,
    }) async {
  final fileName = p.basename(url);
  final mediaType = isAudio ? 'Audio' : 'Video';
  final cacheType = isAudio ? 'audio' : 'video';

  /// ===============================
  /// 1️⃣ PRIMARY: Android/media (visible)
  /// ===============================
  final extDir = await getExternalStorageDirectory();
  if (extDir != null) {
    final mediaRoot = Directory(
      p.join(
        extDir.parent.parent.parent.parent.path,
        'Android',
        'media',
        'com.example.pabulum',
        'Pabulum',
        'Media',
        mediaType,
      ),
    );

    if (!await mediaRoot.exists()) {
      await mediaRoot.create(recursive: true);
    }

    final mediaFile = File(p.join(mediaRoot.path, fileName));

    /// ✅ Already downloaded
    if (await mediaFile.exists()) {
      return mediaFile;
    }

    try {
      await _dio.download(url, mediaFile.path);
      return mediaFile;
    } catch (e) {
      debugPrint('$mediaType download failed, fallback to cache: $e');
    }
  }

  /// ===============================
  /// 2️⃣ FALLBACK: App cache (offline)
  /// ===============================
  final cacheDir = await getTemporaryDirectory();
  final cacheRoot = Directory(p.join(cacheDir.path, cacheType));

  if (!await cacheRoot.exists()) {
    await cacheRoot.create(recursive: true);
  }

  final cacheFile = File(p.join(cacheRoot.path, fileName));

  /// ✅ Play from cache if available
  if (await cacheFile.exists()) {
    return cacheFile;
  }

  /// ===============================
  /// 3️⃣ LAST RESORT: Download to cache
  /// ===============================
  await _dio.download(url, cacheFile.path);
  return cacheFile;
}

Future<void> clearOldAudio() async {
  final dir = await getApplicationDocumentsDirectory();
  final audioDir = Directory('${dir.path}/audio');

  if (await audioDir.exists()) {
    await audioDir.delete(recursive: true);
  }

  await DefaultCacheManager().emptyCache();
}