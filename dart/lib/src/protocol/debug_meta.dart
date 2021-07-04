import 'package:meta/meta.dart';

import '../protocol.dart';

/// The debug meta interface carries debug information for processing errors and crash reports.
@immutable
class DebugMeta {
  /// An object describing the system SDK.
  final SdkInfo? sdk;

  final List<DebugImage>? _images;

  /// The immutable list of debug images contains all dynamic libraries loaded
  /// into the process and their memory addresses.
  /// Instruction addresses in the Stack Trace are mapped into the list of debug
  /// images in order to retrieve debug files for symbolication.
  List<DebugImage> get images =>
      List.unmodifiable(_images ?? const <DebugImage>[]);

  DebugMeta({this.sdk, List<DebugImage>? images}) : _images = images;

  /// Deserializes a [DebugMeta] from JSON [Map].
  factory DebugMeta.fromJson(Map<String, dynamic> json) {
    final sdkInfoJson = json['sdk_info'] as Map<String, dynamic>?;
    final debugImagesJson = json['images'] as List<dynamic>?;
    return DebugMeta(
      sdk: sdkInfoJson != null ? SdkInfo.fromJson(sdkInfoJson) : null,
      images: debugImagesJson
          ?.map((dynamic debugImageJson) =>
              DebugImage.fromJson(debugImageJson as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Produces a [Map] that can be serialized to JSON.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    final sdkInfo = sdk?.toJson();
    if (sdkInfo?.isNotEmpty ?? false) {
      json['sdk_info'] = sdkInfo;
    }

    if (_images?.isNotEmpty ?? false) {
      json['images'] = _images!
          .map((e) => e.toJson())
          .where((element) => element.isNotEmpty)
          .toList(growable: false);
    }

    return json;
  }

  DebugMeta copyWith({
    SdkInfo? sdk,
    List<DebugImage>? images,
  }) =>
      DebugMeta(
        sdk: sdk ?? this.sdk,
        images: images ?? _images,
      );
}
