#
# $Id: Makefile $
#
# Author: Markus Stenberg <markus stenberg@iki.fi>
#
# Created:       Mon Jun 17 04:40:32 2013 mstenber
# Last modified: Thu Jun 19 09:35:03 2014 mstenber
# Edit time:     16 min
#

DRAFTS=\
  draft-stenberg-homenet-dnssd-hybrid-proxy-zeroconf-00.txt \
  draft-ietf-homenet-hncp-00.txt

ifndef XML_LIBRARY
XML_LIBRARY=$(HOME)/share/1/ietf-bib/bibxml:$(HOME)/share/1/ietf-bib/bibxml2:$(HOME)/share/1/ietf-bib/bibxml3:$(HOME)/share/1/ietf-bib/bibxml4:$(HOME)/share/1/ietf-bib/bibxml5
endif

all: $(DRAFTS)

%.txt: %.xml
	XML_LIBRARY=$(XML_LIBRARY) xml2rfc $< -v --text --html

%.xml.artwork: %.xml
	python fix-artwork.py < $< > $@
	mv $@ $<

push: all
	git push
	rsync -a draft*.html employees.org:WWW

clean:
	rm -f *.txt *.html
