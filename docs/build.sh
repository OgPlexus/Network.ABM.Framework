#!/usr/bin/env fish
pandoc -s --toc --toc-depth=4 -o index.html -c pandoc.css -f markdown overview.md usage.md implementation.md example.md