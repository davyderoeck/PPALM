@echo off

git add .
git commit -m "Changes from pipeline for %solution.name% version %solution_version_prefix%.%Build_BuildNumber%.%build_buildid%"
git push
git status