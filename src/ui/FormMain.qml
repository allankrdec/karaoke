import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 620 + 60

    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: Formkaraoke {
            onAbrirBusca: {
                var pagina = stack.push("FormSearch.qml");
                pagina.selecionouCodigo.connect(function (codigo) {
                    stack.pop();

                    if (codigo !== "") {
                        stack.currentItem.setCodigo(codigo);
                    }

                    stack.currentItem.focusCodigo();
                });
            }

            onAbrirConfig: {
                // var pagina = stack.push("FormConfig.qml", {
                //     stackView: stack
                // });
                dlgConfig.open();
            }
        }
    }

    Dialog {
        id: dlgConfig
        modal: true
        focus: true
        width: 600
        height: 100
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose

        Loader {
            id: loaderConfig
            anchors.fill: parent
            source: "FormConfig.qml"
            onLoaded: {
                loaderConfig.item.closeDialog.connect(function () {
                    dlgConfig.close();
                });
            }
        }
    }
    FormMessage {
        id: msg
    }
}
