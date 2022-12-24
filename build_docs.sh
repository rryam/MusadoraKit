#!/bin/zsh

swift package --allow-writing-to-directory ./docs \
generate-documentation --target MusadoraKit \
--disable-indexing \
--transform-for-static-hosting \
--hosting-base-path MusadoraKit \
--output-path ./docs
