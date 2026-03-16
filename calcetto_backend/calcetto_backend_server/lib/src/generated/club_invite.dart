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

abstract class ClubInvite
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ClubInvite._({
    this.id,
    required this.clubId,
    this.createdBy,
    required this.token,
    required this.expiresAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ClubInvite({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    _i1.UuidValue? createdBy,
    required String token,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) = _ClubInviteImpl;

  factory ClubInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubInvite(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      clubId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['clubId']),
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['createdBy']),
      token: jsonSerialization['token'] as String,
      expiresAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ClubInviteTable();

  static const db = ClubInviteRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue clubId;

  _i1.UuidValue? createdBy;

  String token;

  DateTime expiresAt;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ClubInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClubInvite copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? clubId,
    _i1.UuidValue? createdBy,
    String? token,
    DateTime? expiresAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'token': token,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'token': token,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ClubInviteInclude include() {
    return ClubInviteInclude._();
  }

  static ClubInviteIncludeList includeList({
    _i1.WhereExpressionBuilder<ClubInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubInviteTable>? orderByList,
    ClubInviteInclude? include,
  }) {
    return ClubInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClubInvite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClubInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubInviteImpl extends ClubInvite {
  _ClubInviteImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    _i1.UuidValue? createdBy,
    required String token,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) : super._(
          id: id,
          clubId: clubId,
          createdBy: createdBy,
          token: token,
          expiresAt: expiresAt,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ClubInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClubInvite copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? clubId,
    Object? createdBy = _Undefined,
    String? token,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return ClubInvite(
      id: id is _i1.UuidValue? ? id : this.id,
      clubId: clubId ?? this.clubId,
      createdBy: createdBy is _i1.UuidValue? ? createdBy : this.createdBy,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ClubInviteTable extends _i1.Table<_i1.UuidValue?> {
  ClubInviteTable({super.tableRelation}) : super(tableName: 'club_invites') {
    clubId = _i1.ColumnUuid(
      'clubId',
      this,
    );
    createdBy = _i1.ColumnUuid(
      'createdBy',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnUuid clubId;

  late final _i1.ColumnUuid createdBy;

  late final _i1.ColumnString token;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        clubId,
        createdBy,
        token,
        expiresAt,
        createdAt,
      ];
}

class ClubInviteInclude extends _i1.IncludeObject {
  ClubInviteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ClubInvite.t;
}

class ClubInviteIncludeList extends _i1.IncludeList {
  ClubInviteIncludeList._({
    _i1.WhereExpressionBuilder<ClubInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClubInvite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ClubInvite.t;
}

class ClubInviteRepository {
  const ClubInviteRepository._();

  /// Returns a list of [ClubInvite]s matching the given query parameters.
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
  Future<List<ClubInvite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubInviteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClubInvite>(
      where: where?.call(ClubInvite.t),
      orderBy: orderBy?.call(ClubInvite.t),
      orderByList: orderByList?.call(ClubInvite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClubInvite] matching the given query parameters.
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
  Future<ClubInvite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubInviteTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClubInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubInviteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClubInvite>(
      where: where?.call(ClubInvite.t),
      orderBy: orderBy?.call(ClubInvite.t),
      orderByList: orderByList?.call(ClubInvite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClubInvite] by its [id] or null if no such row exists.
  Future<ClubInvite?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClubInvite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClubInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [ClubInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClubInvite>> insert(
    _i1.Session session,
    List<ClubInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClubInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClubInvite] and returns the inserted row.
  ///
  /// The returned [ClubInvite] will have its `id` field set.
  Future<ClubInvite> insertRow(
    _i1.Session session,
    ClubInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClubInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClubInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClubInvite>> update(
    _i1.Session session,
    List<ClubInvite> rows, {
    _i1.ColumnSelections<ClubInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClubInvite>(
      rows,
      columns: columns?.call(ClubInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClubInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClubInvite> updateRow(
    _i1.Session session,
    ClubInvite row, {
    _i1.ColumnSelections<ClubInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClubInvite>(
      row,
      columns: columns?.call(ClubInvite.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClubInvite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClubInvite>> delete(
    _i1.Session session,
    List<ClubInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClubInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClubInvite].
  Future<ClubInvite> deleteRow(
    _i1.Session session,
    ClubInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClubInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClubInvite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClubInviteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClubInvite>(
      where: where(ClubInvite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubInviteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClubInvite>(
      where: where?.call(ClubInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
