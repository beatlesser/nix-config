{
  host,
  ...
}:
{
  networking = {
    hostName = "${host}";
    enableIPv6 = true;
    networking.timeServers = [
      "ntp.aliyun.com" # Aliyun NTP Server
      "ntp.tencent.com" # Tencent NTP Server
    ];
    networkmanager = {
      enable = true;
    };
    hosts = {
      # 本机基础配置
      "127.0.0.1" = [ "localhost" ];
      "::1" = [ "localhost" ];
      # 黑名单域名
      "0.0.0.0" = [
        "qqpatch.gtimg.cn" # 阻止 QQ 自动更新
      ];
    };
  };
}
