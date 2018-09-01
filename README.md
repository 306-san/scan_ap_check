# scan_ap_check
周囲のAPの状況を見守るRubyプログラム
CHに変更が起きたときとか、CHに新しいAPが出てきたらslackに通知が飛びます

## Usage
post_message.rbにtokenセット
main.rbのSSIDとCHの情報を登録

```
bundle install
bundle exec ruby main.rb
```
