# Spring PetClinic application migration to GCP.

As part of the migration, the following services have been deployed:
1. GKE cluster and node pool.
2. Cloud SQL instance with Postgres.
3. Private service connect.
4. Service Account for the GKE cluster.

## Folder structure of Terraform and Helm.

```
.
├── helm
│   ├── Chart.yaml
│   ├── install-chart.sh
│   ├── README.md
│   ├── templates
│   └── values.yaml
├── README.md
└── terraform
    ├── main.tf
    ├── modules
    │   ├── cloud_sql
    │   ├── gke_cluster
    │   ├── gke_node_pool
    │   ├── private_service_connection
    │   └── service_account
    ├── provider.tf
    └── variables.tf

```

## Deployment Steps

1. Add the below parameter in `src/main/resources/application.properties` file so that the spring application fetches data from PostgresSQL database.
```
# To use postgreSQL
spring.profiles.active=postgres
```

2. To build the docker image of the PetClinic Application execute the below command:
```
./mvnw spring-boot:run
```

3. Re-tag the image and push it to DockerHub.
```
docker login
docker tag spring-petclinic:3.3.0-SNAPSHOT <your-dockerhub-username>/<image-name>:<tag>
docker push <your-dockerhub-username>/<image-name>:<tag>
```

4. Export the variable for postgreSQL user.
```
export TF_VAR_sql_user_password=<DB user password>
```

5. Create the infrastructure. Go to `terraform/` folder and initialize terraform
```
terraform init
```

6. View the plan of the resources to be provisioned.
```
terraform plan
```

7. Execute terraform to provision the infrastructure.
```
terraform apply
```

8. Encode Docker credentials image pull secret.
```
cat ~/.docker/config.json | base64
```

9. Create K8s manifest to create image pull secret.
```
apiVersion: v1
kind: Secret
metadata:
  name: my-docker-secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: <base64 encoded value of the docker config.json>
```
10. Apply the manifest
```
kubectl apply -f <filename>
```

11. Go to `helm/` folder and make the below changes in the values.yaml
```
# Database configuration
POSTGRES_PASS: <DB user password>
POSTGRES_URL: jdbc:postgresql://<PostgreSQL instance IP>/<DB name>
POSTGRES_USER: <DB user name>
database: <DB name>

# Image related configuration.
image: "<your-dockerhub-username>/<image-name>"
image_pull_policy: "Always"
image_pull_secret: <Image pull secret name>
image_tag: "<tag>"

```

12. To deploy the helm chart use the below command.
```
helm install <release name> <path to helm folder>
```
## Steps to insert data to Database

1. In the spring boot application source code, go to this folder to get the data and schema sql files.
```
cd /home/mayureshtamhane02/helm/spring-petclinic/src/main/resources/db/postgres/
```

2. Login to the database using psql command and provide the password
```
psql -h <Cloud SQL IP address> -p 5432 -U <DB user name> -d <database>
```
3. Run the `data.sql` and `schema.sql` files.


## Future Scope.

1. Allowing only SSL connection to ingress and cloud sql.
2. Using redis for caching. 

## Challenges faced.

1. **Using PostgreSQL for the application** - The application uses in-built h2 database by default. 
2. **Service Port** - Service port in helm values generated was different than the actual port.