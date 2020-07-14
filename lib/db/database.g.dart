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

  TransactionDao _transactionDaoInstance;

  TransferDao _transferDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Transaction` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `accountId` INTEGER, `amount` REAL, `dateTime` TEXT, `receiptImagePath` TEXT, `categoryId` INTEGER, `subcategoryId` INTEGER, `createdDateTime` TEXT, `isIncome` INTEGER, FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`subcategoryId`) REFERENCES `Subcategory` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Transfer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sourceAccountId` INTEGER, `destinationAccountId` INTEGER, `amount` REAL, `dateTime` TEXT, `descriptions` TEXT, `createdDateTime` TEXT, FOREIGN KEY (`sourceAccountId`, `destinationAccountId`) REFERENCES `Account` (`id`, `id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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
  TransactionDao get transactionDao {
    return _transactionDaoInstance ??=
        _$TransactionDao(database, changeListener);
  }

  @override
  TransferDao get transferDao {
    return _transferDaoInstance ??= _$TransferDao(database, changeListener);
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
      row['bankId'] as int,
      row['name'] as String,
      row['balance'] as double,
      row['descriptions'] as String,
      row['createdDateTime'] as String,
      row['id'] as int);

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
      row['name'] as String,
      row['createdDateTime'] as String,
      row['id'] as int);

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
      row['id'] as int,
      row['name'] as String,
      row['imagePath'] as String,
      row['createdDateTime'] as String);

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  @override
  Future<List<Category>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Category',
        mapper: _categoryMapper);
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
      row['id'] as int,
      row['categoryId'] as int,
      row['name'] as String,
      row['imagePath'] as String,
      row['createdDateTime'] as String);

  final InsertionAdapter<Subcategory> _subcategoryInsertionAdapter;

  final UpdateAdapter<Subcategory> _subcategoryUpdateAdapter;

  @override
  Future<List<Subcategory>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Subcategory',
        mapper: _subcategoryMapper);
  }

  @override
  Stream<Subcategory> findSubcategory(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Subcategory WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Subcategory',
        isView: false,
        mapper: _subcategoryMapper);
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

class _$TransactionDao extends TransactionDao {
  _$TransactionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _transactionInsertionAdapter = InsertionAdapter(
            database,
            'Transaction',
            (Transaction item) => <String, dynamic>{
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
        _transactionUpdateAdapter = UpdateAdapter(
            database,
            'Transaction',
            ['id'],
            (Transaction item) => <String, dynamic>{
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

  static final _transactionMapper = (Map<String, dynamic> row) => Transaction(
      row['id'] as int,
      row['accountId'] as int,
      row['amount'] as double,
      row['dateTime'] as String,
      row['receiptImagePath'] as String,
      row['categoryId'] as int,
      row['subcategoryId'] as int,
      row['createdDateTime'] as String,
      row['isIncome'] == null ? null : (row['isIncome'] as int) != 0);

  final InsertionAdapter<Transaction> _transactionInsertionAdapter;

  final UpdateAdapter<Transaction> _transactionUpdateAdapter;

  @override
  Future<List<Transaction>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Transaction',
        mapper: _transactionMapper);
  }

  @override
  Stream<Transaction> findTransaction(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Transaction WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Transaction',
        isView: false,
        mapper: _transactionMapper);
  }

  @override
  Future<void> insertTransaction(Transaction transaction) async {
    await _transactionInsertionAdapter.insert(
        transaction, OnConflictStrategy.fail);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionUpdateAdapter.update(
        transaction, OnConflictStrategy.replace);
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
      row['id'] as int,
      row['sourceAccountId'] as int,
      row['destinationAccountId'] as int,
      row['amount'] as double,
      row['dateTime'] as String,
      row['descriptions'] as String,
      row['createdDateTime'] as String);

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
