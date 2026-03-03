#!/usr/bin/env python3
import os
import sys
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse

with open("/tmp/ep_increment.log", "a") as f:
    f.write(f"=== Script invoked! Args: {sys.argv} ===\n")

if len(sys.argv) < 2:
    fifo = os.environ.get('QUTE_FIFO')
    if fifo:
        with open(fifo, 'w') as f:
            f.write("message-error Usage: ep_increment <url>\n")
    sys.exit(1)

url = sys.argv[1]
with open("/tmp/ep_increment.log", "a") as f:
    f.write(f"URL: {url}\n")

parsed = urlparse(url)
params = parse_qs(parsed.query)

if 'ep' not in params:
    fifo = os.environ.get('QUTE_FIFO')
    if fifo:
        with open(fifo, 'w') as f:
            f.write(f"message-error No 'ep' param found in URL - {url}\n")
    with open("/tmp/ep_increment.log", "a") as f:
        f.write(f"ERROR: No ep param in URL: {url}\n")
    sys.exit(1)

params['ep'][0] = str(int(params['ep'][0]) + 1)

new_query = urlencode(params, doseq=True)
new_url = urlunparse((parsed.scheme, parsed.netloc, parsed.path, parsed.params, new_query, parsed.fragment))

with open("/tmp/ep_increment.log", "a") as f:
    f.write(f"New URL: {new_url}\n")

fifo = os.environ.get('QUTE_FIFO')
if fifo:
    with open("/tmp/ep_increment.log", "a") as f:
        f.write(f"Writing URL to FIFO: {new_url}\n")
    with open(fifo, 'w') as f:
        f.write(f"open {new_url}\n")
