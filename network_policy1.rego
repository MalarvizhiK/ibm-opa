package ibm.network

import future.keywords.in


default is_VSI_PGW_Expose_Insecure_Protocol = false	# unless otherwise defined, is_VSI_PGW_Expose_Insecure_Protocol is false

is_VSI_PGW_Expose_Insecure_Protocol = true {			 # allow is true if...
    input.objects[_].name == "ibm_is_instance" 
	input.objects[_].name == "ibm_is_public_gateway"  # public gateway attached to subnet
	input.objects[_].name == "ibm_is_subnet"  # subnet contains instance

	some i, j, k, l
	input.objects[i].name == "ibm_is_instance" 
	instance_id := input.objects[i].id
	parent_id = input.objects[i].parent 
	
	input.objects[j].name == "ibm_is_subnet" 
	subnet_id := input.objects[j].id
	
	parent_id == subnet_id 
	
	input.objects[l].name == "ibm_is_public_gateway" 
	pgw_id := input.objects[l].id
	
	input.edges[k].source == pgw_id
	input.edges[k].target == subnet_id
	
	any([contains(lower(input.edges[k].value) , "telnet"), contains(lower(input.edges[k].value) , "http" )])
	
	}