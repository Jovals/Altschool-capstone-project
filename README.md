# Altschool-capstone-project### Deployment of Sock Shop Microservices Application on Kubernetes

This project involves deploying the socks shop application on kubernetes cluster using Infrastructure as a code(Iac) approach. This includes provisioning the necessary infrastructure on AWS using terraform, setting up a deployment pipeline, monitoring the performance and health of the application and securing it.

This project was implemented with Terraform for the provision of infrastructure, GitHub Actions for the deployment pipeline, kubernetes for container orchestration, prometheus for monitoring,

## Projet Requirement
- Terraform
- AWS account
- Kubernetes
- Prometheus and grafana for monitoring
- Let's Encrypt
- Helm

## Prerequisites 
- An AWS Account
- Terraform
- GitHub Actions
- Kubernetes
- Prometheus
- sock shop application

# Project

First of all, To do that, make sure you have terraform installed and have installed the AWS CLI and configured it.

Then, we have to provision our infrastruture on AWS which consist of a VPC, Security group, and an EKS cluster by first writing the terraform code. 
Then run the command 
`terraform init`
After than you check the plan of your infrastructure by running the command: 
`terraform plan`
After you are sure the infrastructre to be created is what you want, you provision it with the command:
`terraform apply --auto-approve`
The '--auto-approve' flag is so you won't get any prompt while the infrastructure is being provisioned. 
(picture of the EKS clauser creation/vpc ) [!]

The next step is to make sure your kubectl connected to the EKS Cluster you just provisioned and this is by updating the kube-config file. To do that, run the command:
`aws eks update-kubeconfig --region us-east-1 --name sock-shop`
(pic of the command)

So now we can push the kubernetes manifest into the EKS cluster we created which is in the deployment.yml file by running the command:
`kubectl apply -f deployment.yml`
(pic of the creation of manifest)

We can check our pods and svc to be sure they are running with the commands:
`kubectl get pods -n sock-shop`
`kubectl get svc -n soc-shop`
(pic of pods and services)

Now that we have our pods and services running on our cluster. We see that our services are pods are not accessible to the users because they all have cluster IPs. So be able to connect to the deployed app in the cluster. To do that, we have to install the ingress controller which creates a load balancer. We do this because it is not easy to create a load balancer on kubernetes. The users connect to the load balancer and it routes traffic to the application/cluster. To do this, we run the command: 
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml`
(pic of ingress controller installation)
(pic of load balancer in the UI)

Next is for us to create and apply our ingress file. The ingress file gives us a more simple and flexible way to connect to our cluster. It allows for a single point entry to our cluster as opposed to exposing multiple services seperately. Ingress also allows us to use one load balancer. Without it, each service we want to expose will require it's own load balancer. 

So we create the ingress file and apply with the command:
`kubectl apply -f ingress.yml -n sock-shop`

ideally, if we run the load balancer IP on the browser, it wont serve the application. But we can resolve that by either connecting it to a domain name or DNS mapping. For this project it was connected to a domain name with an A record. 
(pic of the frontend page)

Next is to encrypt our application with Lets encrypt so it can render with https. 




 





Ami type for node group. (explain)
creating 2 node groups for more availability: so it will be in more than one availabity zones. That is why we don't create 1
first step is to create an EKS cluster, security group and a VPC on aws with terraform. (pic of the creation of the EKS)
explain the idea behind the vpc creation and the eks creation.

When you try to run kubectl get pods to get access to the pods in the cluster, it fails because the host is not updated in the kube config file. kubectl is not connected to the EKS we created. Pic of kubectl get pods error
update the kube config file to give us access to the EKS from our cli so we can run commands from our cli and connect to the api server of the master node and control the other nodes and pods.  
deploy microservice application
`aws eks update-kubeconfig --region us-east-1 --name sock-shop`
pics of kubectl config files, confirming if we have access to the nodes

creation of the sockshop namespace. (pic of the creation of the namespace)
get pods command success
get svc success. (pic of svc success)
create an ingress file for the kubernetes cluster (explain more)
apply the ingress to the name space
check if the ingress is applied and working
So consider that the type of IP it are all cluster ip which means these nodes cannot be reached, we need to create an ingress controller that will create a load balancer and it will expose our application using this ngnix ingress controller. 
To install the ngnix ingress controller, we run the command 
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml`
Ingress controller watches the ingress resources and creates load balancer because it is not easy to create a load balancer on a kubernetes resource (post load balancer and ingress confirmation here)
If we paste the link on our load balancer page, it does not work (pic of error page)
so we connect the load balancer to our domain name and and it works 
`kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.2/cert-manager.yaml` 

For monitoring:
create monitoring name space with `kubectl create -f 00-monitoring-ns.yml`
`kubectl apply $(ls *-prometheus-*.yml | awk ' { print " -f " $1 } ')`
`kubectl apply $(ls *-grafana-*.yml | awk ' { print " -f " $1 }'  | grep -v grafana-import)`
`kubectl apply -f 23-grafana-import-dash-batch.yml `

Using helm for grafana, prometheus and cert-manager 
first we add the repo with the command 
we create a custom-values.yml file, 

`helm repo add prometheus https://prometheus-community.github.io/helm-charts`

then we search for the chart we need with the command `helm search repo prometheus` picture of charts

when the values of the charts are check, the prometheus/kube-prometheus-stack chart creates both prometheus, grafana and alert manager so we run `helm install prometheus prometheus/kube-prometheus-stack -n sock-shop`
or `helm install prometheus prometheus/kube-prometheus-stack  -n monitoring --create-namespace`
(pic of prometheus stack install, pods and service)

Then we updata our ingress file to be able to access prometheus and grafana and alert manager on our browser.

The error page because of the wrong port (input pic)

first install helm repo with the command
`helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`
and updaate with the command `helm repo update`
(add pic of helm repo add)


alertmanager-prometheus-kube-kube-prome-alertmanager-0
