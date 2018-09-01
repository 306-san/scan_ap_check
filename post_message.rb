require 'bundler'
require 'slack'
require 'pp'
require 'json'
Bundler.require

TOKEN = 'xoxp-hoge-hoge'

# 取得したTOKENをセット
Slack.configure do |conf|
  conf.token = TOKEN
end

def post_slack_ch_change(ssid, setting_ch, old_ch)
  attachments= {
            "fallback": "Required plain-text summary of the attachment.",
            "color": "danger",
            "pretext": "周囲の電波について異常を検知しました。",
            "title": "APのch変更を検知しました",
            "title_link": "http://192.168.1.1/",
            "text": "担当者は状況を確認し、設定を変更してください。",
            "fields": [
        {
          "title": "SSID",
                    "value": "#{ssid}",
                    "short": false
        },
        {
          "title": "設定時のch",
                    "value": "#{setting_ch}",
                    "short": true
        },
        {
          "title": "現在のch",
                    "value": "#{old_ch}",
                    "short": true
        }
            ]
  }
  begin
    result = Slack.chat_postMessage text: " ", attachments: [attachments], channel: "#test_bot", username: "Wifiを見守る梨子ちゃん", as_user: false
    pp result
  rescue => e
    puts "[Error:] #{Time.now}エラーが発生しました"
    puts %Q(class=[#{e.class}] message=[#{e.message}])
    sleep(5)
  end
end

def post_slack_ch_interference(now_ch, ssid, rssi, noise)
  attachments= {
            "fallback": "Required plain-text summary of the attachment.",
            "color": "warning",
            "pretext": "周囲の電波について異常を検知しました。",
            "title": "設定済みチャンネルにおいて新たなAPを検出しました",
            "title_link": "http://192.168.1.1/",
            "text": "チャンネル干渉の可能性があります。担当者は状況を確認してください。",
            "fields": [
                {
          "title": "ch",
                    "value": "#{now_ch}",
                    "short": true
        },
        {
          "title": "SSID",
                    "value": "#{ssid}",
                    "short": true
        },
        {
          "title": "RSSI",
                    "value": "#{rssi}",
                    "short": true
        },
        {
          "title": "ノイズ",
                    "value": "#{noise}",
                    "short": true
        }
            ]
  }
  begin
    result = Slack.chat_postMessage text: " ", attachments: [attachments], channel: "#test_bot", username: "Wifiを見守る梨子ちゃん", as_user: false

  rescue => e
    puts "[Error:] #{Time.now}エラーが発生しました"
    puts %Q(class=[#{e.class}] message=[#{e.message}])
    sleep(5)
  end
end

# ファイル単体で呼び出されたときの処理
if __FILE__ == $0
  hoge = post_slack_ch_change("test-ssid","40","36")
  p hoge
  sleep(2)
  hoge = post_slack_ch_interference("60","test_ssid","-77", "10")
  p hoge
end
