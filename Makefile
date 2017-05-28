BROWSER = chromium
BLENDER = blender

PLAYCANVAS = bin/Scripts/playcanvas-latest.js
PLAYCANVAS_EXPORT_HELPER = single_model_export.py

MODELS = $(shell find src/Models -name *.blend)

all: complete $(PLAYCANVAS)

$(PLAYCANVAS): ./lib/engine/src/*
	cd ./lib/engine/build && \
	npm install fs-extra && \
	npm install google-closure-compiler && \
	npm install preprocessor && \
	node build.js -l 1 -o ../../../$(PLAYCANVAS)

models: $(MODELS)
	@# Exports models from blender, puts them in bin/models. The exporter
	@# script automagically deals with textures, copying them to a place
	@# relative to the model directory
	@for model in $(MODELS) ; do \
		echo Processing Model $$model; \
        blender $$model -b --python $(PLAYCANVAS_EXPORT_HELPER); \
    done

static-resources: ./src/*
	# Copying Static Resources
	cp -r ./src/Scripts ./bin/Scripts
	cp -r ./src/Sounds ./bin/Sounds
	cp ./src/*.html ./bin/
	cp ./src/*.css ./bin/


quick: static-resources
	# Only copies scripts and static resources, does not build
	# models

complete: static-resources models

test: quick
	python -m http.server & $(BROWSER) 0.0.0.0:8000/bin

clean:
	rm -r ./bin/*

