/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'match_team_side.dart' as _i2;
import 'player_position.dart' as _i3;

abstract class MatchParticipant
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  MatchParticipant._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    required this.teamSide,
    this.position,
  });

  factory MatchParticipant({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required _i2.MatchTeamSide teamSide,
    _i3.PlayerPosition? position,
  }) = _MatchParticipantImpl;

  factory MatchParticipant.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchParticipant(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      teamSide:
          _i2.MatchTeamSide.fromJson((jsonSerialization['teamSide'] as int)),
      position: jsonSerialization['position'] == null
          ? null
          : _i3.PlayerPosition.fromJson((jsonSerialization['position'] as int)),
    );
  }

  static final t = MatchParticipantTable();

  static const db = MatchParticipantRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue clubMemberId;

  _i2.MatchTeamSide teamSide;

  _i3.PlayerPosition? position;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchParticipant copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    _i2.MatchTeamSide? teamSide,
    _i3.PlayerPosition? position,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'teamSide': teamSide.toJson(),
      if (position != null) 'position': position?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'teamSide': teamSide.toJson(),
      if (position != null) 'position': position?.toJson(),
    };
  }

  static MatchParticipantInclude include() {
    return MatchParticipantInclude._();
  }

  static MatchParticipantIncludeList includeList({
    _i1.WhereExpressionBuilder<MatchParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchParticipantTable>? orderByList,
    MatchParticipantInclude? include,
  }) {
    return MatchParticipantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MatchParticipant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MatchParticipant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchParticipantImpl extends MatchParticipant {
  _MatchParticipantImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required _i2.MatchTeamSide teamSide,
    _i3.PlayerPosition? position,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          teamSide: teamSide,
          position: position,
        );

  /// Returns a shallow copy of this [MatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchParticipant copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    _i2.MatchTeamSide? teamSide,
    Object? position = _Undefined,
  }) {
    return MatchParticipant(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      teamSide: teamSide ?? this.teamSide,
      position: position is _i3.PlayerPosition? ? position : this.position,
    );
  }
}

class MatchParticipantTable extends _i1.Table<_i1.UuidValue?> {
  MatchParticipantTable({super.tableRelation})
      : super(tableName: 'match_participants') {
    matchId = _i1.ColumnUuid(
      'matchId',
      this,
    );
    clubMemberId = _i1.ColumnUuid(
      'clubMemberId',
      this,
    );
    teamSide = _i1.ColumnEnum(
      'teamSide',
      this,
      _i1.EnumSerialization.byIndex,
    );
    position = _i1.ColumnEnum(
      'position',
      this,
      _i1.EnumSerialization.byIndex,
    );
  }

  late final _i1.ColumnUuid matchId;

  late final _i1.ColumnUuid clubMemberId;

  late final _i1.ColumnEnum<_i2.MatchTeamSide> teamSide;

  late final _i1.ColumnEnum<_i3.PlayerPosition> position;

  @override
  List<_i1.Column> get columns => [
        id,
        matchId,
        clubMemberId,
        teamSide,
        position,
      ];
}

class MatchParticipantInclude extends _i1.IncludeObject {
  MatchParticipantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchParticipant.t;
}

class MatchParticipantIncludeList extends _i1.IncludeList {
  MatchParticipantIncludeList._({
    _i1.WhereExpressionBuilder<MatchParticipantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MatchParticipant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchParticipant.t;
}

class MatchParticipantRepository {
  const MatchParticipantRepository._();

  /// Returns a list of [MatchParticipant]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<MatchParticipant>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchParticipantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MatchParticipant>(
      where: where?.call(MatchParticipant.t),
      orderBy: orderBy?.call(MatchParticipant.t),
      orderByList: orderByList?.call(MatchParticipant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MatchParticipant] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<MatchParticipant?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchParticipantTable>? where,
    int? offset,
    _i1.OrderByBuilder<MatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchParticipantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MatchParticipant>(
      where: where?.call(MatchParticipant.t),
      orderBy: orderBy?.call(MatchParticipant.t),
      orderByList: orderByList?.call(MatchParticipant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MatchParticipant] by its [id] or null if no such row exists.
  Future<MatchParticipant?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MatchParticipant>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MatchParticipant]s in the list and returns the inserted rows.
  ///
  /// The returned [MatchParticipant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MatchParticipant>> insert(
    _i1.Session session,
    List<MatchParticipant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MatchParticipant>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MatchParticipant] and returns the inserted row.
  ///
  /// The returned [MatchParticipant] will have its `id` field set.
  Future<MatchParticipant> insertRow(
    _i1.Session session,
    MatchParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MatchParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MatchParticipant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MatchParticipant>> update(
    _i1.Session session,
    List<MatchParticipant> rows, {
    _i1.ColumnSelections<MatchParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MatchParticipant>(
      rows,
      columns: columns?.call(MatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MatchParticipant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MatchParticipant> updateRow(
    _i1.Session session,
    MatchParticipant row, {
    _i1.ColumnSelections<MatchParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MatchParticipant>(
      row,
      columns: columns?.call(MatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MatchParticipant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MatchParticipant>> delete(
    _i1.Session session,
    List<MatchParticipant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MatchParticipant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MatchParticipant].
  Future<MatchParticipant> deleteRow(
    _i1.Session session,
    MatchParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MatchParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MatchParticipant>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MatchParticipantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MatchParticipant>(
      where: where(MatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchParticipantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MatchParticipant>(
      where: where?.call(MatchParticipant.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
