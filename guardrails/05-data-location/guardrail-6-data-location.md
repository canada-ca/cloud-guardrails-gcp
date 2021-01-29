## Data Location 

### Establish policies to restrict GC sensitive workloads to approved geographic locations


The deployment template provides variables to set defaults. One of the variables is default_region which defines the default region to create resources. By setting the default to Montreal which is northamerica-northeast1 then the resource creation will be restricted to only that region. For details on the template please see [Bootstrap Template](https://github.com/terraform-google-modules/terraform-example-foundation/tree/master/0-bootstrap)

    
### Restricting Resource on the entire Organization<BR>
You can also choose to provide an Organization Policy which would restrict any future resource creation for the entire organization. You can find details on this option here [Restricting  Resource Location]("https://cloud.google.com/resource-manager/docs/organization-policy/defining-locations")
    

### **Validation**
The validation template will search the entire Cloud Asset Inventory for any resources that are not located on the default region
