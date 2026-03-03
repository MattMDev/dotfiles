#!/usr/bin/env python3
import sys
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse

with open("/tmp/ep_increment.log", "a") as f:
    f.write(f"Script invoked! Args: {sys.argv}\n")

url = sys.argv[1] if len(sys.argv) > 1 else None
if not url:
    with open("/tmp/ep_increment.log", "a") as f:
        f.write("No URL provided\n")
    sys.exit(1)

url = sys.argv[1]
parsed = urlparse(url)
params = parse_qs(parsed.query)

if 'ep' in params:
    params['ep'][0] = str(int(params['ep'][0]) + 1)

new_query = urlencode(params, doseq=True)
new_url = urlunparse((parsed.scheme, parsed.netloc, parsed.path, parsed.params, new_query, parsed.fragment))

print(f"DEBUG: New URL: {new_url}", file=sys.stderr)
print(f"open -t {new_url}")
