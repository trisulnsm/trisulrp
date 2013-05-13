# == Guids - shortcuts to some wellknown guids
#
module  TrisulRP::Guids

  CG_AGGREGATE             = "{393B5EBC-AB41-4387-8F31-8077DB917336}" # Aggregate statistics 
  CG_APP                   = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" # Application wise traffic 
  CG_DIRMAC                = "{79F60A94-44BD-4C55-891A-77823D59161B}" # Traffic between two MACs
  CG_HOST                  = "{4CD742B1-C1CA-4708-BE78-0FCA2EB01A86}" # Stats for each IP Host
  CG_EXTERNAL_HOST         = "{00AA77BB-0063-11A5-8380-FEBDBABBDBEA}" # Hosts outside HOME NETWORK
  CG_INTERNAL_HOST         = "{889900CC-0063-11A5-8380-FEBDBABBDBEA}" # Hosts in HOME NETWORK 
  CG_WEB_HOST      	       = "{EEF95297-0C8D-4673-AD6B-F4BD2345FD69}" # Hosts talking HTTP/HTTPS
  CG_EMAIL_HOST 	       = "{22D4082E-B8BA-40D0-A287-1F524DF8DA7B}" # Hosts with Email traffic
  CG_SSH_HOST 	 	       = "{439002E4-3758-4E88-9438-8034FE1616AF}" # Hosts with SSH traffic
  CG_UNUSUAL_TRAFFIC_HOSTS = "{AE3A1449-5663-41A5-A028-FDE61DBB7EFA}" # Hosts with Unusual traffic 
  CG_SUBNET                = "{429B65AD-CDA4-452E-A852-24D8A3D0FBB3}" # Stats for configured IP Subnets
  CG_INTERFACE 	           = "{8AC478BC-8891-0009-5F31-80774B010086}" # Per interface statistics
  CG_UNLEASH_APPS          = "{FF889910-9293-AAA5-0028-883991889884}" # Demo of Rule based cg,count your enterprise apps
  CG_ALERT_SIGNATURES      = "{A0FA9464-B496-4A20-A9AB-4D2D09AFF902}" # Individual Alert Signatures
  CG_ALERT_CLASSES	       = "{20BC4345-37F0-44D0-ABFF-3BED97363CB1}" # IDS Alert Classfication
  CG_META_COUNTER_GROUP    = "{4D88CC23-2883-4DEA-A313-A23B60FE8BDA}" # Second order stats for counters
  CG_META_SESSION_GROUP    = "{594606BD-EEB2-4E0B-BAC4-84B7057088C8}" # Second order stats for flow activity 
  CG_FLOWGENS              = "{2314BB8E-2BCC-4B86-8AA2-677E5554C0FE}" # Flow generator traffic
  CG_FLOWINTFS 		       = "{C0B04CA7-95FA-44EF-8475-3835F3314761}" # Flow interface traffic	
  CG_HTTP_HOSTS		       = "{D2AAD7C6-E129-4366-A2AD-A8CB9AA4C2F4}" # Traffic by HTTP Host Headers
  CG_HTTP_CONTENT_TYPES    = "{C0C9757F-2005-4CC5-BB96-D72F607E6188}" # Traffic by HTTP Content Types
  CG_MAC		           = "{4B09BD22-3B99-40FC-8215-94A430EA0A35}" # Traffic per Ethernet MAC	
  CG_LINKLAYERSTATS	       = "{9F5AD3A9-C74D-46D8-A8A8-DCDD773730BA}" # Breakdown of activity at link layer 	
  CG_NETWORKLAYERSTATS	   = "{E89BCD56-30AD-40F5-B1C8-8B7683F440BD}" # Breakdown of activity at network layer 
  CG_VSAT		           = "{A8776788-B8E3-4108-AD24-0E3927D9364B}" # Traffic per VSAT	
  CG_VLANSTATS		       = "{0EC72E9E-3AD2-43FD-8173-74693EEA08D0}" # Per VLAN Activity Monitor	
  CG_HOSTSIPV6		       = "{6CD742B1-C1CA-4708-BE78-0FCA2EB01A86}" # Stats for each IPv6 Host	
  CG_TLSORG			       = "{432D7552-0363-4640-9CC5-23E4CA8410EA}" # TLS Organization
  CG_TLSCIPHER			   = "{5B64A573-623F-4F5B-8865-78C62BF466A7}" # TLS Ciphersuite
  CG_TLSCA			       = "{15856A98-7F87-46D7-84D2-18DD549F8A6F}" # TLS Cert Authority 
  

  AG_IDS                   = "{9AFD8C08-07EB-47E0-BF05-28B4A7AE8DC9}" # Track IDS Alerts
  AG_BLACKLIST             = "{5E97C3A3-41DB-4E34-92C3-87C904FAB83E}" # Blacklist used for Badfellas and Malware
  AG_TCA                   = "{03AC6B72-FDB7-44C0-9B8C-7A1975C1C5BA}" # Track TCA Alerts
  AG_FLOWTRACK             = "{18CE5961-38FF-4AEA-BAF8-2019F3A09063}" # Track flow based Alerts

  RG_URL                   = "{4EF9DEB9-4332-4867-A667-6A30C5900E9E}" # URL Resources
  RG_DNS                   = "{D1E27FF0-6D66-4E57-BB91-99F76BB2143E}" # DNS Resources
  RG_SSLCERTS              = "{5AEE3F0B-9304-44BE-BBD0-0467052CF468}" # SSLCerts Resources

  SG_TCP                   = "{99A78737-4B41-4387-8F31-8077DB917336}" # TCP Sessions
  	
end
