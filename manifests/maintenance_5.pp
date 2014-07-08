class weblogic::maintenance_5 {

  case $operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian: { 
      $mtimeParam = "1"
    }
    Solaris: { 
      $mtimeParam = "+1"
    }
  }

  cron { 'cleanwlstmp' :
	  command => "find /tmp -name '*.tmp' -mtime ${mtimeParam} -exec rm {} \\; >> /tmp/tmp_purge.log 2>&1",
	  user    => oracle,
	  hour    => 06,
	  minute  => 25,
  }
	
  cron { 'mdwlogs' :
	  command => "find /opt/oracle/Middleware12c/logs -name 'wlst_*.*' -mtime ${mtimeParam} -exec rm {} \\; >> /tmp/wlst_purge.log 2>&1",
	  user    => oracle,
	  hour    => 06,
	  minute  => 30,
  }
}
