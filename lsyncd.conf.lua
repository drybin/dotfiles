 settings {
  logfile    = "/var/log/lsyncd/lsyncd.log",
  statusFile = "/var/log/lsyncd/lsyncd.status",
  statusInterval = 1, --<== чтобы видеть что происходит без включения подробного лога
}

sync {
  default.rsyncssh,
  source = "/data/projects/realty.ngs.ru/",
  host = "ngs.ru.rn.t5",
  targetdir = "/data/projects/realty.ngs.ru",
  delay = 1,
  rsync = {
    binary = "/usr/bin/rsync",
    archive = true,
    compress = false,
    whole_file=false,
--    rsh = "/usr/bin/ssh -l root -i /home/d.rybin/.ssh/id_rsa ngs.ru.rn.t5",
  },
}
