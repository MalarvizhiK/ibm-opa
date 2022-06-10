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

### Use case 4 :

**With Error Messages**:

2.  Start the OPA Server.   

```
./opa run --server --set=default_decision=ibm/network/has_vpc_security_group_rules_allow_all_inbound_ssh ./network_policy2.rego
{"addrs":[":8181"],"diagnostic-addrs":[],"level":"info","msg":"Initializing server.","time":"2022-06-09T21:14:42+05:30"}
{"current_version":"0.39.0","download_opa":"https://openpolicyagent.org/downloads/v0.41.0/opa_darwin_amd64","latest_version":"0.41.0","level":"info","msg":"OPA is out of date.","release_notes":"https://github.com/open-policy-agent/opa/releases/tag/v0.41.0","time":"2022-06-09T21:14:43+05:30"}
{"client_addr":"[::1]:54880","level":"info","msg":"Received request.","req_id":1,"req_method":"POST","req_path":"/","time":"2022-06-09T21:14:47+05:30"}
{"client_addr":"[::1]:54880","level":"info","msg":"Sent response.","req_id":1,"req_method":"POST","req_path":"/","resp_bytes":117,"resp_duration":1.671703,"resp_status":200,"time":"2022-06-09T21:14:47+05:30"}


```

3. Input a json to OPA Server.   

```
curl localhost:8181 -i -d @network_usecase3.json -H 'Content-Type: application/json'

HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Content-Type: application/json
Date: Thu, 09 Jun 2022 14:55:20 GMT
Content-Length: 132

[{"errors":["security group rule has public internet ip"],"id":"has_vpc_security_group_rules_allow_all_inbound_ssh","result":false}]%
       
```


