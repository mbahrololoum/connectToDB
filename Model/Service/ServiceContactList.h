#ifndef SERVICESEARCHNEARBYSTORE_H
#define SERVICESEARCHNEARBYSTORE_H

#include <QTimer>
#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "model/da/JsonNetworkHandler.h"
#include "model/model/ModelSearchNearByStore.h"
#include "model/model/qObjectItemModel.h"
#include "model/model/qQuickItem.h"

class ServiceSearchNearByStore : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ModelSearchNearByStore* modelSearchNearByStore READ modelSearchNearByStore
               WRITE setModelSearchNearByStore NOTIFY modelSearchNearByStoreChanged)

    Q_PROPERTY(QObjectItemModel* qqObjectItemModel READ qqObjectItemModel
               WRITE setQqObjectItemModel NOTIFY qqObjectItemModelChanged)

    JsonNetworkHandler* o_JsonNetworkHandler;

    ModelSearchNearByStore* m_modelSearchNearByStore;

    QObjectItemModel *m_qqObjectItemModel;

public:

    explicit ServiceSearchNearByStore(QObject *parent = nullptr);

    ~ServiceSearchNearByStore();

    ModelSearchNearByStore* modelSearchNearByStore() const
    {
        return m_modelSearchNearByStore;
    }

    QObjectItemModel* qqObjectItemModel() const
    {
        return m_qqObjectItemModel;
    }

    QString functionName;

signals:

    void rejectServer();

    void sigGetResponce();

    void signalTimeOut();

    void sigEmptySearchNearBy();

    void sigSuccessfullyMapResponce();

    void modelSearchNearByStoreChanged(ModelSearchNearByStore* modelSearchNearByStore);

    void qqObjectItemModelChanged(QObjectItemModel* qqObjectItemModel);

public slots:

    void request(const QString type, const QString category , const QString centerLat , const QString centerLng , const bool refreshList);

    void searchRequest(const QString searchField);

    void response(QJsonArray *answer);

    void timerTimeOut();

    void setModelSearchNearByStore(ModelSearchNearByStore* modelSearchNearByStore)
    {
        if (m_modelSearchNearByStore == modelSearchNearByStore)
            return;

        m_modelSearchNearByStore = modelSearchNearByStore;
        emit modelSearchNearByStoreChanged(m_modelSearchNearByStore);
    }

    void setQqObjectItemModel(QObjectItemModel* qqObjectItemModel)
    {
        if (m_qqObjectItemModel == qqObjectItemModel)
            return;

        m_qqObjectItemModel = qqObjectItemModel;
        emit qqObjectItemModelChanged(m_qqObjectItemModel);
    }

private:

    QTimer* timer;
};

#endif // SERVICESEARCHNEARBYSTORE_H
