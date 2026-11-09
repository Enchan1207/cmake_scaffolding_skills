---
name: cmake-scaffold
description: CMakeによるビルド構成が整った新規C/C++プロジェクトを作成する。
---

# CMake ビルド構成の作成

実行ファイルまたはライブラリをビルドできる必要最小限のCMake構成を作る。

## 0. 事前準備

以下のコマンドを実行し、CMakeのバージョンを取得しておく。

```sh
cmake --version
```

cmakeを呼び出すことができない場合は、ユーザに対して「エージェントがCMakeバイナリを見つけられなかった」ことを報告し、終了する。

## 1. プロジェクト設定の整理

作成するプロジェクトについて、以下を検討する。暫定値を整理したのち、ユーザに尋ねる。

- プロジェクト名: ユーザによる指示がなければ、以下から選択する
  - このskillの呼び出し元ディレクトリ名がCMakeプロジェクトとして利用可能ならば(`[a-zA-Z0-9_]+`)、それを検討する。
- 利用言語: ユーザによる指示がなければ、以下から選択する
  - Cのみ
  - C/C++
- プロジェクト形態: ユーザによる指示がなければ、以下から選択する
  - ライブラリのみ
  - ライブラリ+CLI
- GoogleTestによるテスト: 構成するかどうかを選択する。GoogleTestはC++を必要とするため、利用言語で `Cのみ` を選択していた場合は _C++が言語として追加される旨_ をユーザに伝える。

## 2. 初期ディレクトリの作成

パッケージに以下のようなディレクトリ構造を作成する。`/(root)` はリポジトリルート、あるいはskill呼び出し元のディレクトリを示す。

- `/(root)`
  - `docs`
  - `src`
  - `include/<project_name>`
  - `cli` (CLIを提供する場合のみ)
  - `tests` (テストを構成する場合のみ)

## 3. 必須ファイルのコピー

以下のファイルをコピーする。 `/(root)` はリポジトリルート、あるいはskill呼び出し元のディレクトリを示す。

- CMake preset
  - ソース: [CMakePresets.json](./assets/sources/CMakePresets.json)
  - 配置先: `/(root)/CMakePresets.json`
  - 置換:
    - 以下をCMakeバージョンに合わせて置き換える
      - `.cmakeMinimumRequired.major`
      - `.cmakeMinimumRequired.minor`
      - `.cmakeMinimumRequired.patch`
- root CMakeLists
  - ソース: [CMakeLists.txt](./assets/sources/cmake/root/CMakeLists.txt)
  - 配置先: `/(root)/CMakeLists.txt`
  - 置換: ファイル内の以下の文字列を置き換える
    - `<cmake_version>`: インストールされているCMakeのバージョン
    - `<project_name>`: プロジェクト名
    - `<language>`: `C` または `C CXX`
  - CLIやテストを構成する場合は、対応するコメントアウトされたブロックを有効にし、案内用の行を成果物から削除する。
- root include file
  - ソース: [project_name.h](./assets/sources/headers/project_name.h)
  - 配置先: `/(root)/include/<project_name>/<project_name>.h`
  - 置換: ファイル内の以下の文字列を置き換える
    - `INCLUDE_GUARD`: `<PROJECT_NAME>_H` (`project_name` をUPPER_CASEにしたもの)
- library CMakeLists
  - ソース: [CMakeLists.txt](./assets/sources/cmake/src/CMakeLists.txt)
  - 配置先: `/(root)/src/CMakeLists.txt`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- library source
  - ソース: [func.c](./assets/sources/src/func.c)
  - 配置先: `/(root)/src/func.c`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- CLI CMakeLists (CLIを提供する場合のみ)
  - ソース: [CMakeLists.txt](./assets/sources/cmake/cli/CMakeLists.txt)
  - 配置先: `/(root)/cli/CMakeLists.txt`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- CLI entry point (CLIを提供する場合のみ)
  - ソース: [main.c](./assets/sources/cli/main.c)
  - 配置先: `/(root)/cli/main.c`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- test CMakeLists (テストを構成する場合のみ)
  - ソース: [CMakeLists.txt](./assets/sources/cmake/tests/CMakeLists.txt)
  - 配置先: `/(root)/tests/CMakeLists.txt`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- factorial test (テストを構成する場合のみ)
  - ソース: [test_factorial.cpp](./assets/sources/tests/test_factorial.cpp)
  - 配置先: `/(root)/tests/test_factorial.cpp`
  - 置換: `<project_name>` をプロジェクト名に置き換える
- development document
  - ソース: [development.md](./assets/documents/development.md)
  - 配置先: `/(root)/docs/development.md`
  - 置換: なし。

## 4. ビルド確認

rootのCMakeLists.txtが配置されているディレクトリで以下のコマンドを実行し、完了することを確認する。

```sh
cmake --preset target
cmake --build --preset target
```

テストを構成した場合は、テストを有効にしてビルド・実行する。

```sh
cmake --preset target -D<project_name>_BUILD_TESTS=ON
cmake --build --preset target
ctest --test-dir build/target --output-on-failure
```
