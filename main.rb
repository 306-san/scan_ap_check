require "./post_message.rb"
scanner = WillowRun::Scanner.new

AP_CH_DATA = {
  "12:34:56:xx:xx:xx": "40"
}



loop do
  ap_data = scanner.scan
  ap_data.each do |ap|
    bssid = ap.data.bssid.split(":").map {|e| e.rjust(2,"0")}.join(":")
    set_ch = AP_CH_DATA[:"#{bssid}"]
    now_ch = ap.data.channel.to_s
    pp ap.data
    if set_ch.nil?
      # AP_CH_DATAのwifiではない
      same_ch_ap_list = AP_CH_DATA.select{|k,v| v=="#{now_ch}"}.keys
      if !same_ch_ap_list.empty? && !same_ch_ap_list.include?(:"#{bssid}") #干渉チェック
        post_slack_ch_interference(now_ch,ap.data.ssid_str.to_s, ap.data.rssi.to_s, ap.data.noise.to_s)
      end
    else
      # AP_CH_DATAのwifi管理下
      if set_ch != now_ch # チャンネルが同じか
        post_slack_ch_change(ap.data.ssid_str.to_s, set_ch, now_ch)
      end
    end
  end
  sleep(10)
end
