###########################################################################
###   Three Tier Environment Deployment in GCP using Terrafrom   #########
##########################################################################

Folder Structure
1. Architecture - Contain architecture diagram of the system
2. Terraform - Contain IaaC code 

#Architecture:
Detailed Architecture Diagram is depicted in given folder. 

#Design Considerations :
    1. Use 3 Tier Architecture to host application and data
    2. Use Cloud Native solution wherever possible
    3. Use Serverless solutions wherever possible

# Presntation Layer
    1. Google Cloud App Engine is used to host nodejs application. 
    2. Serverless
    3. Globally available
    4. External Load Balancer is used along with Cloud Armour for Security 
        and load balancing
    5. Protected behind firewall rules

# Application/Service Layer
    1. Cloud Run is used to host services.
    2. Serverless
    3. containarized
    4. Globally available
    5. paired with internal load balance for optimum performance

# Data Layer
    1. Cloud Spanner is used for transactional data
    2. Highly available and Scalable
    3. Cloud Firestore is used to store application data such as user profiles, 
     configurations, static content etc

