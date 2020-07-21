// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AccountDao _accountDaoInstance;

  BankDao _bankDaoInstance;

  CategoryDao _categoryDaoInstance;

  SubcategoryDao _subcategoryDaoInstance;

  TransferDao _transferDaoInstance;

  AccountTransactionDao _accountTransactionDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Account` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bankId` INTEGER, `name` TEXT, `balance` REAL, `descriptions` TEXT, `createdDateTime` TEXT, FOREIGN KEY (`bankId`) REFERENCES `Bank` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Bank` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `createdDateTime` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `imagePath` TEXT, `createdDateTime` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Subcategory` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `categoryId` INTEGER, `name` TEXT, `imagePath` TEXT, `createdDateTime` TEXT, FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Transfer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sourceAccountId` INTEGER, `destinationAccountId` INTEGER, `amount` REAL, `dateTime` TEXT, `descriptions` TEXT, `createdDateTime` TEXT, FOREIGN KEY (`sourceAccountId`) REFERENCES `Account` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`destinationAccountId`) REFERENCES `Account` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AccountTransaction` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `accountId` INTEGER, `amount` REAL, `dateTime` TEXT, `receiptImagePath` TEXT, `categoryId` INTEGER, `subcategoryId` INTEGER, `createdDateTime` TEXT, `isIncome` INTEGER, FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`subcategoryId`) REFERENCES `Subcategory` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await database.execute(
            '''CREATE VIEW IF NOT EXISTS `AccountTransactionView` AS SELECT AccountTransaction.id AS accountTransactionId, AccountTransaction.accountId AS accountId, AccountTransaction.categoryId AS categoryId, AccountTransaction.subcategoryId AS subcategoryId, AccountTransaction.dateTime AS dateTime, AccountTransaction.isIncome AS isIncome, AccountTransaction.amount AS amount, AccountTransaction.receiptImagePath AS receiptImagePath, Account.name AS accountName, Subcategory.name AS subcategoryName, Category.name AS categoryName FROM AccountTransaction JOIN Category ON AccountTransaction.categoryId = Category.id JOIN Subcategory ON AccountTransaction.subcategoryId = Subcategory.id JOIN Account ON AccountTransaction.accountId = Account.id ''');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AccountDao get accountDao {
    return _accountDaoInstance ??= _$AccountDao(database, changeListener);
  }

  @override
  BankDao get bankDao {
    return _bankDaoInstance ??= _$BankDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  SubcategoryDao get subcategoryDao {
    return _subcategoryDaoInstance ??=
        _$SubcategoryDao(database, changeListener);
  }

  @override
  TransferDao get transferDao {
    return _transferDaoInstance ??= _$TransferDao(database, changeListener);
  }

  @override
  AccountTransactionDao get accountTransactionDao {
    return _accountTransactionDaoInstance ??=
        _$AccountTransactionDao(database, changeListener);
  }
}

class _$AccountDao extends AccountDao {
  _$AccountDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _accountInsertionAdapter = InsertionAdapter(
            database,
            'Account',
            (Account item) => <String, dynamic>{
                  'id': item.id,
                  'bankId': item.bankId,
                  'name': item.name,
                  'balance': item.balance,
                  'descriptions': item.descriptions,
                  'createdDateTime': item.createdDateTime
                },
            changeListener),
        _accountUpdateAdapter = UpdateAdapter(
            database,
            'Account',
            ['id'],
            (Account item) => <String, dynamic>{
                  'id': item.id,
                  'bankId': item.bankId,
                  'name': item.name,
                  'balance': item.balance,
                  'descriptions': item.descriptions,
                  'createdDateTime': item.createdDateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _accountMapper = (Map<String, dynamic> row) => Account(
      id: row['id'] as int,
      bankId: row['bankId'] as int,
      name: row['name'] as String,
      balance: row['balance'] as double,
      descriptions: row['descriptions'] as String,
      createdDateTime: row['createdDateTime'] as String);

  final InsertionAdapter<Account> _accountInsertionAdapter;

  final UpdateAdapter<Account> _accountUpdateAdapter;

  @override
  Future<List<Account>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Account',
        mapper: _accountMapper);
  }

