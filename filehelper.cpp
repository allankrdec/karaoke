#include "filehelper.h"
#include <QDirIterator>

FileHelper::FileHelper(QObject *parent) : QObject(parent)
{
}

QString FileHelper::buscarArquivo(QString codigo, QString pastaBase)
{
    QDirIterator it(pastaBase,
                    QStringList() << (codigo + ".mp4"),
                    QDir::Files,
                    QDirIterator::Subdirectories);

    if (it.hasNext())
        return it.next();

    return "";
}