// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<SampleFeature> {
  @override
  final int typeId = 0;

  @override
  SampleFeature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SampleFeature(
      id: fields[0] as int,
      username: fields[2] as String,
      name: fields[1] as String?,
      location: fields[3] as String?,
      company: fields[4] as String?,
      gitUrl: fields[5] as String?,
      bio: fields[6] as String?,
      avatarUrl: fields[7] as String?,
      repository: fields[8] as int?,
      followers: fields[9] as int?,
      following: fields[10] as int?,
      repositoryList: (fields[11] as List?)?.cast<Repo>(),
      followersList: (fields[12] as List?)?.cast<SampleFeature>(),
      followingList: (fields[13] as List?)?.cast<SampleFeature>(),
    );
  }

  @override
  void write(BinaryWriter writer, SampleFeature obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.company)
      ..writeByte(5)
      ..write(obj.gitUrl)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.avatarUrl)
      ..writeByte(8)
      ..write(obj.repository)
      ..writeByte(9)
      ..write(obj.followers)
      ..writeByte(10)
      ..write(obj.following)
      ..writeByte(11)
      ..write(obj.repositoryList)
      ..writeByte(12)
      ..write(obj.followersList)
      ..writeByte(13)
      ..write(obj.followingList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
