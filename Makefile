#
# $Id: Makefile $
#
# Author: Markus Stenberg <markus stenberg@iki.fi>
#
# Created:       Mon Jun 17 04:40:32 2013 mstenber
# Last modified: Mon Jun  9 13:19:51 2014 mstenber
# Edit time:     14 min
#

DRAFTS=\
  draft-stenberg-homenet-dnssd-hybrid-proxy-zeroconf-00.txt \
  draft-ietf-homenet-hncp-00.txt

ifndef XML_LIBRARY
XML_LIBRARY=$(HOME)/share/1/ietf-bib
endif

all: $(DRAFTS)

%.txt: %.xml
	XML_LIBRARY=$(XML_LIBRARY) xml2rfc $< --text --html

%.xml.artwork: %.xml
	python fix-artwork.py < $< > $@
	mv $@ $<

push: all
	git push
	rsync -a draft*.html employees.org:WWW

clean:
	rm -f *.txt *.html
