# Postgres Helm Setup

### Kubeconfig 

- Follow the instructions to create config
https://tc-sb.code.siemens.io/cloud/platform-service/docs/cicd/
- Afterwards execute a base64 encoding and add the result as a repository secret wiht the name KUBECONFIG

### Create service user

Save the init.sql script into a configmag. This script will be automatically exectuted after starting the postgres instance.
```bash
kubectl apply -f service-user.yaml --namespace alm-energymonitor
```

### Create tables 

Save the init.sql script into a configmag. This script will be automatically exectuted after starting the postgres instance.
```bash
kubectl create configmap postgres-init-scripts --from-file=init.sql
```

### Install helm chart
```bash
helm install postgres bitnami/postgresql --namespace alm-energymonitor -f values.yaml
```

After modifying values.yaml run
```bash
helm upgrade postgres bitnami/postgresql --namespace alm-energymonitor -f values.yaml
```

### Connection
These are the default values if not changed in the values.yaml

- Postgres host: postgres-postgresql
- Postgres port: 5432
- Postgres database: postgres
- Password:

```bash
kubectl get secret --namespace alm-energymonitor postgres-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d
```