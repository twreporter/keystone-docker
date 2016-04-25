# keystone-docker
docker for Reporter editorial tool - [Keystone](https://github.com/twreporter/plate)


### installation
```
# make sure you login into the instance of google compute engine or install gcloud SDK
git clone https://github.com/twreporter/keystone-docker.git
cd keystone-docker
gcloud auth login
gcloud source repos clone default --project=coastal-run-106202
docker build -t keystone-plate .
```
[Google Cloud SDK Installation](https://cloud.google.com/sdk/downloads)
