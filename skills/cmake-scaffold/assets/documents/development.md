# 開発ドキュメント

## Requirements

- CMake
- C/C++コンパイラ

## Boostrap

```sh
cmake --preset target
```

## Build

```sh
cmake --build --preset target
```

<!-- テストを有効にする場合は、以下をコメントインする。このコメントは成果物に残さない。

## Test

GoogleTestを有効にしてテストを実行する場合は、以下を実行します。

```sh
cmake --preset target -D<project_name>_BUILD_TESTS=ON
cmake --build --preset target
ctest --test-dir build/target --output-on-failure
```

-->
