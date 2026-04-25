#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "filehelper.h"
#include "inihelper.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    FileHelper helper;
    engine.rootContext()->setContextProperty("fileHelper", &helper);

    engine.loadFromModule("Karaoke", "Main");

    IniHelper iniHelper;
    engine.rootContext()->setContextProperty("iniHelper", &iniHelper);

    return QCoreApplication::exec();
}


