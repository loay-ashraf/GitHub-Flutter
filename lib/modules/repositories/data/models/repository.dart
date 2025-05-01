import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
final class Repository {
  Repository({
    required this.name,
    required this.description,
    required this.url,
  });

  final String name;
  final String description;
  @JsonKey(name: 'html_url')
  final String url;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
