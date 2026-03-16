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

abstract class PlayerRating
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PlayerRating._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    required this.rating,
    this.comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PlayerRating({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required double rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PlayerRatingImpl;

  factory PlayerRating.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerRating(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      rating: (jsonSerialization['rating'] as num).toDouble(),
      comment: jsonSerialization['comment'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PlayerRatingTable();

  static const db = PlayerRatingRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue clubMemberId;

  double rating;

  String? comment;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerRating copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    double? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'rating': rating,
      if (comment != null) 'comment': comment,
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
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PlayerRatingInclude include() {
    return PlayerRatingInclude._();
  }

  static PlayerRatingIncludeList includeList({
    _i1.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerRatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerRatingTable>? orderByList,
    PlayerRatingInclude? include,
  }) {
    return PlayerRatingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerRating.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlayerRating.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerRatingImpl extends PlayerRating {
  _PlayerRatingImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required double rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          rating: rating,
          comment: comment,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerRating copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    double? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerRating(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PlayerRatingTable extends _i1.Table<_i1.UuidValue?> {
  PlayerRatingTable({super.tableRelation})
      : super(tableName: 'player_ratings') {
    matchId = _i1.ColumnUuid(
      'matchId',
      this,
    );
    clubMemberId = _i1.ColumnUuid(
      'clubMemberId',
      this,
    );
    rating = _i1.ColumnDouble(
      'rating',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
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

  late final _i1.ColumnUuid matchId;

  late final _i1.ColumnUuid clubMemberId;

  late final _i1.ColumnDouble rating;

  late final _i1.ColumnString comment;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        matchId,
        clubMemberId,
        rating,
        comment,
        createdAt,
        updatedAt,
      ];
}

class PlayerRatingInclude extends _i1.IncludeObject {
  PlayerRatingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlayerRating.t;
}

class PlayerRatingIncludeList extends _i1.IncludeList {
  PlayerRatingIncludeList._({
    _i1.WhereExpressionBuilder<PlayerRatingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlayerRating.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlayerRating.t;
}

class PlayerRatingRepository {
  const PlayerRatingRepository._();

  /// Returns a list of [PlayerRating]s matching the given query parameters.
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
  Future<List<PlayerRating>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerRatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlayerRating>(
      where: where?.call(PlayerRating.t),
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlayerRating] matching the given query parameters.
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
  Future<PlayerRating?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlayerRatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlayerRating>(
      where: where?.call(PlayerRating.t),
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlayerRating] by its [id] or null if no such row exists.
  Future<PlayerRating?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlayerRating>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlayerRating]s in the list and returns the inserted rows.
  ///
  /// The returned [PlayerRating]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlayerRating>> insert(
    _i1.Session session,
    List<PlayerRating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlayerRating>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlayerRating] and returns the inserted row.
  ///
  /// The returned [PlayerRating] will have its `id` field set.
  Future<PlayerRating> insertRow(
    _i1.Session session,
    PlayerRating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlayerRating>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlayerRating]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlayerRating>> update(
    _i1.Session session,
    List<PlayerRating> rows, {
    _i1.ColumnSelections<PlayerRatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlayerRating>(
      rows,
      columns: columns?.call(PlayerRating.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayerRating]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlayerRating> updateRow(
    _i1.Session session,
    PlayerRating row, {
    _i1.ColumnSelections<PlayerRatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlayerRating>(
      row,
      columns: columns?.call(PlayerRating.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PlayerRating]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlayerRating>> delete(
    _i1.Session session,
    List<PlayerRating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlayerRating>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlayerRating].
  Future<PlayerRating> deleteRow(
    _i1.Session session,
    PlayerRating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlayerRating>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlayerRating>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlayerRatingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlayerRating>(
      where: where(PlayerRating.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlayerRating>(
      where: where?.call(PlayerRating.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
