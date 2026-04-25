#Gera pastas debug-release para o vsCode
cmake -S . -B build-debug -DCMAKE_BUILD_TYPE=Debug
cmake -S . -B build-release -DCMAKE_BUILD_TYPE=Release


#Plugins do vsCode
CodeLLDB
C/C++ Extension Pack
CMake Tools
Qt QML

#variaveis para exportar
export CMAKE_PREFIX_PATH=~/Qt/6.11.0/macos

echo 'export CMAKE_PREFIX_PATH=~/Qt/6.11.0/macos' >> ~/.zshrc
source ~/.zshrc

#dependencias
brew install cmake