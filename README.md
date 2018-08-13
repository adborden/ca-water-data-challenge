# CA Water Data Challenge

This project was started as part of National Day of Civic Hacking 2018 on August
11, 2018. We're taking on the [California Safe Water Drinking
Challenge](http://waterchallenge.data.ca.gov/).


## Goals

- Map public water systems and their level of risk in order to identify opportunities for
  consolidation of at-risk water systems and improve community access to safe
  drinking water.


## Risk

These are the factors that make up Risk.

1. Reliability
1. Affordability
1. Safety


### Reliability

Does the production of water match the demand?

Need to measure at "peak" times.


#### Data sources

- [Delivered Water - Public System Water Reported in the Electronic Annual
  Report (EAR)\* 2013-2016](https://data.ca.gov/dataset/drinking-water-%E2%80%93-public-water-system-annually-reported-water-production-and-delivery-0)
- [Produced Water - Public Water System Reported in the Electronic Annual Report
  (EAR) 2013-2016](https://data.ca.gov/dataset/drinking-water-%E2%80%93-public-water-system-annually-reported-water-production-and-delivery-2)


### Affordability

Can people in the area afford drinking water?


### Safety

Is the water polluted? Is it safe to drink?


## Interesting data sets

List of 20 recommended datasets.
https://docs.google.com/spreadsheets/d/1NhC1WyYVj2K4N-JpoYQk_7W0ZAbDInjmiYirHUkBaOE/edit#gid=0

Public Water Systems
https://data.ca.gov/dataset/drinking-water-public-water-system-information/resource/64356c96-3833-4fcf-814a-077f4c2bf508

SDWIS - safe drinking water at federal level
https://www.epa.gov/ground-water-and-drinking-water/safe-drinking-water-information-system-sdwis-federal-reporting

Water Service Boundaries (registration required)
http://cehtp.org/water/
http://cehtp.org/geoserver/ows?service=wfs&version=1.1.0&request=GetFeature&typeName=water:service_areas&srsName=epsg:4326&cql_filter=(is_complete%20=%20%27true%27%20AND%20is_current%20=%20%27true%27)&outputFormat=json

```
curl 'http://cehtp.org/water/api/water/download/number-of-service-areas' \
  -H 'Cookie: JSESSIONID=<hash>' \
  --data 'pws_id=&county_id=&district_id=&population_where=%3D&population=&population_range=&connection_where=%3D&connection_count=&connections_range=&current=true&complete=true'
```

TopoJSON files of the US
https://github.com/topojson/us-atlas

GeoJSON files of world, including US States and counties (per file)
https://github.com/johan/world.geo.json

County Subdivision shape files from Census Bureau
https://www.census.gov/geo/maps-data/data/cbf/cbf_cousub.html


## Techniques

Creating SVG maps from geojson
https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c


## Glossary

PWSID - pulbic water system Id.


## Principles

> What we want is an iterative, exploratory approach, where at every step we can
> see what the data looks like; by inspecting as we go, we can fix mistakes as we
> make them, before they get buried in complexity. And when we’re done, we want to
> capture our workflow as machine-readable documentation that can be easily
> reproduced.

_https://medium.com/@mbostock/command-line-cartography-part-2-c3a82c5c0f3_

From Datamade's [Data Making Guidelines](https://github.com/datamade/data-making-guidelines):

1. Never destroy data - treat source data as immutable, and show your work when you modify it
1. Be able to deterministically produce the final data with one command
1. Write as little custom code as possible
1. Use standard tools whenever possible
1. Keep source data under version control


## Development

Install the dependencies.

    $ make setup

Build the site.

    $ make build

Start the development server.

    $ make serve

Open your web browser to [http://localhost:4000](http://localhost:4000/).
