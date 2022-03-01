#!/bin/bash

reset

Rscript -e "rmarkdown::render_site('.')"
RESULT=$?

if [ $RESULT -eq 0 ]; then
  mv build_dir/output docs

  # https://github.blog/2009-12-29-bypassing-jekyll-on-github-pages/
  touch docs/.nojekyll

  sed -s -i 's/<a href="index.html" title="">.*/<a href="https:\/\/docs.sykdomspulsen.no" title="">docs.sykdomspulsen.no<\/a>/g' docs/*html
  sed -s -i 's/font-size: 18px/font-size: 14px/g' docs/libs/bs4_book-1.0.0/bs4_book.css
  git add docs && git commit -m "Initial docs subtree commit"
  git push origin `git subtree split --prefix docs main`:gh-pages --force
  git reset --soft HEAD^
  git restore --staged .
  rm -rf docs
else
  echo "FAILED"
fi
