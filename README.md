# scan_ap_check
周囲のAPの状況を見守るRubyプログラム
CHに変更が起きたときとか、CHに新しいAPが出てきたらslackに通知が飛びます

## Usage
※使っているgemの関係上macOSでしか動きません
post_message.rbにtokenセット
main.rbのSSIDとCHの情報を登録

```
bundle install
bundle exec ruby main.rb
```

後は、よしなにに設定すればこんな感じにslackに飛んでくれるはず・・・
![image](https://user-images.githubusercontent.com/8838979/44945541-9fee8780-ae26-11e8-8fbb-5d8c34601d3c.png)
