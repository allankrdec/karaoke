import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

FocusScope {
    id: root
    signal closeDialog
    property var stackView

    FolderDialog {
        id: folderDialog
        title: "Selecionar pasta de músicas"

        onAccepted: {
            txtMusicPath.text = selectedFolder.toString().replace("file://", "");
        }
    }

    Component.onCompleted: {
        Qt.callLater(function () {
            txtMusicPath.forceActiveFocus();
            // txtMusicPath.selectAll();
            txtMusicPath.text = configHelper.getMusicPath();
        });
    }

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"
        z: -1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 3

            Label {
                text: "Pasta das músicas"
                font.pixelSize: 16     // tamanho (recomendado)
                font.bold: true        // negrito
                font.italic: false     // itálico (opcional)
                // font.family: "Arial"
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: txtMusicPath
                readOnly: true
                placeholderText: "Pasta de músicas"
                Layout.fillWidth: true
            }

            Button {
                text: "🔍"
                onClicked: folderDialog.open()
            }

            Button {
                text: "Salvar"
                onClicked: {
                    configHelper.setMusicPath(txtMusicPath.text);
                    closeDialog();
                }
            }
            Button {
                text: "Voltar"
                onClicked: closeDialog()
            }
        }
    }
}
