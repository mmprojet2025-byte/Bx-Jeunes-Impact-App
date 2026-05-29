import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';

enum PartnerLevel { bronze, silver, gold, platinum }

extension PartnerLevelExt on PartnerLevel {
  String get label => switch (this) {
        PartnerLevel.bronze => 'Bronze',
        PartnerLevel.silver => 'Argent',
        PartnerLevel.gold => 'Or',
        PartnerLevel.platinum => 'Platine',
      };
  Color get color => switch (this) {
        PartnerLevel.bronze => const Color(0xFFCD7F32),
        PartnerLevel.silver => const Color(0xFFA8A9AD),
        PartnerLevel.gold => const Color(0xFFFFD700),
        PartnerLevel.platinum => const Color(0xFFE5E4E2),
      };
}

class Partner {
  final int id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? websiteUrl;
  final PartnerLevel level;
  final bool active;

  const Partner({
    required this.id,
    required this.name,
    required this.level,
    this.description,
    this.logoUrl,
    this.websiteUrl,
    this.active = true,
  });

  factory Partner.fromJson(Map<String, dynamic> j) => Partner(
        id: j['id'] as int,
        name: j['name'] as String,
        description: j['description'] as String?,
        logoUrl: j['logoUrl'] as String?,
        websiteUrl: j['websiteUrl'] as String?,
        level: PartnerLevel.values.firstWhere(
            (l) => l.name.toUpperCase() == (j['level'] as String).toUpperCase(),
            orElse: () => PartnerLevel.bronze,),
        active: j['active'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'logoUrl': logoUrl,
        'websiteUrl': websiteUrl,
        'level': level.name.toUpperCase(),
        'active': active,
      };
}

class PartnerRepository {
  final ApiService _api;
  PartnerRepository(this._api);

  Future<List<Partner>> fetchAll() =>
      _api.get<List<Partner>>(AppConfig.partnersEndpoint,
          fromJson: (j) => (j as List)
              .map((e) => Partner.fromJson(e as Map<String, dynamic>))
              .toList(),);

  Future<Partner> create(Map<String, dynamic> data) =>
      _api.post<Partner>(AppConfig.partnersEndpoint,
          body: data,
          fromJson: (j) => Partner.fromJson(j as Map<String, dynamic>),);

  Future<Partner> update(int id, Map<String, dynamic> data) =>
      _api.put<Partner>('${AppConfig.partnersEndpoint}/$id',
          body: data,
          fromJson: (j) => Partner.fromJson(j as Map<String, dynamic>),);

  Future<void> delete(int id) =>
      _api.delete('${AppConfig.partnersEndpoint}/$id');
}

final partnerRepositoryProvider = Provider<PartnerRepository>(
    (ref) => PartnerRepository(ref.read(apiServiceProvider)),);