  @override
  Stream<Account> findAccount(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Account WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Account',
        isView: false,
        mapper: _accountMapper);
  }

  @override
  Future<void> insertAccount(Account account) async {
    await _accountInsertionAdapter.insert(account, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateAccount(Account account) async {
    await _accountUpdateAdapter.update(account, OnConflictStrategy.replace);
  }
}

class _$BankDao extends BankDao {
  _$BankDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _bankInsertionAdapter = InsertionAdapter(
            database,
            'Bank',
            (Bank item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'createdDateTime': item.createdDateTime
                },
            changeListener),
        _bankUpdateAdapter = UpdateAdapter(
            database,
            'Bank',
            ['id'],
            (Bank item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'createdDateTime': item.createdDateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _bankMapper = (Map<String, dynamic> row) => Bank(
      id: row['id'] as int,
      name: row['name'] as String,
      createdDateTime: row['createdDateTime'] as String);

  final InsertionAdapter<Bank> _bankInsertionAdapter;

  final UpdateAdapter<Bank> _bankUpdateAdapter;

  @override
  Future<List<Bank>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Bank', mapper: _bankMapper);
  }

  @override
  Stream<Bank> findBank(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Bank WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Bank',
        isView: false,
        mapper: _bankMapper);
  }

  @override
  Future<void> insertBank(Bank bank) async {
    await _bankInsertionAdapter.insert(bank, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateBank(Bank bank) async {
    await _bankUpdateAdapter.update(bank, OnConflictStrategy.replace);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'imagePath': item.imagePath,
                  'createdDateTime': item.createdDateTime
                },
            changeListener),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'Category',
            ['id'],
            (Category item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'imagePath': item.imagePath,
                  'createdDateTime': item.createdDateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _categoryMapper = (Map<String, dynamic> row) => Category(
      id: row['id'] as int,
      name: row['name'] as String,
      imagePath: row['imagePath'] as String,
      createdDateTime: row['createdDateTime'] as String);

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  @override
  Stream<List<Category>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Category',
        queryableName: 'Category', isView: false, mapper: _categoryMapper);
  }

  @override
  Stream<Category> findCategory(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Category WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Category',
        isView: false,
        mapper: _categoryMapper);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _categoryUpdateAdapter.update(category, OnConflictStrategy.replace);
  }
}

class _$SubcategoryDao extends SubcategoryDao {
  _$SubcategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _subcategoryInsertionAdapter = InsertionAdapter(
            database,
            'Subcategory',
            (Subcategory item) => <String, dynamic>{
                  'id': item.id,
                  'categoryId': item.categoryId,
                  'name': item.name,
                  'imagePath': item.imagePath,
                  'createdDateTime': item.createdDateTime
                },
            changeListener),
        _subcategoryUpdateAdapter = UpdateAdapter(
            database,
            'Subcategory',
            ['id'],
            (Subcategory item) => <String, dynamic>{
                  'id': item.id,
                  'categoryId': item.categoryId,
                  'name': item.name,
                  'imagePath': item.imagePath,
                  'createdDateTime': item.createdDateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _subcategoryMapper = (Map<String, dynamic> row) => Subcategory(
      id: row['id'] as int,
      categoryId: row['categoryId'] as int,
      name: row['name'] as String,
      imagePath: row['imagePath'] as String,
      createdDateTime: row['createdDateTime'] as String);

  final InsertionAdapter<Subcategory> _subcategoryInsertionAdapter;

  final UpdateAdapter<Subcategory> _subcategoryUpdateAdapter;

  @override
  Stream<List<Subcategory>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Subcategory',
        queryableName: 'Subcategory',
        isView: false,
        mapper: _subcategoryMapper);
  }

  @override
  Future<Subcategory> findSubcategory(int id) async {
    return _queryAdapter.query('SELECT * FROM Subcategory WHERE id = ?',
        arguments: <dynamic>[id], mapper: _subcategoryMapper);
  }

