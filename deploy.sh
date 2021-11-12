#!/bin/bash

Rscript -e "rmarkdown::render_site('.')"
mv build_dir/output docs
git add docs && git commit -m "Initial docs subtree commit"
git subtree push --prefix docs origin gh-pages
git reset --soft HEAD^
rm -rf docs
