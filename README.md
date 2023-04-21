# Planetary

#### Measurement of energy consumption level on various layers of infrastructure and application components

## Architecture

<img src="architecture.png" alt="" style="height: 250px"/>

## Components

The components are added are submodules to this repository.

```bash
git clone --recursive git@github.siemens.cloud:ALM/planetary.git
```

Or if you already cloned the repository, you can run the following command to initialize the submodules:

```bash
git submodule update --init --recursive
```

## K8s deployment

The deployment is automated using a Github Action but requires some initial setup.
The action is triggered by a push to the main branch.
The action will build the docker images and push them to the Falcon Artifactory and afterwards deploy the application to
the cluster.

### Requirements

1. Create a kubeconfig file for the cluster and save it as repository secret (KUBECONFIG)
    - https://tc-sb.code.siemens.io/cloud/platform-service/docs/cicd/
2. Create a service account to use for deployment
    - https://tc-sb.code.siemens.io/cloud/platform-service/docs/cicd/
    - When using the tempale, add statefulsets to resources of the apiGroup "" (required for postgres)
3. Create secret with credentials for the Artifactory
   ```bash
   kubectl create secret docker-registry regcred --docker-server=falcon.rtf-alm.siemens.cloud --docker-username=<usename> --docker-password=<password> --docker-email=<mail>
   ```
4. Create secret for the services
   ```bash
   kubectl create secret generic planetary-secrets --from-env-file=.secrets
   ```
5. Adopt the ```config/config.yaml``` file to your needs
   ```bash
   kubectl apply -f config/config.yaml
   ```




