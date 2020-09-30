# Encryption at rest in Google Cloud

### Comprehensive Encryption at rest Information: [Encryption at Rest Whitepaper][]

<a href="https://www.youtube.com/watch?v=Svz2KHE1mdM&autoplay=1"><p align = "center"><img src="./images/video-at-rest.png" width="300"></a>

## **Google's default encryption**

### **Encryption of data at rest**
Google Cloud Platform **encrypts all customer data at rest without any action required from you**, the customer.Google Cloud Platform encrypts all customer data at rest without any action required from you, the customer.   Google uses a common cryptographic library, Keyczar, to implement encryption consistently across almost all Google Cloud Platform products.  This includes data stored in cloud storage, computer engine persistent disks, cloud SQL databases, virtually everything.

### **Layers of Encryptions**


- **Protection by Default and Options at Layer 3 & 4 across Google Cloud**

![encryption1](/images/encryption-by-default-1.svg)



[Encryption at Rest Whitepaper]: https://cloud.google.com/security/encryption-at-rest/default-encryption