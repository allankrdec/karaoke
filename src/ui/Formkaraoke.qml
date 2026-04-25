import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root

    signal abrirBusca
    signal abrirConfig

    property bool musicaCarregada: false

    function setCodigo(codigo) {
        txtCodigo.text = codigo;
        buscarETocar();
    }

    function focusCodigo() {
        txtCodigo.focus = true;
    }

    Action {
        id: acaoBuscar
        shortcut: "F1"
        enabled: stack.depth === 1
        onTriggered: abrirBusca()
    }

    Action {
        id: acaoPlay
        shortcut: "F5"
        enabled: stack.depth === 1
        onTriggered: play()
    }

    Action {
        id: acaoPause
        shortcut: "F6"
        enabled: stack.depth === 1
        onTriggered: pause()
    }

    Action {
        id: acaoStop
        shortcut: "F7"
        enabled: stack.depth === 1
        onTriggered: stop()
    }

    Item {
        anchors.fill: parent

        Item {
            id: areaVideo
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: buttonBar.top   // ⭐ desconta a barra
        }

        // VideoOutput {
        //     id: videoView
        //     anchors.fill: parent
        //     fillMode: VideoOutput.PreserveAspectFit
        // }

        VideoOutput {
            id: videoView
            anchors.fill: areaVideo
            fillMode: VideoOutput.PreserveAspectFit
        }

        Rectangle {
            color: musicaCarregada ? '#000000' : '#bdbdbd'
            anchors.fill: parent
            z: -1

            Image {
                anchors.centerIn: parent
                source: "../assets/logo.png"
                Layout.maximumWidth: 500
                Layout.fillWidth: true
            }
        }

        Rectangle {
            id: buttonBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 60
            z: 100

            RowLayout {
                anchors.centerIn: parent
                spacing: 10

                TextField {
                    id: txtCodigo
                    width: 120

                    placeholderText: "Código"
                    focus: true
                    Component.onCompleted: {
                        forceActiveFocus();
                        selectAll();
                    }
                    visible: !musicaCarregada

                    onAccepted: buscarETocar()
                }

                Button {
                    text: "🔍(F1)"
                    visible: !musicaCarregada
                    onClicked: root.abrirBusca()
                }

                Button {
                    text: "Config"
                    visible: !musicaCarregada
                    onClicked: root.abrirConfig()
                }

                // Button {
                //     text: "Buscar"
                //     visible: !musicaCarregada
                //     onClicked: buscarETocar()
                // }

                Button {
                    text: "Play (F5)"
                    enabled: player.playbackState !== MediaPlayer.PlayingState
                    visible: musicaCarregada
                    onClicked: play()
                }

                Button {
                    text: "Pause (F6)"
                    enabled: player.playbackState === MediaPlayer.PlayingState
                    visible: musicaCarregada
                    onClicked: pause()
                }

                Button {
                    text: "Stop (F7)"
                    enabled: player.playbackState !== MediaPlayer.StoppedState
                    visible: musicaCarregada
                    onClicked: stop()
                }
            }
        }
    }

    MediaPlayer {
        id: player
        audioOutput: AudioOutput {}
        videoOutput: videoView
    }

    function buscarETocar() {
        var caminho = fileHelper.buscarArquivo(txtCodigo.text
        // "/Volumes/HDSecundario/karaoke/musicas"
        );

        if (caminho !== "") {
            player.source = "file:///" + caminho;
            player.play();
            musicaCarregada = true;
        } else {
            msg.titulo = "Erro";
            msg.mensagem = "Música não encontrada";
            msg.open();
        }
    }

    function play() {
        if (player.playbackState !== MediaPlayer.PlayingState) {
            player.play();
        }
    }

    function pause() {
        if (player.playbackState === MediaPlayer.PlayingState) {
            player.pause();
        }
    }

    function stop() {
        if (player.playbackState !== MediaPlayer.StoppedState) {
            player.stop();
            musicaCarregada = false;
            txtCodigo.text = "";
            txtCodigo.focus = true;
        }
    }
}
