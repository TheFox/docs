# Google Cloud IP Ranges

IP address ranges for `us-east1`:

```bash
curl -s https://www.gstatic.com/ipranges/cloud.json | jq '.prefixes[] | select(.scope=="us-east1")' | jq .ipv4Prefix | grep -v null | sed 's/"//g'
```
