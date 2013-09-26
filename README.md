SNMP support for eradius
========================

Packaged as seperate application to make the mnesia dependency an
option for eradius

Running
-------

Add sample/snmp/agent.conf to your erlang config. Copy files from
sample/snmp to an appropriate place and adjust path names in all
configuraton files.
Change SNMP config values in sample/snmp files to match you system.

Run the erlang_snmp application.

Configuration
-------------

For a quick into on Erlang SNMP configuration check
[ErlangCentral](https://erlangcentral.org/wiki/index.php/SNMP_Quick_Start)

Check SNMP-Agent status
-----------------------

Erlang:

	2> snmpa:info().
	[{vsns,[v1,v2,v3]},
	...
	{mib_server,[{cache,300},
	             {loaded_mibs,[{'SNMP-MPD-MIB',true,
	                           ...
	                           {'ERADIUS-MIB',true,"priv/mibs/ERADIUS-MIB.bin"}]},
	...


net-snmp walk:

	$ snmpwalk -M+mibs -mALL -Os -c public -v 2c localhost:4000
