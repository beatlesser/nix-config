{
  services = {
    #auto-cpufreq.enable = true; # - 自动优化 CPU 频率和电源管理
    #thermald.enable = true; # - Intel 官方的温控服务，可防止 CPU 过热
    power-profiles-daemon.enable = true;
    tlp = {
      enable = false;
      settings = {
        # 控制最大 CPU 性能（降低功耗）
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        RUNTIME_PM_ALL = true; # 启用所有设备的运行时电源管理
        START_CHARGE_THRESH_BAT0 = 75; # 电池低于 75% 时开始充电
        STOP_CHARGE_THRESH_BAT0 = 80; # 充电到 80% 时停止充电
        TLP_MONITOR_BATTERY_STATUS = true;
        TLP_MONITOR_AC_STATUS = true;
        BATT_LOAD_THRESH = 5; # 电池电量低于 5% 时执行特定操作（例如，关闭电源）
      };
    };
  };
  powerManagement = {
    enable = true; # 启用电源管理
    cpuFreqGovernor = "schedutil"; # - `schedutil`：基于 CPU 任务负载动态调整频率
    # - 通常比 `performance` 和 `powersave` 更智能，适合大多数场景
  };
  zramSwap = {
    enable = true; # 启用 ZRAM 交换空间（在内存中创建压缩 swap）
    priority = 100; # 设置 ZRAM swap 优先级（高于物理 swap）
    memoryPercent = 100; # 使用总内存的 100% 作为 ZRAM 交换空间
    swapDevices = 1; # 仅创建一个 ZRAM 交换设备
    algorithm = "zstd"; # 使用 `zstd` 压缩算法（高压缩比 & 低 CPU 负担）
  };
}
