#include "ServiceSearchNearByStore.h"

ServiceSearchNearByStore::ServiceSearchNearByStore(QObject *parent) : QObject(parent)
{
    timer = new QTimer;
    timer->setSingleShot(true);

    //Create model
    m_modelSearchNearByStore = new ModelSearchNearByStore();
    m_qqObjectItemModel = new QObjectItemModel();

    //Create connection
    o_JsonNetworkHandler = new JsonNetworkHandler();
    //connect(o_JsonNetworkHandler, SIGNAL(signalSearchNearByStoreResponse(QJsonArray*)), this, SLOT(response(QJsonArray*)));

    //Handle server not responding
    connect(o_JsonNetworkHandler, SIGNAL(signalServerError()),this, SIGNAL(rejectServer()));
}

ServiceSearchNearByStore::~ServiceSearchNearByStore()
{
    delete m_modelSearchNearByStore;
    delete m_qqObjectItemModel;
    delete o_JsonNetworkHandler;
}

void ServiceSearchNearByStore::request(const QString type,const QString category, const QString centerLat, const QString centerLng, const bool refreshList)
{
    m_qqObjectItemModel->removeData();

    if(!refreshList)
        m_modelSearchNearByStore->removeAll();

    functionName = "searchNearby";

    QJsonObject qJsonObject;
    qJsonObject.insert("functionName", "searchNearby");

    QJsonObject dataObject;
    dataObject.insert("type", type);
    dataObject.insert("category", category);
    dataObject.insert("search", "N");
    dataObject.insert("centerLat", centerLat);
    dataObject.insert("centerLng", centerLng);
    qJsonObject.insert("data",dataObject);

    QJsonDocument qJsonDocument(qJsonObject);
    QString  address = "/search/nearby";

    o_JsonNetworkHandler->sendRequest(qJsonDocument, address);

    connect(o_JsonNetworkHandler, SIGNAL(signalSearchNearByStoreResponse(QJsonArray*)), this, SLOT(response(QJsonArray*)));

    connect(timer, SIGNAL(timeout()), this, SLOT(timerTimeOut()));
    timer->start(JsonNetworkHandler::timerInterval);
}

void ServiceSearchNearByStore::timerTimeOut()
{
    timer->stop();
    disconnect(o_JsonNetworkHandler, SIGNAL(signalSearchNearByStoreResponse(QJsonArray*)), this, SLOT(response(QJsonArray*)));
    emit signalTimeOut();
    disconnect(timer, SIGNAL(timeout()), this, SLOT(timerTimeOut()));
}

void ServiceSearchNearByStore::searchRequest(const QString searchField)
{
    functionName = "searchStoreList";

    QJsonObject qJsonObject;
    qJsonObject.insert("functionName", "searchStoreList");
    qJsonObject.insert("data", searchField);

    QJsonDocument qJsonDocument(qJsonObject);
    QString  address = "/search/getSuggestedLocation";

    m_modelSearchNearByStore->removeAll();
    o_JsonNetworkHandler->sendRequest(qJsonDocument,address);

    connect(o_JsonNetworkHandler, SIGNAL(signalSearchNearByStoreResponse(QJsonArray*)), this, SLOT(response(QJsonArray*)));

    connect(timer, SIGNAL(timeout()), this, SLOT(timerTimeOut()));
    timer->start(JsonNetworkHandler::timerInterval);
}

void ServiceSearchNearByStore::response(QJsonArray *answer)
{
    timer->stop();

    m_modelSearchNearByStore->removeAll();

    emit sigSuccessfullyMapResponce();

      qDebug() << "11111111111111   " << *answer ;
    if (functionName == "searchNearby" ) {

        m_qqObjectItemModel->removeData();

        foreach (const QJsonValue & value, *answer) {
            QJsonObject obj = value.toObject();
            // This Code For Karabkari Seyed Mohammadi
            QJsonArray galleryArray = obj["gallery"].toArray();
            QJsonValue galleryFirstValue = galleryArray[0].toString();

            m_modelSearchNearByStore->append(obj["id"].toInt(), obj["category"].toString(), obj["title"].toString(),
                    obj["location"].toString(), obj["type"].toString(), obj["type_icon"].toString(),
                    obj["latitude"].toString(), obj["longitude"].toString(), obj["rating"].toInt(),
                    obj["color"].toString(), obj["description"].toString(), galleryFirstValue.toString(),
                    obj["features"].toString());

            // add info for map
            m_qqObjectItemModel->addData(qQuickItem(obj["title"].toString(), obj["longitude"].toString(), obj["latitude"].toString(),
                    obj["color"].toString(), obj["type_icon"].toString(), galleryFirstValue.toString(), obj["description"].toString(),
                    obj["rating"].toInt(), obj["location"].toString(), obj["id"].toInt()));
        }
    }
    else if (functionName == "searchStoreList"){
        foreach (const QJsonValue & value, *answer) {
            QJsonObject obj = value.toObject();
            m_modelSearchNearByStore->appendSearch(obj["id"].toInt(), obj["value"].toString(),
                    obj["address"].toString(),obj["rate"].toInt(), obj["smallImagePath"].toString());
        }
    }

    if (m_modelSearchNearByStore->count() < 1)
        emit sigEmptySearchNearBy();
    else
        emit sigGetResponce();

    disconnect(o_JsonNetworkHandler, SIGNAL(signalSearchNearByStoreResponse(QJsonArray*)), this, SLOT(response(QJsonArray*)));

}
