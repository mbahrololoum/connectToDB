#ifndef MODELCONTACTLIST_H
#define MODELCONTACTLIST_H

#include <QObject>

#include "qquicklist.h"
#include "../entity/EntityContactList.h"

class ModelContactList : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QObjectListModel * model READ model NOTIFY modelChanged)

    Q_PROPERTY(QQmlListProperty<EntityContactList> listProperty READ listProperty NOTIFY modelChanged)

    QObjectListModel * m_model;

    QQmlListProperty<EntityContactList> m_listProperty;

public:

    explicit ModelContactList(QObject *parent = nullptr);

    QObjectListModel * model() { return m_personlist.getModel(); }

    QQmlListProperty<EntityContactList> listProperty() { return QQmlListProperty<EntityContactList>(this,m_personlist); }

signals:

    void modelChanged(QObjectListModel * model);

public slots:

    void append(const QString name, const QString family, const QString phoneNumber, const bool favority, const QString gender);

    void removeAll();

    int count();

private:

    QQuickList<EntityContactList> m_personlist;
};

#endif // MODELCONTACTLIST_H
