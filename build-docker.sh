PRG=wcloud
DOCKER_USER=robmarissen

# Make sure we don´t have a stale ${PRG} binary or dir
rm -rf ${PRG}

mkdir -p build
cd build

if [ ! -d "${PRG}" ]; then
  git clone "https://github.com/isaackd/${PRG}.git"
fi

cd ${PRG}

# Update the repository
git pull

# Get version from git
VERSION=$(git describe --abbrev --dirty --always --tags)
VERSION=${VERSION#"v"}

# We want a full static binary
rustup target add x86_64-unknown-linux-musl

# Build the binary
cargo install --target=x86_64-unknown-linux-musl --force ${PRG}

cd ../..

cp ~/.cargo/bin/${PRG} ${PRG}

# Create Docker image
docker build --no-cache --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Test the Docker image
docker run --rm "${DOCKER_USER}/${PRG}:${VERSION}" /bin/wcloud --help

# Push Docker image
docker push "${DOCKER_USER}/${PRG}:${VERSION}"

# Remove the binary
rm ${PRG}
