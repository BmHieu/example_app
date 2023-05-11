import 'package:equatable/equatable.dart';


class EventItemModel extends Equatable {
  final int? id;
  final String? name;
  final String? thumbnail;
  final DateTime? startTime;
  const EventItemModel({
    this.id,
    this.name,
    this.thumbnail,
    this.startTime,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnail,
        startTime,
      ];

  factory EventItemModel.fromJson(Map<String, dynamic> json) => EventItemModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        thumbnail: json['thumbnail'] as String?,
        startTime: json['start_time'] == null
            ? null
            : DateTime.parse(json['start_time'] as String),
      );
}
