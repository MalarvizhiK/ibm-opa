# ibm-opa

### Steps to execute the file 

1. Install OPA for MAC   

```
curl -L -o opa https://openpolicyagent.org/downloads/v0.39.0/opa_darwin_amd64
chmod 755 ./opa

```   

2.  Start the OPA Server.   

```
./opa run --server --set=default_decision=ibm/network/is_WAF_Present_Before_APIGateway ./network_policy.rego
```

3. Input a json to OPA Server.   

```
malark@Malars-MacBook-Pro extremeblue % curl localhost:8181 -i -d @cis_example.json -H 'Content-Type: application/json'
HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Content-Type: application/json
Date: Wed, 06 Apr 2022 11:18:34 GMT
Content-Length: 4

true%            
```
