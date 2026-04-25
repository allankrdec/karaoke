#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "helpers/confighelper.h"
#include "helpers/filehelper.h"
#include "helpers/inihelper.h"

int main(int argc, char* argv[]) {
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

  FileHelper helper;
  engine.rootContext()->setContextProperty("fileHelper", &helper);

  engine.loadFromModule("Karaoke", "FormMain");

  IniHelper iniHelper;
  engine.rootContext()->setContextProperty("iniHelper", &iniHelper);

  ConfigHelper configHelper;
  engine.rootContext()->setContextProperty("configHelper", &configHelper);

  return QCoreApplication::exec();
}
