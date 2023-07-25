# Prepare your environment
gcloud compute networks subnets create proxy-only-subnet \
    --purpose=REGIONAL_MANAGED_PROXY \
    --role=ACTIVE \
    --region=us-central1 \
    --network=vpc-composer \
    --range=10.129.0.0/23

# Create a firewall rule
gcloud compute firewall-rules create allow-proxy-connection \
    --allow=TCP:CONTAINER_PORT \
    --source-ranges=10.129.0.0/23 \
    --network=vpc-composer

# Creating a cluster
# Change network as needed
gcloud container clusters create-auto gke-cluster-demo \
    --region=us-central1 \
    --network=vpc-composer
