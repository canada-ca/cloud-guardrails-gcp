package check10

#This will check that log sink exists to save the logs auditing and monitoring


#the exmaple below uses name "log_sink", change this name to match the existing name

sink_name := "log_sink"

#	rolebinding.role == roles
#}

# Validate Role Exists
 check_role[{"msg": message}] {
  not sink_name == input.name
  message :=sprintf("The role '%s' does not exist", [input.name])
}