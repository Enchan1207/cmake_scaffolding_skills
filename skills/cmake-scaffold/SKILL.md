---
name: cmake-scaffold
description: CMakeによるビルド構成が整った新規C/C++プロジェクトを作成する。
---

# CMake ビルド構成の作成

実行ファイルまたはライブラリをビルドできる必要最小限のCMake構成を作る。

## 0. 事前準備

以下のコマンドを実行し、生成するCMake構成で使用するバージョンを決定する。取得したバージョンは以降の手順に共通して使用する。

なお、本Skillは `PROJECT_IS_TOP_LEVEL` を使うため、3.21以上が必要である。

```sh
cmake --version
```

cmakeを呼び出すことができない場合は、ユーザに対して「エージェントがCMakeバイナリを見つけられなかった」ことを報告し、終了する。バージョンが3.21未満の場合は、必要なバージョンを伝えて終了する。

## 1. プロジェクト設定の整理

以下の項目について、ユーザから指定されていないものを順番に確認する。

- プロジェクト名: ユーザの指定を優先する。未指定なら、skill呼び出し元のディレクトリ名がCMakeプロジェクト名として利用可能な場合（`[a-zA-Z0-9_]+`）は候補として示す。
- GoogleTestによるテスト: `構成する` / `構成しない`。
- CLI: `構成する` / `構成しない`。CLIを構成しない場合はライブラリのみとする。
- 利用言語: C++コンパイラを利用できる場合は `Cのみ` / `C/C++` から選ぶ。GoogleTestを構成する場合は、`Cのみ` を選んでもテストを有効にする際にC++コンパイラが必要であることを伝える。
- GitHub Actions CI: `構成する` / `構成しない`。未指定なら確認する。

プロジェクト名は単独の入力質問とする。残りの4項目については、選択式の質問ツールが使える場合はそれぞれ明示した選択肢を渡して尋ねる。選択式が使えない場合も、各項目を短い独立した質問として尋ねる。

## 2. 初期ディレクトリの作成

パッケージに以下のようなディレクトリ構造を作成する。`/(root)` はリポジトリルート、あるいはskill呼び出し元のディレクトリを示す。

- `/(root)`
  - `docs`
  - `src`
  - `include/<project_name>`
  - `cli` (CLIを提供する場合のみ)
  - `tests` (テストを構成する場合のみ)
  - `.github/workflows` (GitHub Actions CIを構成する場合のみ)

## 3. 必須ファイルのコピー

以下のファイルをコピーする。 `/(root)` はリポジトリルート、あるいはskill呼び出し元のディレクトリを示す。

- CMake preset
  - ソース: [CMakePresets.json](./assets/sources/CMakePresets.json)
  - 配置先: `/(root)/CMakePresets.json`
  - 置換: `.cmakeMinimumRequired.major`、`.cmakeMinimumRequired.minor`、`.cmakeMinimumRequired.patch` を事前準備で決定したCMakeバージョンの各要素に置き換える。
- Visual Studio Code workspace file
  - ソース: [project_name.code-workspace](./assets/sources/project_name.code-workspace)
  - 配置先: `/(root)/<project_name>.code-workspace`
  - 置換:
    - ファイル名の `project_name` をプロジェクト名に置き換える
    - エントリ `"path": "./tests"` は、テストが有効でなければ追加しない
- gitignore
  - ソース: [gitignore](./assets/sources/gitignore)
  - 配置先: `/(root)/.gitignore`
- root CMakeLists
  - ソース: [CMakeLists.txt](./assets/sources/cmake/root/CMakeLists.txt)
  - 配置先: `/(root)/CMakeLists.txt`
  - 置換: ファイル内の以下の文字列を置き換える
    - `<cmake_version>`: 事前準備で決定したCMakeバージョン
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
  - 置換: `<project_name>` をプロジェクト名に置き換える
- GitHub Actions workflow (GitHub Actions CIを構成する場合のみ)
  - ソース: [ci.yml](./assets/sources/github/workflows/ci.yml)
  - 配置先: `/(root)/.github/workflows/ci.yml`
  - `<cmake_version>` を事前準備で決定したCMakeバージョンに置き換える。
  - テストを構成する場合は、`<test_option>` を ` -D<project_name>_BUILD_TESTS=ON` に置き換え、`<project_name>` をプロジェクト名に置き換える。`ctest` のステップを残す。
  - テストを構成しない場合は、`<test_option>` を空文字列に置き換え、`ctest` のステップを削除する。
  - 生成したworkflowにプレースホルダーを残さない。

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
