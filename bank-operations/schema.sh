#!/bin/bash
~/nb -v run driver=cql yaml=mouvements tags=phase:schema dsehost=localhost
dsetool write_resource bench.mouvements_valides name=schema.xml file=schema.xml
dsetool write_resource bench.mouvements_valides name=solrconfig.xml file=solrconfig.xml
dsetool reload_core bench.mouvements_valides
