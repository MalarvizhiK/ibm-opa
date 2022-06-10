package ibm.network

import future.keywords.in

# default has_vpc_security_group_rules_allow_all_inbound_ssh = [{"errors":"No errors","id":"has_vpc_security_group_rules_allow_all_inbound_ssh","result":true}]	# unless otherwise defined, has_vpc_security_group_rules_allow_all_inbound_ssh is false

has_vpc_security_group_rules_allow_all_inbound_ssh[response]   {			 # allow is true if...

    input.objects[_].name == "ibm_is_vpc" 
	input.objects[_].name == "ibm_is_subnet" 
    input.objects[_].name == "ibm_is_security_group_rule" 

	
	
	errors := [r | e := check_security_group_rule[_]
                   r := e.errors]
	errors1 := [r | e := check_subnet[_]
    			  	r := e.errors]

	err := 	[errors, errors1]			  

	result := ((count(errors) + count(errors1)) == 0)		
	# concat(" ", [errors, errors1])""		  

	response := {
      "id" : "has_vpc_security_group_rules_allow_all_inbound_ssh",
	  "result" : result,
      "errors" : err
    }	
	}


	check_security_group_rule [response] {

		some i
		input.objects[i].name == "ibm_is_security_group_rule" 
		
		direction := input.objects[i].direction
		remote := input.objects[i].remote
		ssh := input.objects[i].ssh
		
		direction == "inbound" 
		ssh == "22" 
		remote == "0.0.0.0" 

		response := {
			"id" : "has_vpc_security_group_rules_allow_all_inbound_ssh",
			"result": false,
			"errors" : "security group rule has public internet ip"
		}

	} 

	check_subnet [response] 
	{
		some i, j
		parent_id = input.objects[i].parent 
			
		input.objects[j].name == "ibm_is_subnet" 
		subnet_id := input.objects[j].id
			
		parent_id == subnet_id

		response := {
		"id" : "has_vpc_security_group_rules_allow_all_inbound_ssh",
		"result": false,
		"errors" : "parent is not a subnet"
		}

	}