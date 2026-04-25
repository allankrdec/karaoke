import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 828
    color: "black"

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: TelaPrincipal {
            onAbrirBusca: {
                var pagina = stack.push("TelaBusca.qml")
                pagina.selecionouCodigo.connect(function(codigo) {
                    stack.pop()

                    if (codigo !== "") {
                        stack.currentItem.setCodigo(codigo)
                    }

                    stack.currentItem.focusCodigo()
                })
            }
        }
    }
}