PRG=wcloud
DOCKER_USER=robmarissen

mkdir -p build
cd build

if [ -d "${PRG}" ]; then
  git clone "https://github.com/isaackd/${PRG}.git"
fi

cd ${PRG}

# Update the repository
git pull

# Get version from git
cd ${PRG}
VERSION=$(git describe --abbrev --dirty --always --tags)
VERSION=${VERSION#"v"}

# Build the binary
cargo install wcloud

cd ../..

cp ~/.cargo/bin/wcloud wcloud

# Create Docker image
docker build --no-cache --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Test the Docker image
docker run --rm "${DOCKER_USER}/${PRG}:${VERSION}" --help

# Push Docker image
#docker push "${DOCKER_USER}/${PRG}:${VERSION}"

# Remove the binary
rm wcloud
