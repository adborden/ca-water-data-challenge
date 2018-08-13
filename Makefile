MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
.PHONY: all assets build clean serve setup

PATH:=./node_modules/.bin:$(PATH)

svgs = ca-service-boundaries.svg
json = ca-service-boundaries.json

all: $(svgs)

setup:
	bundle install
	npm install

build: ca-service-boundaries.svg
	mkdir -p src/assets/maps
	cp -t src/assets/maps $^
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

ca.geo.json:
	curl 'https://raw.githubusercontent.com/johan/world.geo.json/master/countries/USA/CA.geo.json' > $@

ca-service-boundaries.ndjson: data/cehtp-wbt-service-boundaries-geojson.json
	#jq -c '.features[] | select(.properties.address_city_name == "SAN FRANCISCO")' < $< > $@
	jq -c '.features[]' < $< > $@

ca-service-boundaries.geoproject.json: ca-service-boundaries.geo.json
	# TODO there's something in the service boundary data that causes
	# fitSize to fit the world instead of california. Maybe there is a
	# coordinate way outisde of California?
	#geoproject 'd3.geoConicEqualArea().parallels([34, 40.5]).rotate([120, 0]).fitSize([740, 450], d)' < $< > $@
	geoproject 'd3.geoConicEqualArea().parallels([34, 40.5]).rotate([120, 0]).scale(2500).translate([370, 370])' < $< > $@

ca-service-boundaries.geo.json: ca.ndjson ca-service-boundaries.ndjson
	cat $^ | \
	ndjson-reduce | \
	ndjson-map '{type: "FeatureCollection", features: d}' > $@

%.ndjson: %.geo.json
	ndjson-cat $< | \
	ndjson-split 'd.features' > $@


%.svg: %.geoproject.json
	geo2svg -w 740 -h 450 < $< > $*.svg

clean:
	rm -rf *.ndjson
	rm -rf $(svgs) $(json)
