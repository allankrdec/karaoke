gera pastas debug-release para o vsCode
cmake -S ./src -B build-debug -DCMAKE_BUILD_TYPE=Debug
cmake -S ./src -B build-release -DCMAKE_BUILD_TYPE=Release