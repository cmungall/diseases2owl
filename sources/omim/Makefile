TGT=../../target/
PRODUCTS = omim.owl

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: %
	cp $< $(TGT)

omim-src.ttl:
	wget --no-check-certificate https://data.monarchinitiative.org/experimental/omim.ttl -O $@
.PRECIOUS: omim.ttl

omim-src.owl: omim-src.ttl
	owltools $< --set-ontology-id $(OBO)/mondo/$@ -o $@
omim-src.obo: omim-src.owl
	owltools $< -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | ./bin/fix-omim.pl  > $@

# this gets rid of genes
omim.obo: omim-src.obo
	obo-grep.pl --neg -r '(equivalent_to|is_a: SO|property_value: RO:0002524)' $< | perl -npe 's@http://omim.org/entry/@OMIM:@g;s@http://www.omim.org/phenotypicSeries/PS@OMIMPS:@g' |  obo-grep.pl -r 'id: OMIM' -   > $@.tmp && mv $@.tmp $@
omim.owl: omim.obo
	owltools $< --set-ontology-id http://purl.obolibrary.org/obo/omim.owl -o -f obo $@
