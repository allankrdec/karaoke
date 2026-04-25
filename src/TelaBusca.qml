import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FocusScope {
    id: root

    signal selecionouCodigo(string codigo)

    Component.onCompleted: {
       Qt.callLater(function() {
           txtBusca.forceActiveFocus()
           txtBusca.selectAll()
       })
   }

    Action {
        id: acaoPause
        shortcut: "ESC"
        onTriggered: root.selecionouCodigo("")
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
            spacing: 10

            TextField {
                id: txtBusca
                placeholderText: "Buscar música, artista ou código..."
                Layout.fillWidth: true

                onTextChanged: {
                    listaModel = iniHelper.buscar(text)
                }
            }

            Button {
                text: "Voltar (Esc)"
                onClicked: root.selecionouCodigo("")
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: listaModel

            delegate: Rectangle {
                width: parent.width
                height: 45
                color: index % 2 === 0 ? "#ffffff" : "#eaeaea"

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    color: "black"
                    text: modelData.codigo + " - " + modelData.artista + " - " + modelData.nome
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.selecionouCodigo(modelData.codigo)
                    onEntered: parent.color = "#d0d0d0"
                    onExited: parent.color = index % 2 === 0 ? "#ffffff" : "#eaeaea"
                }
            }
        }
    }

    property var listaModel: []
}