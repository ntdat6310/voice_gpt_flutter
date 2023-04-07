// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 2;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      content: fields[1] as String,
      senderType: fields[2] as SenderType,
      createAt: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.createAt)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.senderType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SenderTypeAdapter extends TypeAdapter<SenderType> {
  @override
  final int typeId = 1;

  @override
  SenderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SenderType.user;
      case 1:
        return SenderType.bot;
      default:
        return SenderType.user;
    }
  }

  @override
  void write(BinaryWriter writer, SenderType obj) {
    switch (obj) {
      case SenderType.user:
        writer.writeByte(0);
        break;
      case SenderType.bot:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SenderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
