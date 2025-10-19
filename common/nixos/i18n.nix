{
  host,
  myvars,
  ...
}:
let
  inherit (myvars)
    timeZone
    defaultLocale
    extraLocale
    ;
in
{
  time = {
    timeZone = "${timeZone}";
    hardwareClockInLocalTime = true;
  };
  i18n = {
    defaultLocale = "${defaultLocale}";

    extraLocaleSettings = {
      LC_ADDRESS = "${extraLocale}";
      LC_IDENTIFICATION = "${extraLocale}";
      LC_MEASUREMENT = "${extraLocale}";
      LC_MONETARY = "${extraLocale}";
      LC_NAME = "${extraLocale}";
      LC_NUMERIC = "${extraLocale}";
      LC_PAPER = "${extraLocale}";
      LC_TELEPHONE = "${extraLocale}";
      LC_TIME = "${extraLocale}";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
  };
}
