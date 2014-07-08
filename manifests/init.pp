#
# one machine setup with weblogic 12.1.2
# creates an WLS Domain with JAX-WS (advanced , soap)
# needs jdk7, wls, orautils, fiddyspence-sysctl, erwbgy-limits puppet modules
#

class weblogic {
  
  include weblogic::os_5, weblogic::wls12_5, weblogic::wls12c_domain_5, weblogic::maintenance_5
   Class['weblogic::os_5']  -> Class['weblogic::wls12_5'] -> Class['weblogic::wls12c_domain_5'] -> Class['weblogic::maintenance_5']

   class{'orautils':
        osOracleHomeParam      => "/opt/oracle",
        oraInventoryParam      => "/opt/oracle/oraInventory",
        osDomainTypeParam      => "admin",
        osLogFolderParam       => "/data/logs",
        osDownloadFolderParam  => "/data/install",
        osMdwHomeParam         => "/opt/oracle/Middleware12c",
        osWlHomeParam          => "/opt/oracle/Middleware12c/wlserver",
        oraUserParam           => "oracle",
        osDomainParam          => "Wls12c",
        osDomainPathParam      => "/opt/oracle/Middleware12c/user_projects/domains/Wls12c",
        nodeMgrPathParam       => "/opt/oracle/Middleware12c/user_projects/domains/Wls12c/bin",
        nodeMgrPortParam       => 5556,
        wlsUserParam           => "weblogic",
        wlsPasswordParam       => "weblogic1",
        wlsAdminServerParam    => "AdminServer",
    } 
}


