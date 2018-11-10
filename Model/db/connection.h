#ifndef CONNECTION_H
#define CONNECTION_H

#include <QDebug>
#include <QObject>
#include <QVariant>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QStandardPaths>
#include <QSettings>

#include "../Model/ModelContactList.h"
#include "../Entity/EntityContactList.h"

class Connection : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ModelContactList* modelContactList READ modelContactList WRITE setModelContactList NOTIFY modelContactListChanged)

public:

    explicit Connection(QObject *parent = nullptr);
    ~Connection();
    bool openDatabase();
    void closeDatabase();
    Q_INVOKABLE bool checkUser(const QString& user, const QString& pass);
    Q_INVOKABLE void getSetting();
    Q_INVOKABLE void setSetting(const bool& state, const QString& username, const QString& password);
    Q_INVOKABLE bool newContact(const QString& name, const QString& family, const QString& phoneNumber, const QString& favority, const QString& gender);
    Q_INVOKABLE bool checkContact(const QString& phoneNumber);
    Q_INVOKABLE bool deleteContact(const QString& phoneNumber);
    Q_INVOKABLE bool deleteContactList(const QString& phoneNumber);
    Q_INVOKABLE void contactList();

    ModelContactList* modelContactList() const
    {
        return m_modelContactList;
    }

signals:

    void sigSendProfile(QString name, QString family);
    void sigSendOneContact(QString name, QString family, bool favority, QString gender);
    void sigGetSetting(bool lastState, QString username, QString password);
    void modelContactListChanged(ModelContactList* modelContactList);

public slots:

void setModelContactList(ModelContactList* modelContactList)
{
    if (m_modelContactList == modelContactList)
        return;

    m_modelContactList = modelContactList;
    emit modelContactListChanged(m_modelContactList);
}

private:

    QSqlDatabase mDatabase;
    QString dbLocation;
    ModelContactList* m_modelContactList;
    QSettings setting;
};

#endif // CONNECTION_H
