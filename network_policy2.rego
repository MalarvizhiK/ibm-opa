package ibm.network

import future.keywords.in


default has_vpc_security_group_rules_allow_all_inbound_ssh = false	# unless otherwise defined, has_vpc_security_group_rules_allow_all_inbound_ssh is false

has_vpc_security_group_rules_allow_all_inbound_ssh = true {			 # allow is true if...

    input.objects[_].name == "ibm_is_vpc" 
	input.objects[_].name == "ibm_is_subnet" 
    input.objects[_].name == "ibm_is_security_group_rule" 
	
	some i
	input.objects[i].name == "ibm_is_security_group_rule" 
	
	direction := input.objects[i].direction
	direction == "inbound"
	
	remote := input.objects[i].remote
	remote == "0.0.0.0"
	ssh := input.objects[i].ssh
	ssh == "22"
	
	parent_id = input.objects[i].parent 
	
	input.objects[j].name == "ibm_is_subnet" 
	subnet_id := input.objects[j].id
	
	parent_id == subnet_id
	
	}