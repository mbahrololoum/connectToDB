#include "ModelContactList.h"

ModelContactList::ModelContactList(QObject *parent) : QObject(parent)
{}

void ModelContactList::append(const QString name, const QString family, const QString phoneNumber,
                                    const bool favority, const QString gender)
{
    m_personlist.append(new EntityContactList(name, family, phoneNumber, favority, gender));
    emit modelChanged(model());
}

void ModelContactList::removeAll()
{
    if(m_personlist.count() < 1)
        return;

    QList<EntityContactList*>::iterator first = m_personlist.begin();
    QList<EntityContactList*>::iterator last  = m_personlist.end();

    m_personlist.erase(first, last);
    emit modelChanged(model());
}

int ModelContactList::count()
{
    return m_personlist.count();
}
