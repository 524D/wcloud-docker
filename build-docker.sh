PRG=wcloud
DOCKER_USER=robmarissen

git clone "https://github.com/isaackd/${PRG}.git"

# Get version from git
cd wcloud
VERSION=$(git describe --abbrev --dirty --always --tags)
cd ..
VERSION=${VERSION#"v"}

# Create Docker image
docker build --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Push Docker image
#docker push "${DOCKER_USER}/${PRG}:${VERSION}"
