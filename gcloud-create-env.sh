# Prepare your environment
gcloud compute networks subnets create proxy-only-subnet \
    --purpose=REGIONAL_MANAGED_PROXY \
    --role=ACTIVE \
    --region=us-central1 \
    --network=vpc-composer \
    --range=10.129.0.0/23

# Create a firewall rule
gcloud compute firewall-rules create allow-proxy-connection \
    --allow=TCP:9376 \
    --source-ranges=10.129.0.0/23 \
    --network=vpc-composer

# Creating a cluster
gcloud container clusters create-auto gke-cluster-demo \
    --region us-central1 \
    --subnetwork subnet-composer \
    --network vpc-composer
