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

abstract class MatchPlayerStats
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  MatchPlayerStats._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : goalsOpen = goalsOpen ?? 0,
        goalsPenalty = goalsPenalty ?? 0,
        assists = assists ?? 0,
        ownGoals = ownGoals ?? 0,
        penaltiesMissed = penaltiesMissed ?? 0,
        penaltiesSaved = penaltiesSaved ?? 0,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory MatchPlayerStats({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MatchPlayerStatsImpl;

  factory MatchPlayerStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchPlayerStats(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      goalsOpen: jsonSerialization['goalsOpen'] as int,
      goalsPenalty: jsonSerialization['goalsPenalty'] as int,
      assists: jsonSerialization['assists'] as int,
      ownGoals: jsonSerialization['ownGoals'] as int,
      penaltiesMissed: jsonSerialization['penaltiesMissed'] as int,
      penaltiesSaved: jsonSerialization['penaltiesSaved'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MatchPlayerStatsTable();

  static const db = MatchPlayerStatsRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue clubMemberId;

  int goalsOpen;

  int goalsPenalty;

  int assists;

  int ownGoals;

  int penaltiesMissed;

  int penaltiesSaved;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MatchPlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchPlayerStats copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'goalsOpen': goalsOpen,
      'goalsPenalty': goalsPenalty,
      'assists': assists,
      'ownGoals': ownGoals,
      'penaltiesMissed': penaltiesMissed,
      'penaltiesSaved': penaltiesSaved,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'goalsOpen': goalsOpen,
      'goalsPenalty': goalsPenalty,
      'assists': assists,
      'ownGoals': ownGoals,
      'penaltiesMissed': penaltiesMissed,
      'penaltiesSaved': penaltiesSaved,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MatchPlayerStatsInclude include() {
    return MatchPlayerStatsInclude._();
  }

  static MatchPlayerStatsIncludeList includeList({
    _i1.WhereExpressionBuilder<MatchPlayerStatsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchPlayerStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchPlayerStatsTable>? orderByList,
    MatchPlayerStatsInclude? include,
  }) {
    return MatchPlayerStatsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MatchPlayerStats.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MatchPlayerStats.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchPlayerStatsImpl extends MatchPlayerStats {
  _MatchPlayerStatsImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          goalsOpen: goalsOpen,
          goalsPenalty: goalsPenalty,
          assists: assists,
          ownGoals: ownGoals,
          penaltiesMissed: penaltiesMissed,
          penaltiesSaved: penaltiesSaved,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [MatchPlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchPlayerStats copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MatchPlayerStats(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      goalsOpen: goalsOpen ?? this.goalsOpen,
      goalsPenalty: goalsPenalty ?? this.goalsPenalty,
      assists: assists ?? this.assists,
      ownGoals: ownGoals ?? this.ownGoals,
      penaltiesMissed: penaltiesMissed ?? this.penaltiesMissed,
      penaltiesSaved: penaltiesSaved ?? this.penaltiesSaved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MatchPlayerStatsTable extends _i1.Table<_i1.UuidValue?> {
  MatchPlayerStatsTable({super.tableRelation})
      : super(tableName: 'match_player_stats') {
    matchId = _i1.ColumnUuid(
      'matchId',
      this,
    );
    clubMemberId = _i1.ColumnUuid(
      'clubMemberId',
      this,
    );
    goalsOpen = _i1.ColumnInt(
      'goalsOpen',
      this,
      hasDefault: true,
    );
    goalsPenalty = _i1.ColumnInt(
      'goalsPenalty',
      this,
      hasDefault: true,
    );
    assists = _i1.ColumnInt(
      'assists',
      this,
      hasDefault: true,
    );
    ownGoals = _i1.ColumnInt(
      'ownGoals',
      this,
      hasDefault: true,
    );
    penaltiesMissed = _i1.ColumnInt(
      'penaltiesMissed',
      this,
      hasDefault: true,
    );
    penaltiesSaved = _i1.ColumnInt(
      'penaltiesSaved',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnUuid matchId;

  late final _i1.ColumnUuid clubMemberId;

  late final _i1.ColumnInt goalsOpen;

  late final _i1.ColumnInt goalsPenalty;

  late final _i1.ColumnInt assists;

  late final _i1.ColumnInt ownGoals;

  late final _i1.ColumnInt penaltiesMissed;

  late final _i1.ColumnInt penaltiesSaved;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        matchId,
        clubMemberId,
        goalsOpen,
        goalsPenalty,
        assists,
        ownGoals,
        penaltiesMissed,
        penaltiesSaved,
        createdAt,
        updatedAt,
      ];
}

class MatchPlayerStatsInclude extends _i1.IncludeObject {
  MatchPlayerStatsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchPlayerStats.t;
}

class MatchPlayerStatsIncludeList extends _i1.IncludeList {
  MatchPlayerStatsIncludeList._({
    _i1.WhereExpressionBuilder<MatchPlayerStatsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MatchPlayerStats.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchPlayerStats.t;
}

class MatchPlayerStatsRepository {
  const MatchPlayerStatsRepository._();

  /// Returns a list of [MatchPlayerStats]s matching the given query parameters.
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
  Future<List<MatchPlayerStats>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchPlayerStatsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchPlayerStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchPlayerStatsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MatchPlayerStats>(
      where: where?.call(MatchPlayerStats.t),
      orderBy: orderBy?.call(MatchPlayerStats.t),
      orderByList: orderByList?.call(MatchPlayerStats.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MatchPlayerStats] matching the given query parameters.
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
  Future<MatchPlayerStats?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchPlayerStatsTable>? where,
    int? offset,
    _i1.OrderByBuilder<MatchPlayerStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchPlayerStatsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MatchPlayerStats>(
      where: where?.call(MatchPlayerStats.t),
      orderBy: orderBy?.call(MatchPlayerStats.t),
      orderByList: orderByList?.call(MatchPlayerStats.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MatchPlayerStats] by its [id] or null if no such row exists.
  Future<MatchPlayerStats?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MatchPlayerStats>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MatchPlayerStats]s in the list and returns the inserted rows.
  ///
  /// The returned [MatchPlayerStats]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MatchPlayerStats>> insert(
    _i1.Session session,
    List<MatchPlayerStats> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MatchPlayerStats>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MatchPlayerStats] and returns the inserted row.
  ///
  /// The returned [MatchPlayerStats] will have its `id` field set.
  Future<MatchPlayerStats> insertRow(
    _i1.Session session,
    MatchPlayerStats row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MatchPlayerStats>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MatchPlayerStats]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MatchPlayerStats>> update(
    _i1.Session session,
    List<MatchPlayerStats> rows, {
    _i1.ColumnSelections<MatchPlayerStatsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MatchPlayerStats>(
      rows,
      columns: columns?.call(MatchPlayerStats.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MatchPlayerStats]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MatchPlayerStats> updateRow(
    _i1.Session session,
    MatchPlayerStats row, {
    _i1.ColumnSelections<MatchPlayerStatsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MatchPlayerStats>(
      row,
      columns: columns?.call(MatchPlayerStats.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MatchPlayerStats]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MatchPlayerStats>> delete(
    _i1.Session session,
    List<MatchPlayerStats> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MatchPlayerStats>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MatchPlayerStats].
  Future<MatchPlayerStats> deleteRow(
    _i1.Session session,
    MatchPlayerStats row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MatchPlayerStats>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MatchPlayerStats>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MatchPlayerStatsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MatchPlayerStats>(
      where: where(MatchPlayerStats.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchPlayerStatsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MatchPlayerStats>(
      where: where?.call(MatchPlayerStats.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
