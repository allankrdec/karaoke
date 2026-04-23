#include "inihelper.h"
#include <QSettings>

IniHelper::IniHelper(QObject *parent) : QObject(parent)
{
}

QVariantList IniHelper::buscar(QString termo)
{
    QVariantList lista;

    QSettings ini("/Volumes/HDSecundario/karaoke/musicas.ini", QSettings::IniFormat);
    // ini.setIniCodec("UTF-8");

    QStringList grupos = ini.childGroups();

    for (const QString &grupo : grupos)
    {
        ini.beginGroup(grupo);

        QString artista = ini.value("artista").toString();
        QString nome = ini.value("musica").toString();
        QString arquivo = ini.value("arquivo").toString();

        QString texto = artista + " " + nome + " " + grupo;

        if (texto.toLower().contains(termo.toLower()))
        {
            QVariantMap item;
            item["codigo"] = grupo;
            item["artista"] = artista;
            item["nome"] = nome;
            item["arquivo"] = arquivo;

            lista.append(item);
        }

        ini.endGroup();
    }

    return lista;
}