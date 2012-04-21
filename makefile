all:
	coffee --output js/ --compile src/

watch:
	watchr -e 'watch("src") {system "make"}'

