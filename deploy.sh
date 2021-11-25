#!/bin/bash

Rscript -e "rmarkdown::render_site('.')"
mv build_dir/output docs
sed -s -i 's/<a href="index.html" title="">.*/<a href="https:\/\/docs.sykdomspulsen.no" title="">docs.sykdomspulsen.no<\/a>/g' docs/*html
sed -s -i 's/font-size: 18px/font-size: 14px/g' docs/libs/bs4_book-1.0.0/bs4_book.css
git add docs && git commit -m "Initial docs subtree commit"
git push origin `git subtree split --prefix docs main`:gh-pages --force
git reset --soft HEAD^
git restore --staged .
rm -rf docs
