@echo off
git config --global user.email "%BUILD_REQUESTEDFOREMAIL%"
git config --global user.name "%BUILD_REQUESTEDFOR%"

ECHO SOURCE BRANCH IS %BUILD_SOURCEBRANCH%
IF %BUILD_SOURCEBRANCH% == refs/heads/main (
   ECHO Building main branch so no merge is needed.
   EXIT
)
SET sourceBranch=origin/%BUILD_SOURCEBRANCH:refs/heads/=%

ECHO GIT CHECKOUT DEV
git checkout DEV
