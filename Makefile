#
# $Id: Makefile $
#
# Author: Markus Stenberg <markus stenberg@iki.fi>
#
# Created:       Mon Jun 17 04:40:32 2013 mstenber
# Last modified: Wed Nov 26 10:12:48 2014 mstenber
# Edit time:     19 min
#

DRAFTS=\
  draft-stenberg-homenet-dnssd-hybrid-proxy-zeroconf-01.txt \
  draft-stenberg-homenet-minimalist-pcp-proxy-01.txt \
  draft-stenberg-homenet-dncp-00.txt \
  draft-ietf-homenet-hncp-03.txt \
  draft-barth-homenet-hncp-security-trust-01.txt \

ifndef XML_LIBRARY
XML_LIBRARY=$(HOME)/share/1/ietf-bib/bibxml:$(HOME)/share/1/ietf-bib/bibxml2:$(HOME)/share/1/ietf-bib/bibxml3:$(HOME)/share/1/ietf-bib/bibxml4:$(HOME)/share/1/ietf-bib/bibxml5
endif

all: $(DRAFTS)

%.txt: %.xml
	XML_LIBRARY=$(XML_LIBRARY) xml2rfc $< -v --text --html

%.xml.artwork: %.xml
	python fix-artwork.py < $< > $@
	mv $@ $<

%.xml.check: %.xml
	aspell -H -c $<

push: all
	git push
	rsync -a draft*.html employees.org:WWW

clean:
	rm -f *.txt *.html
