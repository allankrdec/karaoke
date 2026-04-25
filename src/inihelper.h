#ifndef INIHELPER_H
#define INIHELPER_H

#include <QObject>
#include <QVariantList>

class IniHelper : public QObject
{
    Q_OBJECT
public:
    explicit IniHelper(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList buscar(QString termo);
};

#endif