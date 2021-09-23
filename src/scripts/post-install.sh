#!/bin/bash

PROJECT_PATH='.'
PACKAGE='sofiakb/lumen-logging'

log-info() {
  echo -e "\033[36m$1\033[0m"
}

log-success() {
  echo -e "\033[32m$1\033[0m"
}

log-error() {
  echo -e "\033[31m$1\033[0m"
}

 ############ COPY LOGGING CONFIG FILE
if [[ -f "${PROJECT_PATH}/config/logging.php" ]]; then
  source="${PROJECT_PATH}/config/logging.php"
  target="${PROJECT_PATH}/config/logging-old.php"
  cp "${source}" "${target}"
  log-info "Le ficher ${source} a été copié vers ${target}"
fi;

mkdir -p "${PROJECT_PATH}/config" && cp "${PROJECT_PATH}/vendor/${PACKAGE}/src/config/logging.php" "${PROJECT_PATH}/config/logging.php"

if [ $? -eq 0 ]; then
  log-success "Fichier de config copié avec succès\n" # OK
else
  log-error "Echec lors de copie" # KO
  exit 1
fi;


if [[ -f "${PROJECT_PATH}/app/Exceptions/Handler.php" ]]; then
  source="${PROJECT_PATH}/vendor/${PACKAGE}/src/Exceptions/Handler.php"
  target="${PROJECT_PATH}/app/Exceptions/Handler.php"
  cp "${source}" "${target}"
  log-info "Le ficher ${source} a été copié vers ${target}"
fi;

log-info "cp ${PROJECT_PATH}/vendor/${PACKAGE}/src/Exceptions/Handler.php ${PROJECT_PATH}/app/Exceptions/Handler.php"
cp "${PROJECT_PATH}/vendor/${PACKAGE}/src/Exceptions/Handler.php" "${PROJECT_PATH}/app/Exceptions/Handler.php"
if [ $? -eq 0 ]; then
  log-success "Fichier handler copié avec succès\n" # OK
else
  log-error "Echec lors de copie" # KO
  exit 1
fi;

exit 0
