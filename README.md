# UNKAI
雲海プロジェクト

過去のデータを使用して、未来の雲海発生を予想する！

## 使用環境

Ruby ver2.1.5
Rails ver4.2.1

## 環境移植方法

1. データをコピーする

$git clone git@github.com:koji0903/UNKAI.git
$cd UNKAI

2. Gemパッケージインストール

$./bin/bundle install --path=vendor/bundle

3. マイグレート

$./bin/rake db:migrate RAILS_ENV=development

4. secret_key_base

$./bin/bundle exec rake secret

を実行して、出力されたキーを、”SECRET_KEY_BASE”環境変数にセット（.bash_profileとかに）


## 起動

$./bin/rails s

(オプションなしで実行すると、"RAILS_ENV=development")