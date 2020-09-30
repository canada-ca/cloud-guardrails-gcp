# Encryption in Transit in Google Cloud

### Comprehensive In-Transit Encryption Method Information: [Encryption In-Transit Whitepaper][]

<a href="https://www.youtube.com/watch?v=Svz2KHE1mdM&autoplay=1"><p align = "center"><img src="./images/video-in-transit.png" width="300"></img></p></a>


GCP uses a FIPS 140-2 validated module called BoringCrypto (certificate 2964) in our production environment. This means that data in transit to the customer and between data centers as well as data at rest is encrypted using FIPS 140-2 validated cryptography. The module that achieved FIPS 140-2 validation is part of our BoringSSL library. All regions and zones currently support FIPS 140-2 mode.

## **Encryption in Transit by Default**
Google encrypts and authenticates all data in transit at one or more network layers when data moves outside the physical boundaries controlled by Google.  Google uses various methods of encryption, both default and user configurable, for data in transit.  The type of encryption used depends on the OSI layer, the type of service and the physical component of the infrastructure.  The figures below illustrate the optional and default protections Google Cloud has in place for layers 3, 4 and 7

- **Protection by Default and Options at Layer 3 & 4 across Google Cloud**
<p align = "center"><img src="./images/encryption-by-default-1.svg" width="700"></img></p>

- **Protection by Default and Options at Layer 7 across Google Cloud**
<p align = "center"><img src="./images/encryption-by-default-2.svg" width="700"></img></p>

Diagram below further depicts protection by default and options overlaid on Google Networking depending on five kinds of routing requests:
1. End user (Internet) to Google Cloud Service
2. End user (Internet) to a customer application hosted on Google Cloud
3. Virtual Machine to Virtual Machine
4. Virtual Machine to Google Cloud Service
5. Google Cloud Service to Google Cloud Service

<p align = "center"><img src="./images/protection-by-default.svg" width="600"></img></p>


### **Ongoing Innovation in Encryption in Transit**
Google plans to remain the industry leader in encryption in transit. To this end, we have started work in the area of post-quantum cryptography. This type of cryptography allows us to replace existing crypto primitives, that are vulnerable to efficient quantum attacks, with post-quantum candidates that are believed to be more robust. For more information, please refer to: https://cloud.google.com/security/encryption-in-transit#chrome_security_user_experience 




[Encryption In-Transit Whitepaper]: https://cloud.google.com/security/encryption-in-transit