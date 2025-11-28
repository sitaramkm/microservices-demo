git restore kustomization.yaml
git restore components/container-images-tag/kustomization.yaml
git restore components/container-images-registry/kustomization.yaml

kustomize edit add component components/non-public-frontend
#kustomize edit add component components/service-accounts
kustomize edit add component components/without-loadgenerator

#TAG=v0.10.3.06062025
TAG=v0.10.2.0124202501
sed -i'.bak' -e "s/CONTAINER_IMAGES_TAG/$TAG/g" components/container-images-tag/kustomization.yaml
kustomize edit add component components/container-images-tag

REGISTRY=sitaramiyer222 #Example: gcr.io/my-project/my-directory
sed -i'.bak' -e  "s|CONTAINER_IMAGES_REGISTRY|${REGISTRY}|g" components/container-images-registry/kustomization.yaml
kustomize edit add component components/container-images-registry

rm -rf components/container-images-tag/kustomization.yaml.bak
rm -rf components/container-images-registry/kustomization.yaml.bak

kubectl kustomize . > ../release/kubernetes-manifests.yaml

git restore kustomization.yaml
git restore components/container-images-tag/kustomization.yaml
git restore components/container-images-registry/kustomization.yaml
