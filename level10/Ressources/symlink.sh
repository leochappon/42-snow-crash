#!/bin/bash

while true; do
	touch /tmp/link
	rm -f /tmp/link
	ln -s ~/token /tmp/link
	rm -f /tmp/link
done
