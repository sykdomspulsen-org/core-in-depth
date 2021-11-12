#!/bin/bash

Rscript -e "rmarkdown::render_site('.')"
mv build_dir/output docs
git add docs && git commit -m "Initial docs subtree commit"
git push origin `git subtree split --prefix docs main`:gh-pages --force
git reset --soft HEAD^
git restore --staged .
rm -rf docs
