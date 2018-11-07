#ifndef ENTITYCONTACTLIST_H
#define ENTITYCONTACTLIST_H

#include <QObject>

class EntityContactList : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    Q_PROPERTY(QString family READ family WRITE setFamily NOTIFY familyChanged)

    Q_PROPERTY(QString phoneNumber READ phoneNumber WRITE setPhoneNumber NOTIFY phoneNumberChanged)

    Q_PROPERTY(bool favority READ favority WRITE setFavority NOTIFY favorityChanged)

    Q_PROPERTY(QString gender READ gender WRITE setGender NOTIFY genderChanged)

    QString m_name;

    QString m_family;

    QString m_phoneNumber;

    bool m_favority;

    QString m_gender;

public:

    explicit EntityContactList(QObject *parent = nullptr);

    EntityContactList(const QString &name , const QString &family, const QString &phoneNumber, const bool &favority, const QString &gender);

    QString name() const
    {
        return m_name;
    }

    QString family() const
    {
        return m_family;
    }

    QString phoneNumber() const
    {
        return m_phoneNumber;
    }

    bool favority() const
    {
        return m_favority;
    }

    QString gender() const
    {
        return m_gender;
    }

signals:

    void nameChanged(QString name);

    void familyChanged(QString family);

    void phoneNumberChanged(QString phoneNumber);

    void favorityChanged(bool favority);

    void genderChanged(QString gender);

public slots:

    void setName(QString name)
    {
        if (m_name == name)
            return;

        m_name = name;
        emit nameChanged(m_name);
    }
    void setFamily(QString family)
    {
        if (m_family == family)
            return;

        m_family = family;
        emit familyChanged(m_family);
    }
    void setPhoneNumber(QString phoneNumber)
    {
        if (m_phoneNumber == phoneNumber)
            return;

        m_phoneNumber = phoneNumber;
        emit phoneNumberChanged(m_phoneNumber);
    }
    void setFavority(bool favority)
    {
        if (m_favority == favority)
            return;

        m_favority = favority;
        emit favorityChanged(m_favority);
    }
    void setGender(QString gender)
    {
        if (m_gender == gender)
            return;

        m_gender = gender;
        emit genderChanged(m_gender);
    }
};

#endif // ENTITYCONTACTLIST_H
