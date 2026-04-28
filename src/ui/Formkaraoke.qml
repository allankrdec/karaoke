import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Dialogs

Item {
    id: root

    signal abrirBusca
    signal abrirConfig
    property var playlist: []

    property int playlistIndex: -1
    property int playlistCount: 0
    property bool tocandoPlaylist: false
    property bool musicaCarregada: false

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
            anchors.bottom: buttonBar.top
        }

        VideoOutput {
            id: videoView
            anchors.fill: areaVideo
            fillMode: VideoOutput.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: videoView   // ⭐ cobre o vídeo
            onClicked: {
                if (player.playbackState === MediaPlayer.PlayingState) {
                    player.pause();
                } else {
                    player.play();
                }
            }
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
                spacing: 35

                RowLayout {
                    spacing: 5

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

                RowLayout {
                    spacing: 5
                    // Layout.alignment: Qt.AlignVCenter

                    Button {
                        text: "🎵 Playlist"
                        // onClicked: carregarPlaylist()
                        onClicked: fileDialog.open()
                    }

                    Button {
                        enabled: root.tocandoPlaylist && root.playlistIndex > 0
                        text: " < "
                        onClicked: {
                            root.playPrior();
                        }
                    }
                    Button {
                        enabled: root.tocandoPlaylist && root.playlistIndex < root.playlistCount - 1
                        text: " > "
                        onClicked: {
                            root.playNext();
                        }
                    }

                    Label {
                        visible: root.playlistCount > 0
                        text: root.playlistIndex + "/" + root.playlistCount
                    }

                    Button {
                        text: "Parar Playlist"
                        onClicked: {
                            tocandoPlaylist = false;
                            root.stop();
                            txtCodigo.text = "";
                        }
                    }
                }

                RowLayout {
                    spacing: 50
                    // anchors.left: parent.left

                    Button {
                        text: "⚙️"
                        visible: !musicaCarregada
                        onClicked: root.abrirConfig()
                    }
                }
            }
        }
    }

    MediaPlayer {
        id: player
        audioOutput: AudioOutput {}
        onPositionChanged: {
            if (duration > 0 && position >= duration) {
                if (tocandoPlaylist) {
                    tocarProxima();
                } else {
                    player.stop();
                    musicaCarregada = false;
                    txtCodigo.focus = true;
                }
            }
        }
        videoOutput: videoView
    }

    FileDialog {
        id: fileDialog
        title: "Selecionar playlist"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Arquivos de texto (*.txt)"]

        onAccepted: {
            root.carregarPlaylist(selectedFile.toString().replace("file://", ""));
        }
    }

    //functions

    function setCodigo(codigo) {
        txtCodigo.text = codigo;
        buscarETocar();
    }

    function carregarPlaylist(filePath) {
        var lista = fileHelper.lerPlaylist(filePath);
        playlist = lista;
        playlistIndex = -1;
        tocandoPlaylist = true;
        playlistCount = lista.length;

        playNext();
    }

    function playNext() {
        if (playlistIndex >= playlist.length - 1) {
            // tocandoPlaylist = false;
            return;
        }

        playlistIndex++;
        var codigo = playlist[playlistIndex];

        txtCodigo.text = codigo;
        buscarETocar(true);
    }

    function playPrior() {
        if (playlistIndex <= 0) {
            // tocandoPlaylist = false;
            return;
        }
        playlistIndex--;

        var codigo = playlist[playlistIndex];

        txtCodigo.text = codigo;
        buscarETocar(true);
    }

    function focusCodigo() {
        txtCodigo.focus = true;
    }

    function buscarETocar(tocar = false) {
        var caminho = fileHelper.buscarArquivo(txtCodigo.text);

        if (caminho !== "") {
            player.source = "file:///" + caminho;
            if (tocar)
                player.play();
            else
                player.pause();
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
            // txtCodigo.text = "";
            txtCodigo.focus = true;
        }
    }
}
