#include "EntityContactList.h"

EntityContactList::EntityContactList(QObject *parent) : QObject(parent)
{
}

EntityContactList::EntityContactList(const QString& name, const QString& family, const QString& phoneNumber,
                                     const bool& favority, const QString& gender)
    : m_name(name), m_family(family), m_phoneNumber(phoneNumber), m_favority(favority), m_gender(gender)
{

}

