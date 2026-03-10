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

abstract class UserInfo
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserInfo._({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.imageUrl,
    required this.passwordHash,
    required this.passwordSalt,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
    this.deletedAt,
  });

  factory UserInfo({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String passwordHash,
    required String passwordSalt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  }) = _UserInfoImpl;

  factory UserInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInfo(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      nickname: jsonSerialization['nickname'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      passwordHash: jsonSerialization['passwordHash'] as String,
      passwordSalt: jsonSerialization['passwordSalt'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      lastLogin: jsonSerialization['lastLogin'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastLogin']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = UserInfoTable();

  static const db = UserInfoRepository._();

  @override
  int? id;

  String email;

  String firstName;

  String lastName;

  String? nickname;

  String? imageUrl;

  String passwordHash;

  String passwordSalt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastLogin;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserInfo copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? nickname,
    String? imageUrl,
    String? passwordHash,
    String? passwordSalt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      if (nickname != null) 'nickname': nickname,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastLogin != null) 'lastLogin': lastLogin?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      if (nickname != null) 'nickname': nickname,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastLogin != null) 'lastLogin': lastLogin?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static UserInfoInclude include() {
    return UserInfoInclude._();
  }

  static UserInfoIncludeList includeList({
    _i1.WhereExpressionBuilder<UserInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserInfoTable>? orderByList,
    UserInfoInclude? include,
  }) {
    return UserInfoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserInfo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserInfo.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInfoImpl extends UserInfo {
  _UserInfoImpl({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String passwordHash,
    required String passwordSalt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          nickname: nickname,
          imageUrl: imageUrl,
          passwordHash: passwordHash,
          passwordSalt: passwordSalt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastLogin: lastLogin,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserInfo copyWith({
    Object? id = _Undefined,
    String? email,
    String? firstName,
    String? lastName,
    Object? nickname = _Undefined,
    Object? imageUrl = _Undefined,
    String? passwordHash,
    String? passwordSalt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastLogin = _Undefined,
    Object? deletedAt = _Undefined,
  }) {
    return UserInfo(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname is String? ? nickname : this.nickname,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin is DateTime? ? lastLogin : this.lastLogin,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class UserInfoTable extends _i1.Table<int?> {
  UserInfoTable({super.tableRelation}) : super(tableName: 'user_info') {
    email = _i1.ColumnString(
      'email',
      this,
    );
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
      this,
    );
    passwordSalt = _i1.ColumnString(
      'passwordSalt',
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
    lastLogin = _i1.ColumnDateTime(
      'lastLogin',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnString email;

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString passwordHash;

  late final _i1.ColumnString passwordSalt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime lastLogin;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        email,
        firstName,
        lastName,
        nickname,
        imageUrl,
        passwordHash,
        passwordSalt,
        createdAt,
        updatedAt,
        lastLogin,
        deletedAt,
      ];
}

class UserInfoInclude extends _i1.IncludeObject {
  UserInfoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserInfo.t;
}

class UserInfoIncludeList extends _i1.IncludeList {
  UserInfoIncludeList._({
    _i1.WhereExpressionBuilder<UserInfoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserInfo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserInfo.t;
}

class UserInfoRepository {
  const UserInfoRepository._();

  /// Returns a list of [UserInfo]s matching the given query parameters.
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
  Future<List<UserInfo>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserInfoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserInfo>(
      where: where?.call(UserInfo.t),
      orderBy: orderBy?.call(UserInfo.t),
      orderByList: orderByList?.call(UserInfo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserInfo] matching the given query parameters.
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
  Future<UserInfo?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserInfoTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserInfoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserInfo>(
      where: where?.call(UserInfo.t),
      orderBy: orderBy?.call(UserInfo.t),
      orderByList: orderByList?.call(UserInfo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserInfo] by its [id] or null if no such row exists.
  Future<UserInfo?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserInfo>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserInfo]s in the list and returns the inserted rows.
  ///
  /// The returned [UserInfo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserInfo>> insert(
    _i1.Session session,
    List<UserInfo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserInfo>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserInfo] and returns the inserted row.
  ///
  /// The returned [UserInfo] will have its `id` field set.
  Future<UserInfo> insertRow(
    _i1.Session session,
    UserInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserInfo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserInfo>> update(
    _i1.Session session,
    List<UserInfo> rows, {
    _i1.ColumnSelections<UserInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserInfo>(
      rows,
      columns: columns?.call(UserInfo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserInfo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserInfo> updateRow(
    _i1.Session session,
    UserInfo row, {
    _i1.ColumnSelections<UserInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserInfo>(
      row,
      columns: columns?.call(UserInfo.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserInfo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserInfo>> delete(
    _i1.Session session,
    List<UserInfo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserInfo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserInfo].
  Future<UserInfo> deleteRow(
    _i1.Session session,
    UserInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserInfo>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserInfoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserInfo>(
      where: where(UserInfo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserInfoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserInfo>(
      where: where?.call(UserInfo.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
