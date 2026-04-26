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

QStringList FileHelper::lerPlaylist(const QString& caminho) {
  QFile file(caminho);
  QStringList lista;

  if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
    QTextStream in(&file);
    while (!in.atEnd()) {
      QString linha = in.readLine().trimmed();
      if (!linha.isEmpty())
        lista.append(linha);
    }
  }

  return lista;
}