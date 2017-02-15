TODO list
=========

- Issues in GitHub repo!


RBAC
====

  access
  ------
  https://10.0.7.55:8445/


NAMING SERVICE
==============

  access
  ------
  http://10.0.7.55:8080/names/

  discs_names dump
  ----------------
  - ssh lnls82-linux
  - docker -exec -it naming-service-postgres bash
  - FNAME=discs_names_$(date "+%Y%m%d").sql
  - pg_dump --username postgres discs_names > ${FNAME}
  - echo "nameserver 10.0.0.71" >> /etc/resolv.conf
  - apt-get update; apt-get install openssh-client
  - scp -p ${FNAME} ximenes@10.0.21.122:


CCDB
====

access: http://10.0.7.55:8083/

a site for abbriviation suggestions:

http://www.abbreviations.com/abbreviation/sample


postgres
========

- psql --username postgres
- \list
- \q




REST interface to NS
====================
http://10.0.7.55:8080/names/rest/deviceNames
http://10.0.7.55:8080/names/rest/deviceNames/2f37d00a-49c0-4f85-9d7b-d8dba49422a1


REST interface to CCDB
======================
http://10.0.7.55:8083/rest/deviceTypes
http://10.0.7.55:8083/rest/deviceTypes/RFLLAmpLC
http://10.0.7.55:8083/rest/slots
http://10.0.7.55:8083/rest/slots/SI-02C1:PS-Q1

http://server/ccdb/rest/slot/<slotName>/download/<fileName>
http://10.0.7.55:8083/rest/slots?deviceType=QuadrupolePS
http://10.0.7.55:8083/rest/slotNames
http://10.0.7.55:8083/rest/slotNames?deviceType=QuadrupolePS



How to backup DISCS databases
=============================

01. ssh linux82-linux
02. cd /home/fac_files/discs-management
03. ./discs-run.sh backup
04. scp -rp  backup-discs/*$(date "+%Y%m%d").gz fernando-linux:/home/fac_files/backup-discs/
