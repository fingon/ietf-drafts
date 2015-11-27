#
# $Id: Makefile $
#
# Author: Markus Stenberg <markus stenberg@iki.fi>
#
# Created:       Mon Jun 17 04:40:32 2013 mstenber
# Last modified: Fri Nov 27 08:53:30 2015 mstenber
# Edit time:     34 min
#

DRAFTS=\
  draft-barth-homenet-wifi-roaming-00.txt \
  draft-stenberg-homenet-minimalist-pcp-proxy-01.txt \
  draft-stenberg-shsp-01.txt \
  draft-stenberg-anima-adncp-00.txt \
  draft-stenberg-mif-mpvd-dns-00.txt \
  draft-ietf-homenet-hybrid-proxy-zeroconf-02.txt \
  draft-ietf-homenet-dncp-12.txt \
  draft-ietf-homenet-hncp-10.txt \

ifndef XML_LIBRARY
XML_LIBRARY=$(HOME)/share/1/ietf-bib/bibxml:$(HOME)/share/1/ietf-bib/bibxml2:$(HOME)/share/1/ietf-bib/bibxml3:$(HOME)/share/1/ietf-bib/bibxml4:$(HOME)/share/1/ietf-bib/bibxml5
endif

all: $(DRAFTS)

check: $(patsubst %.txt,%.xml.check,$(DRAFTS))

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
	rsync -a draft*.txt employees.org:WWW

clean:
	rm -f *.txt *.html *~
