class weblogic::wls12c_domain_5{

  $jdkWls12gJDK    = 'jdk1.7.0_60'

  $wlsDomainName   = "Wls12c"
  $osTemplate      = "standard"

  $adminListenPort = "7001"
  $nodemanagerPort = "5556"
  $address         = "localhost"

  $osOracleHome    = "/opt/oracle"
  $osMdwHome       = "/opt/oracle/Middleware12c"
  $osWlHome        = "/opt/oracle/Middleware12c/wlserver"

  $user         = "oracle"
  $group        = "dba"
  $downloadDir  = "/data/install"
  $logDir       = "/data/logs" 

  case $operatingsystem {
     CentOS, RedHat, OracleLinux, Ubuntu, Debian: { 
       $userConfigDir = '/home/oracle'
     }
     Solaris: { 
       $userConfigDir = '/export/home/oracle'
     }
   }

  # install domain
  wls::wlsdomain{
   'wlsDomain12c':
    version         => "1212",
    wlHome          => $osWlHome,
    mdwHome         => $osMdwHome,
    fullJDKName     => $jdkWls12gJDK,  
    user            => $user,
    group           => $group,    
    downloadDir     => $downloadDir, 
    wlsTemplate     => $osTemplate,
    domain          => $wlsDomainName,
    adminListenPort => $adminListenPort,
    nodemanagerPort => $nodemanagerPort,
    wlsUser         => "weblogic",
    password        => "weblogic1",
    logDir          => $logDir,
  }

  Wls::Nodemanager {
    wlHome       => $osWlHome,
    fullJDKName  => $jdkWls12gJDK,	
    user         => $user,
    group        => $group,
    serviceName  => $serviceName,  
  }

   #nodemanager starting 
   # in 12c start it after domain creation
   wls::nodemanager{'nodemanager12c':
     version    => "1212",
     listenPort => $nodemanagerPort,
     domain     => $wlsDomainName,   	 
     require    => Wls::Wlsdomain['wlsDomain12c'],
   }  
 
 
   orautils::nodemanagerautostart{"autostart ${wlsDomainName}":
      version     => "1212",
      wlHome      => $osWlHome, 
      user        => $user,
      domain      => $wlsDomainName,
      logDir      => $logDir,
      require     => Wls::Nodemanager['nodemanager12c'];
   }

  # start AdminServers for configuration
  wls::wlscontrol{'startWLSAdminServer12c':
      wlsDomain     => $wlsDomainName,
      wlsDomainPath => "${osMdwHome}/user_projects/domains/${wlsDomainName}",
      wlsServer     => "AdminServer",
      action        => 'start',
      wlHome        => $osWlHome,
      fullJDKName   => $jdkWls12gJDK,  
      wlsUser       => "weblogic",
      password      => "weblogic1",
      address       => $address,
      port          => $nodemanagerPort,
      user          => $user,
      group         => $group,
      downloadDir   => $downloadDir,
      logOutput     => true, 
      require       => Wls::Nodemanager['nodemanager12c'],
  }

}
