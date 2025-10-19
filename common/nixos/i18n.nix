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
  # Set your time zone.
  time.timeZone = "${timeZone}";
  # Sync hc to local time
  time.hardwareClockInLocalTime = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "${defaultLocale}";

  i18n.extraLocaleSettings = {
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

}
