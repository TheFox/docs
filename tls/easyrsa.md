# EasyRSA

## Create new Client

```
cd EasyRSA-3.0.4_server/

# Simple
./easyrsa gen-req client1 nopass

# With subject
./easyrsa --subject-alt-name="DNS:client1.example.com,DNS:client1.com" gen-req client1 nopass
```

```
cd EasyRSA-3.0.4_ca/
./easyrsa import-req ../EasyRSA-3.0.4_server/pki/reqs/client1.req client1
./easyrsa sign-req client client1
```
