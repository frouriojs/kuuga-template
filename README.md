# KUUGA Template

宇宙スケールの知の保存を目的としたプロトコル「KUUGA」のプロジェクトテンプレートです。論文をMarkdownとJSONで管理し、IPFSへの公開と永続化を支援します。

## 特徴

- MarkdownとJSONによるシンプルな論文管理
- Gitでのバージョン管理を前提
- IPFSネットワークに論文と引用先の自動ピン留め
- GitHub Actions による自動ビルド

## 使用方法

### 1. Node.jsのインストール

https://nodejs.org

### 2. Gitのクローンとパッケージのインストール

```sh
$ git clone https://github.com/frouriojs/kuuga-template.git
$ cd kuuga-template
$ npm install
```

### 3. 新しい原稿ディレクトリの追加

`[論文ディレクトリ名]`はIPFSへの公開結果に影響を与えず、後から変更できます。

```bash
npm run add [論文ディレクトリ名]
```

### 4. 構成ファイルの検証

```bash
npm run validate
```

### 5. 論文のビルド

```bash
npm run build
```

## プロジェクト構成

```
/
├── Dockerfile                    # IPFSノード用
├── .github/workflows/build-papers.yml  # 自動ビルド設定
├── drafts/                       # 原稿ディレクトリ
│   └── [論文ディレクトリ名]/
│       ├── main.md              # 本文（Markdown）
│       ├── meta.json            # 論文のメタ情報
│       └── README.md            # 論文用README
├── papers/                       # ビルド済み論文
│   └── [論文ディレクトリ名]/
│       └── [バージョン]_[CID]/
│           ├── main.md
│           ├── meta.json
│           └── README.md
└── package.json
```

## 自動公開とピン留め

- `main`ブランチへのPushで、GitHub Actionsが差分を検知して論文ディレクトリを自動生成・コミット
- Dockerコンテナを使用してIPFSノードを起動し、論文と引用先を自動ピン留め
- Dockerコンテナから https://kuuga.io に公開通知を送信し、数分で`https://kuuga.io/papers/{CID}`と`https://kuuga.io/ipfs/{CID}`にも公開される

この仕組みにより、引用関係が壊れないようネットワーク全体での保存努力が促進されます。

## 依存関係

- [kuuga-cli](https://www.npmjs.com/package/kuuga-cli)
