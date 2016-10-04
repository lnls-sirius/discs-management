#!/usr/bin/env bash

SCRIPTNAME=$0
CMD=$1
ARG1=$2

GITHUBURL=https://github.com/lnls-sirius

function clone_repos {
    git clone ${GITHUBURL}/docker-rbac-postgres; git clone ${GITHUBURL}/docker-rbac-wildfly
    git clone ${GITHUBURL}/docker-naming-service-postgres; git clone ${GITHUBURL}/docker-naming-service-wildfly
    git clone ${GITHUBURL}/docker-ccdb-postgres; git clone ${GITHUBURL}/docker-ccdb-wildfly
}

function clone_compose_repos {
    git clone ${GITHUBURL}/docker-rbac-compose
    git clone ${GITHUBURL}/docker-naming-service-compose
    git clone ${GITHUBURL}/docker-ccdb-compose
}

function print_help {
    printf "NAME\n"
    printf "       "; printf ${SCRIPTNAME}" - driver for routine operations on DISCS services\n"
    printf "\n"
    printf "SINOPSIS\n"
    printf "       "; printf ${SCRIPTNAME}" [OPTION]... \n"
    printf "\n"
    printf "DESCRIPTION\n"
    printf "       "; printf "Run commands related to DISCS services.\n"
    printf "\n"
    printf "       clone\n"
    printf "              clone DISCS repositories.\n"
    printf "\n"
    printf "       backup\n"
    printf "              backup all services databases\n"
    printf "\n"
    printf "       help\n"
    printf "              display this help and exit\n"
}

function backup_databases {
    mkdir -p backup-discs
   
    RUNNING=$(docker ps | grep rbac-auth-services-postgres)
    if [ ! -z "${RUNNING}" ]; then
	printf "backing rbac-auth-services-postgres up ...\n"
        docker run --rm --volumes-from rbac-auth-services-postgres -v $(pwd)/backup-discs:/backup lnls/docker-rbac-auth-services-postgres tar czf /backup/backup-rbac-auth-services-postgres-$(date "+%Y%m%d").gz /var/lib/postgresql/data
    else
        printf "service rbac-auth-services-postgres not running\n"
    fi   

    RUNNING=$(docker ps | grep naming-service-postgres)
    if [ ! -z "${RUNNING}" ]; then
	printf "backing naming-service-postgres up ...\n"
        docker run --rm --volumes-from naming-service-postgres -v $(pwd)/backup-discs:/backup lnls/docker-naming-service-postgres tar czf /backup/backup-naming-service-postgres-$(date "+%Y%m%d").gz /var/lib/postgresql/data
    else
        printf "service naming-service-postgres not running\n"
    fi   

    RUNNING=$(docker ps | grep ccdb-postgres)
    if [ ! -z "${RUNNING}" ]; then
	printf "backing ccdb-postgres up ...\n"
        docker run --rm --volumes-from ccdb-postgres -v $(pwd)/backup-discs:/backup lnls/docker-ccdb-postgres tar czf /backup/backup-ccdb-postgres-$(date "+%Y%m%d").gz /var/lib/postgresql/data
    else
        printf "service ccdb-postgres not running\n"
    fi    
}

if [ -z ${CMD} ]; then 
    print_help
elif [ ${CMD} == "clone" ]; then
    clone_repos
    clone_compose_repos
elif [ ${CMD} == "backup" ]; then
    backup_databases
else
    print_help    
fi



