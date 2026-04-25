import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: dlg

    modal: true
    width: 320
    height: 160
    anchors.centerIn: parent

    property string titulo: "Aviso"
    property string mensagem: ""

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        spacing: 10

        Label {
            text: dlg.titulo
            font.bold: true
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            height: 10
        }

        Label {
            text: dlg.mensagem
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Item {
            Layout.fillHeight: true
        }

        Button {
            text: "OK"
            focus: true
            Layout.alignment: Qt.AlignHCenter
            onClicked: dlg.close()
            Keys.onReturnPressed: dlg.close()   // ⭐ ENTER
            Keys.onEnterPressed: dlg.close()    // ⭐ ENTER numérico
        }
    }
}
