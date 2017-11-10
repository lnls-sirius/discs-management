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
    git clone ${GITHUBURL}/docker-rbac-composed
    git clone ${GITHUBURL}/docker-naming-service-composed
    git clone ${GITHUBURL}/docker-ccdb-composed
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
    mkdir -p backup-files
    RUNNING=$(docker ps | grep rbac-auth-services-postgres)
    if [ ! -z "${RUNNING}" ]; then
	      printf "backing rbac-auth-services-postgres up ...\n"
        fname=./backup-files/dump_rbac-postgres_`date +%Y-%m-%d"_"%H-%M-%S`.sql.gz
        docker exec -t rbac-auth-services-postgres pg_dumpall -c -U rbac | gzip -9 > $fname
    else
        printf "service rbac-auth-services-postgres not running\n"
    fi

    RUNNING=$(docker ps | grep naming-service-postgres)
    if [ ! -z "${RUNNING}" ]; then
	      printf "backing naming-service-postgres up ...\n"
        fname=./backup-files/dump_naming-service-postgres_`date +%Y-%m-%d"_"%H-%M-%S`.sql.gz
        docker exec -t naming-service-postgres pg_dumpall -c -U discs_names | gzip -9 > $fname
    else
        printf "service naming-service-postgres not running\n"
    fi

    RUNNING=$(docker ps | grep ccdb-postgres)
    if [ ! -z "${RUNNING}" ]; then
	      printf "backing ccdb-postgres up ...\n"
        fname=./backup-files/dump_ccdb-postgres_`date +%Y-%m-%d"_"%H-%M-%S`.sql.gz
        docker exec -t ccdb-postgres pg_dumpall -c -U ccdb | gzip -9 > $fname
    else
        printf "service ccdb-postgres not running\n"
    fi

    RUNNING=$(docker ps | grep cables-postgres)
    if [ ! -z "${RUNNING}" ]; then
	      printf "backing cables-postgres up ...\n"
        fname=./backup-files/dump_cables-postgres_`date +%Y-%m-%d"_"%H-%M-%S`.sql.gz
        docker exec -t cables-postgres pg_dumpall -c -U cabledb | gzip -9 > $fname
    else
        printf "service cables-postgres not running\n"
    fi

    # lastfiles=$(ls -t $(pwd)/backup-dics/ | head -3)
    # incomplete!

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
