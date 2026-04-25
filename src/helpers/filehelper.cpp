#include "filehelper.h"

#include <QDirIterator>

#include "confighelper.h"

FileHelper::FileHelper(QObject* parent) : QObject(parent) {}

QString FileHelper::buscarArquivo(QString codigo) {
  ConfigHelper configHelper;

  QString pastaBase = configHelper.getMusicPath();
  if (pastaBase == "") {
    configHelper.setMusicPath("/musicas");
  }

  QDirIterator it(pastaBase, QStringList() << (codigo + ".mp4"), QDir::Files,
                  QDirIterator::Subdirectories);

  if (it.hasNext())
    return it.next();

  return "";
}