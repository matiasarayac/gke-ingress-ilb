# Configuring Ingress for internal Application Load Balancers

### Introduction
This repository contains the steps and files to create a GKE cluster with an internal ingress load balancer based on the official [Google Cloud documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/internal-load-balance-ingress). The intent is not to explain any commands, but simply to create the environment and deploy a sample application.

### 1. Create environment (proxy-only subnet, firewall rule and GKE cluster)

```
sh gcloud-create-env.sh
```

Note that this step doesn't create a network or subnetwork. Replace your network on the `gcloud-create-env` file.

### 2. Apply deployment, service and ingress on GKE
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f internal-ingress.yaml
```

### 3. Validating a successful Ingress deployment
#### 3.a Retrieve Ingress IP
```
kubectl get ingress ilb-demo-ingress
```
The output is similar to the following:
```
NAME               HOSTS    ADDRESS            PORTS     AGE
ilb-demo-ingress   *        10.128.0.58        80        59s
```

#### 3.b Create a Compute Engine in the same subnet
```
gcloud compute instances create l7-ilb-client-us-central1-a \
    --image-family=debian-10 \
    --image-project=debian-cloud \
    --network=default \
    --subnet=default \
    --zone=us-central1-a \
    --tags=allow-ssh
```
#### 3.b SSH in to the VM that you created in the previous step
```
gcloud compute ssh l7-ilb-client-us-central1-a \
   --zone=us-central1-a
```
#### 3.c Use curl to access the internal application VIP
```
curl 10.128.0.58
hostname-server-6696cf5fc8-z4788
```
