cmake_minimum_required(VERSION 3.16)

project(Karaoke VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appKaraoke
    src/main.cpp
)

qt_add_qml_module(appKaraoke
    URI Karaoke
    QML_FILES src/ui/FormMain.qml
    QML_FILES src/ui/FormSearch.qml
    QML_FILES src/ui/Formkaraoke.qml
    QML_FILES src/ui/FormConfig.qml
    QML_FILES src/ui/FormMessage.qml

    SOURCES src/helpers/filehelper.h
    SOURCES src/helpers/filehelper.cpp
    SOURCES src/helpers/inihelper.h
    SOURCES src/helpers/inihelper.cpp
    SOURCES src/helpers/confighelper.cpp
    SOURCES src/helpers/confighelper.h

    RESOURCES src/assets/logo.png
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
