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

abstract class ClubMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClubMember._({
    this.id,
    required this.clubId,
    required this.userId,
    required this.privileges,
    required this.joinedAt,
    this.deletedAt,
  });

  factory ClubMember({
    int? id,
    required int clubId,
    required int userId,
    required int privileges,
    required DateTime joinedAt,
    DateTime? deletedAt,
  }) = _ClubMemberImpl;

  factory ClubMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubMember(
      id: jsonSerialization['id'] as int?,
      clubId: jsonSerialization['clubId'] as int,
      userId: jsonSerialization['userId'] as int,
      privileges: jsonSerialization['privileges'] as int,
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = ClubMemberTable();

  static const db = ClubMemberRepository._();

  @override
  int? id;

  int clubId;

  int userId;

  int privileges;

  DateTime joinedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClubMember copyWith({
    int? id,
    int? clubId,
    int? userId,
    int? privileges,
    DateTime? joinedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'clubId': clubId,
      'userId': userId,
      'privileges': privileges,
      'joinedAt': joinedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'clubId': clubId,
      'userId': userId,
      'privileges': privileges,
      'joinedAt': joinedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static ClubMemberInclude include() {
    return ClubMemberInclude._();
  }

  static ClubMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<ClubMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubMemberTable>? orderByList,
    ClubMemberInclude? include,
  }) {
    return ClubMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClubMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClubMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubMemberImpl extends ClubMember {
  _ClubMemberImpl({
    int? id,
    required int clubId,
    required int userId,
    required int privileges,
    required DateTime joinedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          clubId: clubId,
          userId: userId,
          privileges: privileges,
          joinedAt: joinedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClubMember copyWith({
    Object? id = _Undefined,
    int? clubId,
    int? userId,
    int? privileges,
    DateTime? joinedAt,
    Object? deletedAt = _Undefined,
  }) {
    return ClubMember(
      id: id is int? ? id : this.id,
      clubId: clubId ?? this.clubId,
      userId: userId ?? this.userId,
      privileges: privileges ?? this.privileges,
      joinedAt: joinedAt ?? this.joinedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class ClubMemberTable extends _i1.Table<int?> {
  ClubMemberTable({super.tableRelation}) : super(tableName: 'club_member') {
    clubId = _i1.ColumnInt(
      'clubId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    privileges = _i1.ColumnInt(
      'privileges',
      this,
    );
    joinedAt = _i1.ColumnDateTime(
      'joinedAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnInt clubId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt privileges;

  late final _i1.ColumnDateTime joinedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        clubId,
        userId,
        privileges,
        joinedAt,
        deletedAt,
      ];
}

class ClubMemberInclude extends _i1.IncludeObject {
  ClubMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ClubMember.t;
}

class ClubMemberIncludeList extends _i1.IncludeList {
  ClubMemberIncludeList._({
    _i1.WhereExpressionBuilder<ClubMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClubMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClubMember.t;
}

class ClubMemberRepository {
  const ClubMemberRepository._();

  /// Returns a list of [ClubMember]s matching the given query parameters.
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
  Future<List<ClubMember>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClubMember>(
      where: where?.call(ClubMember.t),
      orderBy: orderBy?.call(ClubMember.t),
      orderByList: orderByList?.call(ClubMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClubMember] matching the given query parameters.
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
  Future<ClubMember?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClubMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClubMember>(
      where: where?.call(ClubMember.t),
      orderBy: orderBy?.call(ClubMember.t),
      orderByList: orderByList?.call(ClubMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClubMember] by its [id] or null if no such row exists.
  Future<ClubMember?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClubMember>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClubMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ClubMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClubMember>> insert(
    _i1.Session session,
    List<ClubMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClubMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClubMember] and returns the inserted row.
  ///
  /// The returned [ClubMember] will have its `id` field set.
  Future<ClubMember> insertRow(
    _i1.Session session,
    ClubMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClubMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClubMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClubMember>> update(
    _i1.Session session,
    List<ClubMember> rows, {
    _i1.ColumnSelections<ClubMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClubMember>(
      rows,
      columns: columns?.call(ClubMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClubMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClubMember> updateRow(
    _i1.Session session,
    ClubMember row, {
    _i1.ColumnSelections<ClubMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClubMember>(
      row,
      columns: columns?.call(ClubMember.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClubMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClubMember>> delete(
    _i1.Session session,
    List<ClubMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClubMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClubMember].
  Future<ClubMember> deleteRow(
    _i1.Session session,
    ClubMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClubMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClubMember>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClubMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClubMember>(
      where: where(ClubMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClubMember>(
      where: where?.call(ClubMember.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
