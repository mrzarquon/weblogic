class weblogic::wls12_5{

  $jdkWls12cJDK = 'jdk1.7.0_60'

  $osOracleHome    = "/opt/oracle"
  $osMdwHome       = "/opt/oracle/Middleware12c"
  $osWlHome        = "/opt/oracle/Middleware12c/wlserver"
  $user            = "oracle"
  $group           = "dba"
  $downloadDir     = "/data/install"

  $puppetDownloadMntPoint = "puppet:///modules/wls/"

  # set the wls defaults
  Wls::Installwls {
    version                => '1212',
    mdwHome                => $osMdwHome,
    oracleHome             => $osOracleHome,
    fullJDKName            => $jdkWls12cJDK, 
    user                   => $user,
    group                  => $group,   
    downloadDir            => $downloadDir,
    puppetDownloadMntPoint => $puppetDownloadMntPoint, 
  }

  wls::installwls{'wls12c':
  } 

} 
