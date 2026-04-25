#include "confighelper.h"

#include <QCoreApplication>
#include <QDir>
#include <QSettings>
#include <QStandardPaths>

ConfigHelper::ConfigHelper(QObject* parent) : QObject(parent) {}

QString ConfigHelper::getMusicPath() {
  QSettings settings(getConfigFilePath(), QSettings::IniFormat);
  return settings.value("music_path", "").toString();
}

void ConfigHelper::setMusicPath(const QString& path) {
  QSettings settings(getConfigFilePath(), QSettings::IniFormat);
  settings.setValue("music_path", path);
}

QString ConfigHelper::getConfigFilePath() {
  QString dir = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);

  QDir().mkpath(dir);

  return dir + "/cfg.ini";
}