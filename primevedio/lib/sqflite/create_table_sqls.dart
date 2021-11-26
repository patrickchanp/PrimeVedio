///数据表定义

class CreateTableSqls {
  //关系表语句
  static const String createTableSqlRelation = '''
    CREATE TABLE IF NOT EXISTS relation (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    uid BIGINT(20) NOT NULL, 
    fuid BIGINT(20) NOT NULL,
    type INTEGER(3) NOT NULL);
    ''';
  //用户表语句
  static const String createTableSqlUser = '''
    CREATE TABLE IF NOT EXISTS user (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    uid BIGINT(20) NOT NULL, 
    phonenumber TEXT(30) NOT NULL, 
    nickName TEXT(100));
    ''';
  static const String createTableSqlUgc = '''
    CREATE TABLE IF NOT EXISTS ugc (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    uid BIGINT(20) NOT NULL, 
    phonenumber TEXT(30) NOT NULL, 
    nickName TEXT(100));
    ''';
  static const String createTableSqlHome = '''
    CREATE TABLE IF NOT EXISTS home (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    phonenumber TEXT(30) NOT NULL, 
    nickName TEXT(100));
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = <String, String>{};
    map['relation'] = createTableSqlRelation;
    map['user'] = createTableSqlUser;
    map['ugc'] = createTableSqlUgc;
    map['home'] = createTableSqlHome;
    return map;
  }
}
