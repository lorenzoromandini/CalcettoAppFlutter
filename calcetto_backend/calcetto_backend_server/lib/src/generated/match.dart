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
import 'match_mode.dart' as _i2;
import 'match_status.dart' as _i3;

abstract class Match
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Match._({
    this.id,
    required this.clubId,
    required this.scheduledAt,
    this.location,
    required this.mode,
    required this.status,
    required this.homeScore,
    required this.awayScore,
    this.notes,
    this.createdBy,
    this.scoreFinalizedBy,
    this.ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Match({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required DateTime scheduledAt,
    String? location,
    required _i2.MatchMode mode,
    required _i3.MatchStatus status,
    required int homeScore,
    required int awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MatchImpl;

  factory Match.fromJson(Map<String, dynamic> jsonSerialization) {
    return Match(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      clubId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['clubId']),
      scheduledAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['scheduledAt']),
      location: jsonSerialization['location'] as String?,
      mode: _i2.MatchMode.fromJson((jsonSerialization['mode'] as int)),
      status: _i3.MatchStatus.fromJson((jsonSerialization['status'] as int)),
      homeScore: jsonSerialization['homeScore'] as int,
      awayScore: jsonSerialization['awayScore'] as int,
      notes: jsonSerialization['notes'] as String?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['createdBy']),
      scoreFinalizedBy: jsonSerialization['scoreFinalizedBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['scoreFinalizedBy']),
      ratingsCompletedBy: jsonSerialization['ratingsCompletedBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['ratingsCompletedBy']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MatchTable();

  static const db = MatchRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue clubId;

  DateTime scheduledAt;

  String? location;

  _i2.MatchMode mode;

  _i3.MatchStatus status;

  int homeScore;

  int awayScore;

  String? notes;

  _i1.UuidValue? createdBy;

  _i1.UuidValue? scoreFinalizedBy;

  _i1.UuidValue? ratingsCompletedBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Match]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Match copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? clubId,
    DateTime? scheduledAt,
    String? location,
    _i2.MatchMode? mode,
    _i3.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      'scheduledAt': scheduledAt.toJson(),
      if (location != null) 'location': location,
      'mode': mode.toJson(),
      'status': status.toJson(),
      'homeScore': homeScore,
      'awayScore': awayScore,
      if (notes != null) 'notes': notes,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      if (scoreFinalizedBy != null)
        'scoreFinalizedBy': scoreFinalizedBy?.toJson(),
      if (ratingsCompletedBy != null)
        'ratingsCompletedBy': ratingsCompletedBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      'scheduledAt': scheduledAt.toJson(),
      if (location != null) 'location': location,
      'mode': mode.toJson(),
      'status': status.toJson(),
      'homeScore': homeScore,
      'awayScore': awayScore,
      if (notes != null) 'notes': notes,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      if (scoreFinalizedBy != null)
        'scoreFinalizedBy': scoreFinalizedBy?.toJson(),
      if (ratingsCompletedBy != null)
        'ratingsCompletedBy': ratingsCompletedBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MatchInclude include() {
    return MatchInclude._();
  }

  static MatchIncludeList includeList({
    _i1.WhereExpressionBuilder<MatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchTable>? orderByList,
    MatchInclude? include,
  }) {
    return MatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Match.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Match.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchImpl extends Match {
  _MatchImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required DateTime scheduledAt,
    String? location,
    required _i2.MatchMode mode,
    required _i3.MatchStatus status,
    required int homeScore,
    required int awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          clubId: clubId,
          scheduledAt: scheduledAt,
          location: location,
          mode: mode,
          status: status,
          homeScore: homeScore,
          awayScore: awayScore,
          notes: notes,
          createdBy: createdBy,
          scoreFinalizedBy: scoreFinalizedBy,
          ratingsCompletedBy: ratingsCompletedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Match]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Match copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? clubId,
    DateTime? scheduledAt,
    Object? location = _Undefined,
    _i2.MatchMode? mode,
    _i3.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    Object? notes = _Undefined,
    Object? createdBy = _Undefined,
    Object? scoreFinalizedBy = _Undefined,
    Object? ratingsCompletedBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Match(
      id: id is _i1.UuidValue? ? id : this.id,
      clubId: clubId ?? this.clubId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      location: location is String? ? location : this.location,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      notes: notes is String? ? notes : this.notes,
      createdBy: createdBy is _i1.UuidValue? ? createdBy : this.createdBy,
      scoreFinalizedBy: scoreFinalizedBy is _i1.UuidValue?
          ? scoreFinalizedBy
          : this.scoreFinalizedBy,
      ratingsCompletedBy: ratingsCompletedBy is _i1.UuidValue?
          ? ratingsCompletedBy
          : this.ratingsCompletedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MatchTable extends _i1.Table<_i1.UuidValue?> {
  MatchTable({super.tableRelation}) : super(tableName: 'matches') {
    clubId = _i1.ColumnUuid(
      'clubId',
      this,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    mode = _i1.ColumnEnum(
      'mode',
      this,
      _i1.EnumSerialization.byIndex,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    homeScore = _i1.ColumnInt(
      'homeScore',
      this,
    );
    awayScore = _i1.ColumnInt(
      'awayScore',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdBy = _i1.ColumnUuid(
      'createdBy',
      this,
    );
    scoreFinalizedBy = _i1.ColumnUuid(
      'scoreFinalizedBy',
      this,
    );
    ratingsCompletedBy = _i1.ColumnUuid(
      'ratingsCompletedBy',
      this,
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

  late final _i1.ColumnUuid clubId;

  late final _i1.ColumnDateTime scheduledAt;

  late final _i1.ColumnString location;

  late final _i1.ColumnEnum<_i2.MatchMode> mode;

  late final _i1.ColumnEnum<_i3.MatchStatus> status;

  late final _i1.ColumnInt homeScore;

  late final _i1.ColumnInt awayScore;

  late final _i1.ColumnString notes;

  late final _i1.ColumnUuid createdBy;

  late final _i1.ColumnUuid scoreFinalizedBy;

  late final _i1.ColumnUuid ratingsCompletedBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        clubId,
        scheduledAt,
        location,
        mode,
        status,
        homeScore,
        awayScore,
        notes,
        createdBy,
        scoreFinalizedBy,
        ratingsCompletedBy,
        createdAt,
        updatedAt,
      ];
}

class MatchInclude extends _i1.IncludeObject {
  MatchInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Match.t;
}

class MatchIncludeList extends _i1.IncludeList {
  MatchIncludeList._({
    _i1.WhereExpressionBuilder<MatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Match.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Match.t;
}

class MatchRepository {
  const MatchRepository._();

  /// Returns a list of [Match]s matching the given query parameters.
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
  Future<List<Match>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Match>(
      where: where?.call(Match.t),
      orderBy: orderBy?.call(Match.t),
      orderByList: orderByList?.call(Match.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Match] matching the given query parameters.
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
  Future<Match?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchTable>? where,
    int? offset,
    _i1.OrderByBuilder<MatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Match>(
      where: where?.call(Match.t),
      orderBy: orderBy?.call(Match.t),
      orderByList: orderByList?.call(Match.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Match] by its [id] or null if no such row exists.
  Future<Match?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Match>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Match]s in the list and returns the inserted rows.
  ///
  /// The returned [Match]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Match>> insert(
    _i1.Session session,
    List<Match> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Match>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Match] and returns the inserted row.
  ///
  /// The returned [Match] will have its `id` field set.
  Future<Match> insertRow(
    _i1.Session session,
    Match row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Match>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Match]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Match>> update(
    _i1.Session session,
    List<Match> rows, {
    _i1.ColumnSelections<MatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Match>(
      rows,
      columns: columns?.call(Match.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Match]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Match> updateRow(
    _i1.Session session,
    Match row, {
    _i1.ColumnSelections<MatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Match>(
      row,
      columns: columns?.call(Match.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Match]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Match>> delete(
    _i1.Session session,
    List<Match> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Match>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Match].
  Future<Match> deleteRow(
    _i1.Session session,
    Match row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Match>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Match>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MatchTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Match>(
      where: where(Match.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Match>(
      where: where?.call(Match.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
