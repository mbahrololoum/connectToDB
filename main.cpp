#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include <Model/db/connection.h>
#include <Model/Entity/EntityContactList.h>
#include <Model/Model/ModelContactList.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //    Connection connection;
    //    QQmlContext *context = engine.rootContext();
    //    context->setContextProperty("Connection", &connection);

    qmlRegisterType<Connection>("Company.Connection", 1, 0, "Connection");
    qmlRegisterType<EntityContactList>("EntityContactList", 1, 0, "EntityContactList");
    qRegisterMetaType<ModelContactList*>("ModelContactList*");

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
