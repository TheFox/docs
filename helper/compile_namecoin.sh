
# Compile Namecoin on macOS.

# Install dependencies.
brew install berkeley-db boost libevent pkg-config libtool

# Compile Namecoin
# Tested with Git Commit 419bc56d98cd650f23d53d817fb30955621938ea
git clone git@github.com:namecoin/namecoin-core.git
cd namecoin-core
./autogen.sh
./configure --with-incompatible-bdb
make
