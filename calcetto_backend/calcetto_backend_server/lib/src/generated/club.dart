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

abstract class Club implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Club._({
    this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Club({
    int? id,
    required String name,
    String? description,
    String? imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ClubImpl;

  factory Club.fromJson(Map<String, dynamic> jsonSerialization) {
    return Club(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = ClubTable();

  static const db = ClubRepository._();

  @override
  int? id;

  String name;

  String? description;

  String? imageUrl;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Club]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Club copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static ClubInclude include() {
    return ClubInclude._();
  }

  static ClubIncludeList includeList({
    _i1.WhereExpressionBuilder<ClubTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubTable>? orderByList,
    ClubInclude? include,
  }) {
    return ClubIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Club.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Club.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubImpl extends Club {
  _ClubImpl({
    int? id,
    required String name,
    String? description,
    String? imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Club]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Club copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? imageUrl = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Club(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class ClubTable extends _i1.Table<int?> {
  ClubTable({super.tableRelation}) : super(tableName: 'club') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        imageUrl,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class ClubInclude extends _i1.IncludeObject {
  ClubInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Club.t;
}

class ClubIncludeList extends _i1.IncludeList {
  ClubIncludeList._({
    _i1.WhereExpressionBuilder<ClubTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Club.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Club.t;
}

class ClubRepository {
  const ClubRepository._();

  /// Returns a list of [Club]s matching the given query parameters.
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
  Future<List<Club>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClubTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Club>(
      where: where?.call(Club.t),
      orderBy: orderBy?.call(Club.t),
      orderByList: orderByList?.call(Club.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Club] matching the given query parameters.
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
  Future<Club?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClubTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClubTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Club>(
      where: where?.call(Club.t),
      orderBy: orderBy?.call(Club.t),
      orderByList: orderByList?.call(Club.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Club] by its [id] or null if no such row exists.
  Future<Club?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Club>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Club]s in the list and returns the inserted rows.
  ///
  /// The returned [Club]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Club>> insert(
    _i1.Session session,
    List<Club> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Club>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Club] and returns the inserted row.
  ///
  /// The returned [Club] will have its `id` field set.
  Future<Club> insertRow(
    _i1.Session session,
    Club row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Club>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Club]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Club>> update(
    _i1.Session session,
    List<Club> rows, {
    _i1.ColumnSelections<ClubTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Club>(
      rows,
      columns: columns?.call(Club.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Club]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Club> updateRow(
    _i1.Session session,
    Club row, {
    _i1.ColumnSelections<ClubTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Club>(
      row,
      columns: columns?.call(Club.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Club]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Club>> delete(
    _i1.Session session,
    List<Club> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Club>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Club].
  Future<Club> deleteRow(
    _i1.Session session,
    Club row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Club>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Club>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClubTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Club>(
      where: where(Club.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClubTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Club>(
      where: where?.call(Club.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
