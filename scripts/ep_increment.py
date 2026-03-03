#!/usr/bin/env python3
import sys
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse

if len(sys.argv) < 2:
    print("Usage: ep_increment <url>")
    sys.exit(1)

url = sys.argv[1]
parsed = urlparse(url)
params = parse_qs(parsed.query)

if 'ep' in params:
    params['ep'][0] = str(int(params['ep'][0]) + 1)

new_query = urlencode(params, doseq=True)
new_url = urlunparse((parsed.scheme, parsed.netloc, parsed.path, parsed.params, new_query, parsed.fragment))

print(f"open -t {new_url}")
