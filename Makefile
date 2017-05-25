

playcanvas:
	cd ./lib/engine/build && \
	npm install fs-extra && \
	npm install google-closure-compiler && \
	npm install preprocessor && \
	node build.js -l 1 -o ../../../bin/playcanvas-latest.min.js

all: playcanvas
