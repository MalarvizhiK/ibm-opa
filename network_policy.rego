package ibm.network

import future.keywords.in


default is_WAF_Present_Before_APIGateway = false	# unless otherwise defined, is_WAF_Present_Before_APIGateway is false

is_WAF_Present_Before_APIGateway = true {			 # allow is true if...
    input.objects[_].name == "ibm_cis" 
	input.objects[_].name == "ibm_apigateway" 

	some i, j, k
	input.objects[i].name == "ibm_cis" 
	cis_id := input.objects[i].id
	
	input.objects[j].name == "ibm_apigateway" 
	gateway_id := input.objects[j].id
	
	input.edges[k].source == cis_id
	input.edges[k].target == gateway_id
	
	}