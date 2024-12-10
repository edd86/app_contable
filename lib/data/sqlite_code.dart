String createUserTable = '''
CREATE TABLE Users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);
''';

String createTransactionTable = '''
CREATE TABLE Transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,
  type TEXT CHECK (type IN ('income', 'expense')) NOT NULL,
  description TEXT,
  amount REAL NOT NULL,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES Users (id)
);
''';

String createIncomesTable = '''
CREATE TABLE Incomes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  transaction_id INTEGER,
  amount REAL NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES Transactions (id)
);
''';

String createExpensesTable = '''
CREATE TABLE Expenses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  transaction_id INTEGER,
  amount REAL NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES Transactions (id)
);
''';

String createDebtsTable = '''
CREATE TABLE Debts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  creditor TEXT NOT NULL,
  amount REAL NOT NULL,
  due_date TEXT NOT NULL,
  description TEXT,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES Users (id)
);
''';

String createBudgetsTable = '''
CREATE TABLE Budgets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  initial_date TEXT NOT NULL,
  final_date TEXT NOT NULL,
  amount_budget REAL NOT NULL,
  description REAL NOT NULL,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES Users (id)
);
''';
