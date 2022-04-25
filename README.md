# ibm-opa

### Steps to execute the file 

1. Install OPA for MAC   

```
curl -L -o opa https://openpolicyagent.org/downloads/v0.39.0/opa_darwin_amd64
chmod 755 ./opa

```   

### Use case 1 :

2.  Start the OPA Server.   


```
./opa run --server --set=default_decision=ibm/network/is_WAF_Present_Before_APIGateway ./network_policy.rego
```

3. Input a json to OPA Server.   

```
curl localhost:8181 -i -d @cis_example.json -H 'Content-Type: application/json'
HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Content-Type: application/json
Date: Wed, 06 Apr 2022 11:18:34 GMT
Content-Length: 4

true%            
```

### Use case 2 :

2.  Start the OPA Server.   

```
./opa run --server --set=default_decision=ibm/network/is_VSI_PGW_Expose_Insecure_Protocol ./network_policy1.rego

```

3. Input a json to OPA Server.   

```
curl localhost:8181 -i -d @public_gateway_insecured_example.json -H 'Content-Type: application/json'
HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 17 Apr 2022 17:59:50 GMT
Content-Length: 5

false% 
       
```

### Use case 3 :

2.  Start the OPA Server.   

```
./opa run --server --set=default_decision=ibm/network/has_vpc_security_group_rules_allow_all_inbound_ssh ./network_policy2.rego

```

3. Input a json to OPA Server.   

```
curl localhost:8181 -i -d @security_group_rules_allow_all_inbound_ssh_example.json -H 'Content-Type: application/json'
HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 17 Apr 2022 17:59:50 GMT
Content-Length: 5

false% 
       
```
