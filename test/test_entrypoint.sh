#!/bin/bash

set -e

# モック用のbwsコマンドを作成
export PATH="$PWD/test/mocks:$PATH"
mkdir -p test/mocks

cat <<EOF > test/mocks/bws
#!/bin/bash
if [[ "\$1" == "secret" && "\$2" == "list" ]]; then
  echo '[{"id":"id1","name":"SECRET1"},{"id":"id2","name":"SECRET2"}]'
elif [[ "\$1" == "secret" && "\$2" == "get" ]]; then
  if [[ "\$3" == "id1" ]]; then
    echo "value1"
  elif [[ "\$3" == "id2" ]]; then
    echo "value2"
  fi
fi
EOF
chmod +x test/mocks/bws

# GITHUB_ENVのモック
export GITHUB_ENV=$(mktemp)

# テスト対象スクリプトを実行
../entrypoint.sh "dummy_token"

# 結果検証
grep -q "SECRET1=value1" "$GITHUB_ENV"
grep -q "SECRET2=value2" "$GITHUB_ENV"

echo "テスト成功"