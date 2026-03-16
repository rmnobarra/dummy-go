# dummy-go

A simple Go HTTP API sample with Docker and Kubernetes support.

## Endpoints

| Method | Path | Description |
|---|---|---|
| GET | `/hello` | Returns a greeting message with current timestamp |
| GET | `/health` | Returns API health status |

## Requirements

- [Go 1.22+](https://golang.org/dl/)
- [Docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (for Kubernetes deployment)

## Running locally

```bash
# Run directly with Go
make run

# Or build and run the binary
make build
./bin/server
```

The API will be available at `http://localhost:8080`.

## Docker

```bash
# Build the image
make docker-build

# Run the container
make docker-run

# Stop the container
make docker-stop
```

Override defaults as needed:

```bash
make docker-build TAG=v1.0.0
make docker-run PORT=9090
```

## Kubernetes

Apply the manifests to your cluster:

```bash
kubectl apply -f k8s/deployment.yaml
```

This creates a `Deployment` with 2 replicas and a `ClusterIP` `Service` on port 80.

To verify the deployment:

```bash
kubectl get pods -l app=dummy-go
kubectl get svc dummy-go
```

To test locally via port-forward:

```bash
kubectl port-forward svc/dummy-go 8080:80
curl http://localhost:8080/health
```

## CI/CD

The GitHub Actions workflow (`.github/workflows/build-push.yml`) triggers on every push to `main` and:

1. Builds the Docker image
2. Tags it as `latest` and `sha-<short-sha>`
3. Pushes to DockerHub as `rmnobarra/dummy-go`

### Required secrets

| Secret | Description |
|---|---|
| `DOCKERHUB_USERNAME` | DockerHub username |
| `DOCKERHUB_TOKEN` | DockerHub access token |

## Project structure

```
.
├── main.go                          # Application entrypoint
├── go.mod                           # Go module definition
├── Dockerfile                       # Multi-stage Docker build
├── Makefile                         # Local development commands
├── .github/
│   └── workflows/
│       └── build-push.yml           # CI/CD pipeline
└── k8s/
    └── deployment.yaml              # Kubernetes Deployment and Service
```
