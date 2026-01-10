{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    john
    zap
    hydra
    nmap
    python313Packages.lsassy
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
        wfuzz
        fuzzdb
        dirbuster
        dirb
      ];
    })
    metasploit
    postgresql
    sqlmap
    burpsuite
  ];

  systemd.user.services.postgresql = {
    Unit = {
      Description = "PostgreSQL User Service";
      After = [ "network.target" ];
    };
    Service = {
      Type = "forking";
      Environment = "PGHOST=%h/.local/share/postgresql";
      ExecStartPre = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/mkdir -p %h/.local/share/postgresql && if [ ! -d %h/.local/share/postgresql/base ]; then ${pkgs.postgresql}/bin/initdb -D %h/.local/share/postgresql --encoding=UTF8 --locale=C -o \"-c unix_socket_directories=%h/.local/share/postgresql\"; fi'";
      ExecStart = "${pkgs.postgresql}/bin/pg_ctl -D %h/.local/share/postgresql -l %h/.local/share/postgresql/logfile -o \"-c unix_socket_directories=%h/.local/share/postgresql -c listen_addresses=127.0.0.1\" start";
      ExecStartPost = "${pkgs.bash}/bin/bash -c 'sleep 1 && ${pkgs.postgresql}/bin/psql -h %h/.local/share/postgresql -d postgres -tc \"SELECT 1 FROM pg_database WHERE datname = '\"'\"'msf'\"'\"'\" | ${pkgs.gnugrep}/bin/grep -q 1 || ${pkgs.postgresql}/bin/createdb -h %h/.local/share/postgresql msf'";
      ExecStop = "${pkgs.postgresql}/bin/pg_ctl -D %h/.local/share/postgresql stop";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.configFile."metasploit-framework/database.yml".text = ''
    production:
      adapter: postgresql
      database: msf
      username: ${config.home.username}
      host: ${config.home.homeDirectory}/.local/share/postgresql
      port: 5432
      pool: 5
      timeout: 5
  '';

  home.file.".msf4/database.yml".text = ''
    production:
      adapter: postgresql
      database: msf
      username: ${config.home.username}
      host: ${config.home.homeDirectory}/.local/share/postgresql
      port: 5432
      pool: 5
      timeout: 5
  '';
}
