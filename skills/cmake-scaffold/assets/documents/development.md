# 開発ドキュメント

## Requirements

- CMake
- C/C++コンパイラ

## 手順

以下のコマンドでプロジェクトを構成します。

```sh
cmake --preset target
```

以下のコマンドでプロジェクトをビルドします。

```sh
cmake --build --preset target
```

<!-- テストを有効にする場合は、以下をコメントインする。このコメントは成果物に残さない。

GoogleTestを有効にしてテストを実行する場合は、以下を実行します。

```sh
cmake --preset target -Dcmake_scaffold_test_BUILD_TESTS=ON
cmake --build --preset target
ctest --test-dir build/target --output-on-failure
```

-->
