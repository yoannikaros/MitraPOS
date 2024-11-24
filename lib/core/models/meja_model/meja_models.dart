import 'package:flutter/material.dart';

class Meja {
  final int idTable;
  final int profileId;
  final String noTable;
  final Offset posisi;
  final String status;

  Meja({
    required this.idTable,
    required this.profileId,
    required this.noTable,
    required this.posisi,
    required this.status,
  });

  // Fungsi konversi dari Map API
  static Meja fromMap(Map<String, dynamic> map) {
    return Meja(
      idTable: map['id_table'],
      profileId: map['profile_id'],
      noTable: map['no_table'].toString(), // Pastikan tipe String
      posisi: Offset(
        (map['posisiX'] as num).toDouble(),
        (map['posisiY'] as num).toDouble(),
      ),
      status: map['status'],
    );
  }

  // Fungsi konversi ke Map untuk API
  Map<String, dynamic> toMap() {
    return {
      'id_table': idTable,
      'profile_id': profileId,
      'no_table': noTable,
      'posisiX': posisi.dx,
      'posisiY': posisi.dy,
      'status': status,
    };
  }

  // Fungsi copyWith untuk memperbarui properti tertentu
  Meja copyWith({
    int? idTable,
    int? profileId,
    String? noTable,
    Offset? posisi,
    String? status,
  }) {
    return Meja(
      idTable: idTable ?? this.idTable,
      profileId: profileId ?? this.profileId,
      noTable: noTable ?? this.noTable,
      posisi: posisi ?? this.posisi,
      status: status ?? this.status,
    );
  }
}
