{glance, ...}: {
  environment.etc.glance.text = builtins.readFile ./glance.yml;
  systemd.user.services.glance = {
    description = "Glance";
    wantedBy = ["default.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${glance}/bin/glance -config /etc/glance";
      Restart = "on-failure";
      RestartSec = "1";
      TimeoutStopSec = "0";
    };
  };
}