  @override
  Future<void> insertSubcategory(Subcategory subcategory) async {
    await _subcategoryInsertionAdapter.insert(
        subcategory, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateSubcategory(Subcategory subcategory) async {
    await _subcategoryUpdateAdapter.update(
        subcategory, OnConflictStrategy.replace);
  }
}

class _$TransferDao extends TransferDao {
  _$TransferDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _transferInsertionAdapter = InsertionAdapter(
            database,
            'Transfer',
            (Transfer item) => <String, dynamic>{
                  'id': item.id,
                  'sourceAccountId': item.sourceAccountId,
                  'destinationAccountId': item.destinationAccountId,
                  'amount': item.amount,
                  'dateTime': item.dateTime,
                  'descriptions': item.descriptions,
                  'createdDateTime': item.createdDateTime
                },
            changeListener),
        _transferUpdateAdapter = UpdateAdapter(
            database,
            'Transfer',
            ['id'],
            (Transfer item) => <String, dynamic>{
                  'id': item.id,
                  'sourceAccountId': item.sourceAccountId,
                  'destinationAccountId': item.destinationAccountId,
                  'amount': item.amount,
                  'dateTime': item.dateTime,
                  'descriptions': item.descriptions,
                  'createdDateTime': item.createdDateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _transferMapper = (Map<String, dynamic> row) => Transfer(
      id: row['id'] as int,
      sourceAccountId: row['sourceAccountId'] as int,
      destinationAccountId: row['destinationAccountId'] as int,
      amount: row['amount'] as double,
      dateTime: row['dateTime'] as String,
      descriptions: row['descriptions'] as String,
      createdDateTime: row['createdDateTime'] as String);

  final InsertionAdapter<Transfer> _transferInsertionAdapter;

  final UpdateAdapter<Transfer> _transferUpdateAdapter;

  @override
  Future<List<Transfer>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Transfer',
        mapper: _transferMapper);
  }

  @override
  Stream<Transfer> findTransfer(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Transfer WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Transfer',
        isView: false,
        mapper: _transferMapper);
  }

  @override
  Future<void> insertTransfer(Transfer transfer) async {
    await _transferInsertionAdapter.insert(transfer, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateTransfer(Transfer transfer) async {
    await _transferUpdateAdapter.update(transfer, OnConflictStrategy.replace);
  }
}

class _$AccountTransactionDao extends AccountTransactionDao {
  _$AccountTransactionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _accountTransactionInsertionAdapter = InsertionAdapter(
            database,
            'AccountTransaction',
            (AccountTransaction item) => <String, dynamic>{
                  'id': item.id,
                  'accountId': item.accountId,
                  'amount': item.amount,
                  'dateTime': item.dateTime,
                  'receiptImagePath': item.receiptImagePath,
                  'categoryId': item.categoryId,
                  'subcategoryId': item.subcategoryId,
                  'createdDateTime': item.createdDateTime,
                  'isIncome':
                      item.isIncome == null ? null : (item.isIncome ? 1 : 0)
                },
            changeListener),
        _accountTransactionUpdateAdapter = UpdateAdapter(
            database,
            'AccountTransaction',
            ['id'],
            (AccountTransaction item) => <String, dynamic>{
                  'id': item.id,
                  'accountId': item.accountId,
                  'amount': item.amount,
                  'dateTime': item.dateTime,
                  'receiptImagePath': item.receiptImagePath,
                  'categoryId': item.categoryId,
                  'subcategoryId': item.subcategoryId,
                  'createdDateTime': item.createdDateTime,
                  'isIncome':
                      item.isIncome == null ? null : (item.isIncome ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _accountTransactionMapper = (Map<String, dynamic> row) =>
      AccountTransaction(
          id: row['id'] as int,
          accountId: row['accountId'] as int,
          amount: row['amount'] as double,
          dateTime: row['dateTime'] as String,
          receiptImagePath: row['receiptImagePath'] as String,
          categoryId: row['categoryId'] as int,
          subcategoryId: row['subcategoryId'] as int,
          createdDateTime: row['createdDateTime'] as String,
          isIncome:
              row['isIncome'] == null ? null : (row['isIncome'] as int) != 0);

  static final _accountTransactionViewMapper = (Map<String, dynamic> row) =>
      AccountTransactionView(
          accountTransactionId: row['accountTransactionId'] as int,
          accountId: row['accountId'] as int,
          categoryId: row['categoryId'] as int,
          subcategoryId: row['subcategoryId'] as int,
          isIncome:
              row['isIncome'] == null ? null : (row['isIncome'] as int) != 0,
          amount: row['amount'] as double,
          dateTime: row['dateTime'] as String,
          receiptImagePath: row['receiptImagePath'] as String,
          accountName: row['accountName'] as String,
          subcategoryName: row['subcategoryName'] as String,
          categoryName: row['categoryName'] as String);

  final InsertionAdapter<AccountTransaction>
      _accountTransactionInsertionAdapter;

  final UpdateAdapter<AccountTransaction> _accountTransactionUpdateAdapter;

  @override
  Future<AccountTransaction> findWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM AccountTransaction WHERE id = ?',
        arguments: <dynamic>[id], mapper: _accountTransactionMapper);
  }

  @override
  Stream<List<AccountTransactionView>> findAll(String fromDate, String toDate) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM AccountTransactionView WHERE dateTime > ? AND dateTime < ?',
        arguments: <dynamic>[fromDate, toDate],
        queryableName: 'AccountTransactionView',
        isView: true,
        mapper: _accountTransactionViewMapper);
  }

  @override
  Future<void> insertAccountTransaction(
      AccountTransaction accountTransaction) async {
    await _accountTransactionInsertionAdapter.insert(
        accountTransaction, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAccountTransaction(
      AccountTransaction accountTransaction) async {
    await _accountTransactionUpdateAdapter.update(
        accountTransaction, OnConflictStrategy.replace);
  }
}
