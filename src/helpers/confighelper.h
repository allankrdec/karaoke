#pragma once

#include <QObject>
#include <QString>

class ConfigHelper : public QObject {
  Q_OBJECT
 public:
  explicit ConfigHelper(QObject* parent = nullptr);

  Q_INVOKABLE QString getMusicPath();
  Q_INVOKABLE void setMusicPath(const QString& path);
  Q_INVOKABLE QString getConfigFilePath();
};