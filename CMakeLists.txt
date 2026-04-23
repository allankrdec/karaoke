cmake_minimum_required(VERSION 3.16)

project(Karaoke VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appKaraoke
    main.cpp
)

qt_add_qml_module(appKaraoke
    URI Karaoke
    QML_FILES
        Main.qml
        SOURCES filehelper.h
        SOURCES filehelper.cpp
        SOURCES musica.h
        SOURCES inihelper.h
        SOURCES inihelper.cpp
        QML_FILES TelaBusca.qml
        QML_FILES TelaPrincipal.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appKaraoke PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appKaraoke
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appKaraoke
    PRIVATE Qt6::Quick
)

install(TARGETS appKaraoke
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
