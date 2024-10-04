PRG=wcloud
DOCKER_USER=robmarissen


if [ -d "${PRG}" ]; then
  git clone "https://github.com/isaackd/${PRG}.git"
fi

cd ${PRG}

cargo install wcloud

cd ..

mkdir -p bin

cp ~/.cargo/bin/wcloud bin/wcloud
# Get version from git
cd ${PRG}
VERSION=$(git describe --abbrev --dirty --always --tags)
VERSION=${VERSION#"v"}

# Create Docker image
docker build --no-cache --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Push Docker image
#docker push "${DOCKER_USER}/${PRG}:${VERSION}"

cd ..
