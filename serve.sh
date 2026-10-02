#!/bin/bash
set -e
cd "$(dirname "$0")"
exec bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
