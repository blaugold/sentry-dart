import 'package:meta/meta.dart';

import '../protocol.dart';

/// The Exception Interface specifies an exception or error that occurred in a program.
@immutable
class SentryException {
  /// Required. The type of exception
  final String? type;

  /// Required. The value of the exception
  final String? value;

  /// The optional module, or package which the exception type lives in.
  final String? module;

  /// An optional stack trace object
  final SentryStackTrace? stackTrace;

  /// An optional object describing the [Mechanism] that created this exception
  final Mechanism? mechanism;

  /// Represents a thread id. not available in Dart
  final int? threadId;

  const SentryException({
    required this.type,
    required this.value,
    this.module,
    this.stackTrace,
    this.mechanism,
    this.threadId,
  });

  /// Deserializes a [SentryException] from JSON [Map].
  factory SentryException.fromJson(Map<String, dynamic> json) {
    final stackTraceJson = json['stacktrace'] as Map<String, dynamic>?;
    SentryStackTrace? stackTrace;
    if (stackTraceJson != null) {
      stackTrace = SentryStackTrace.fromJson(stackTraceJson);
    }

    final mechanismJson = json['mechanism'] as Map<String, dynamic>?;
    Mechanism? mechanism;
    if (mechanismJson != null) {
      mechanism = Mechanism.fromJson(mechanismJson);
    }
    return SentryException(
      type: json['type'] as String?,
      value: json['value'] as String?,
      module: json['module'] as String?,
      stackTrace: stackTrace,
      mechanism: mechanism,
      threadId: json['thread_id'] as int?,
    );
  }

  /// Produces a [Map] that can be serialized to JSON.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (type != null) {
      json['type'] = type;
    }

    if (value != null) {
      json['value'] = value;
    }

    if (module != null) {
      json['module'] = module;
    }

    if (stackTrace != null) {
      json['stacktrace'] = stackTrace!.toJson();
    }

    if (mechanism != null) {
      json['mechanism'] = mechanism!.toJson();
    }

    if (threadId != null) {
      json['thread_id'] = threadId;
    }

    return json;
  }

  SentryException copyWith({
    String? type,
    String? value,
    String? module,
    SentryStackTrace? stackTrace,
    Mechanism? mechanism,
    int? threadId,
  }) =>
      SentryException(
        type: type ?? this.type,
        value: value ?? this.value,
        module: module ?? this.module,
        stackTrace: stackTrace ?? this.stackTrace,
        mechanism: mechanism ?? this.mechanism,
        threadId: threadId ?? this.threadId,
      );
}
