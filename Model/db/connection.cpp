#include "connection.h"

Connection::Connection(QObject *parent) : QObject(parent)
{
    openDatabase();
    m_modelContactList = new ModelContactList();
}

Connection::~Connection()
{
    closeDatabase();
    delete m_modelContactList;
}

bool Connection::openDatabase()
{

#ifdef Q_OS_ANDROID
    mDatabase = QSqlDatabase::addDatabase("QSQLITE");
    mDatabase.setDatabaseName("myDatabase.db");
#endif

#ifdef Q_OS_LINUX
    mDatabase = QSqlDatabase::addDatabase("QSQLITE");
    mDatabase.setDatabaseName("myDatabase.db");
#endif

#ifdef Q_OS_IOS
    dbLocation = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/";
    mDatabase = QSqlDatabase::addDatabase("QSQLITE");
    mDatabase.setDatabaseName(dbLocation + "myDatabase.db");
#endif

#ifdef Q_OS_MAC
    dbLocation = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/";
    mDatabase = QSqlDatabase::addDatabase("QSQLITE");
    mDatabase.setDatabaseName(dbLocation + "myDatabase.db");
    qDebug() << "dbLocation  " << dbLocation + "myDatabase.db";
#endif

    //qDebug() << "isDriver " <<  QSqlDatabase::isDriverAvailable("QSQLITE");  // check Exist Database Driver

    if(mDatabase.open())
    {
        QSqlQuery queryCheckTable("SELECT name FROM sqlite_master WHERE type='table' AND name='tbl_users';");
        if (queryCheckTable.exec()) {
            QSqlQuery query;
            query.prepare("CREATE TABLE tbl_users (username TEXT NOT NULL UNIQUE, password TEXT NOT NULL, name TEXT, Family TEXT, PRIMARY KEY (username) ); ");
            query.exec();

            QSqlQuery query2;
            query2.prepare("CREATE TABLE tbl_contact (name TEXT, family TEXT, phoneNumber TEXT PRIMARY KEY NOT NULL UNIQUE, favority TEXT, gender TEXT );" );
            query2.exec();

            QSqlQuery query3;
            query3.prepare("INSERT INTO `tbl_users`(`username`,`password`,`name`,`family`) VALUES (:user, :pass, :name, :family )");
            query3.bindValue(":user", "09");
            query3.bindValue(":pass", "1");
            query3.bindValue(":name", "John");
            query3.bindValue(":family", "Smit");
            query3.exec();
        }
        return true;
    }
    else
    {
        qDebug() << "ERROR: " << mDatabase.lastError();
        return false;
    }
}

void Connection::closeDatabase()
{
    mDatabase.close();
}

bool Connection::checkUser(const QString& user, const QString& pass)
{
    //    QString query("SELECT COUNT(*) FROM tbl_users WHERE username = '%1' AND password = '%2' ;");
    //    query = query.arg(user).arg(pass);

    //    QSqlQuery q(query);
    //    q.exec();

    //    if(query.next())
    //    {
    //        if(query.value(0).toInt() == 1)
    //            return true;
    //        else
    //            return false;
    //    }

    //    return false;

    //--------------------------------------

    //    QSqlQuery query;
    //    query.prepare("SELECT COUNT(*) FROM tbl_users WHERE username = ? AND password = ? ;");
    //    query.bindValue(0, user);
    //    query.bindValue(1, pass);

    //    query.exec();
    //    qDebug() << "ROW COUNT " << query.numRowsAffected();

    //    if(query.next())
    //    {
    //        if(query.value(0).toInt() == 1)
    //            return true;
    //        else
    //            return false;
    //    }

    //    return false;

    // -------------------------

    //    QSqlDatabase::database().transaction();

    //    QSqlQuery query;
    //    query.prepare("SELECT COUNT(*) FROM tbl_users WHERE username = ? AND password = ? ;");
    //    query.bindValue(0, user);
    //    query.bindValue(1, pass);
    //    query.exec();

    //    QSqlDatabase::database().commit();

    //    if(query.first())
    //    {
    //        if(query.value(0).toInt() == 1)
    //            return true;
    //        else
    //            return false;
    //    }

    //----------------------------------

    QSqlQuery query;

    query.prepare("SELECT name, family FROM tbl_users WHERE username = :usr AND password = :pass ;");
    query.bindValue(":usr", user);
    query.bindValue(":pass", pass);
    query.exec();

    if(query.next())
    {
        emit sigSendProfile(query.value(0).toString(), query.value(1).toString());
        return true;
    }

    return false;
}

void Connection::getSetting()
{
    setting.beginGroup("remmember");
    emit sigGetSetting(setting.value("lastState").toBool(), setting.value("username").toString(), setting.value("password").toString());
    setting.endGroup();
}

void Connection::setSetting(const bool& state, const QString& username, const QString& password)
{
    setting.beginGroup("remmember");
    setting.setValue("lastState", state);
    setting.setValue("username", state ? username : "");
    setting.setValue("password", state ? password : "");
    setting.endGroup();
}

bool Connection::newContact(const QString &name, const QString &family, const QString &phoneNumber, const QString &favority, const QString &gender)
{
    QSqlQuery query;

    query.prepare("INSERT INTO tbl_contact (name, family, phoneNumber, favority, gender) VALUES (:name, :family, :phoneNumber, :favority, :gender);");
    query.bindValue(":name", name);
    query.bindValue(":family", family);
    query.bindValue(":phoneNumber", phoneNumber);
    query.bindValue(":favority", favority);
    query.bindValue(":gender", gender);
    return query.exec();
}

bool Connection::checkContact(const QString& phoneNumber)
{
    QSqlQuery query;

    query.prepare("SELECT name, family, favority, gender FROM tbl_contact WHERE phoneNumber = :phone ;");
    query.bindValue(":phone", phoneNumber);
    query.exec();

    if(query.next())
    {
        emit sigSendOneContact(query.value(0).toString(), query.value(1).toString(), query.value(2).toBool(), query.value(3).toString());
        return true;
    }

    return false;
}

bool Connection::deleteContact(const QString &phoneNumber)
{
    QSqlQuery query;
    query.prepare("Delete FROM tbl_contact WHERE phoneNumber = :phone;");
    query.bindValue(":phone", phoneNumber);

    return query.exec();
}

bool Connection::deleteContactList(const QString &phoneNumber)
{
    QString queryString("Delete FROM tbl_contact WHERE phoneNumber IN (%1) ;");
    queryString = queryString.arg(phoneNumber);

    QSqlQuery query;
    query.prepare(queryString);

    return query.exec();
}

void Connection::contactList()
{
    QSqlQuery query;

    query.prepare("SELECT name, family, phoneNumber, favority, gender FROM tbl_contact ;");
    query.exec();

    m_modelContactList->removeAll();
    while(query.next())
    {
        m_modelContactList->append(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(), query.value(3).toBool(), query.value(4).toString());
    }
}


























