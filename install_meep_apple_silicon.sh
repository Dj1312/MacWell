## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add brew to path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/m1/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

## Install package necessary for Harminv/MPB/Meep
brew install hdf5 guile fftw gsl libpng autoconf automake libtool swig

echo 'export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"' >> /Users/m1/.zprofile
echo 'export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"' >> /Users/m1/.zprofile
echo 'export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"' >> /Users/m1/.zprofile

## Beginning of the install
mkdir InstallMeepFolder
cd InstallMeepFolder
brew install wget
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
chmod +x Miniforge3-MacOSX-arm64.sh
./Miniforge3-MacOSX-arm64.sh -b
source ~/miniforge3/bin/activate
conda create -n env_meep python=3.9 -y
conda activate env_meep

## Python requirements
HDF5_DIR="$(brew --prefix hdf5)" pip3 install numpy matplotlib scipy autograd jax parameterized h5py jaxlib mpi4py

## Harminv
wget https://github.com/NanoComp/harminv/releases/download/v1.4.1/harminv-1.4.1.tar.gz
tar xzf harminv-1.4.1.tar.gz
cd harminv-1.4.1
./configure CPPFLAGS="-I$(brew --prefix)/include" LDFLAGS="-L$(brew --prefix)/lib" PYTHON=python3 && make && sudo make install
cd ..

## Libctl
wget https://github.com/NanoComp/libctl/releases/download/v4.5.1/libctl-4.5.1.tar.gz
tar xzf libctl-4.5.1.tar.gz
cd libctl-4.5.1
./configure CPPFLAGS="-I$(brew --prefix)/include" LDFLAGS="-L$(brew --prefix)/lib" PYTHON=python3 && make && sudo make install
cd ..

## MPB
wget https://github.com/NanoComp/mpb/releases/download/v1.11.1/mpb-1.11.1.tar.gz
tar xzf mpb-1.11.1.tar.gz
cd mpb-1.11.1
./configure CPPFLAGS="-I$(brew --prefix)/include" LDFLAGS="-L$(brew --prefix)/lib" PYTHON=python3 && make && sudo make install
cd ..

## Meep
wget https://github.com/NanoComp/meep/releases/download/v1.23.0/meep-1.23.0.tar.gz
tar xzf meep-1.23.0.tar.gz
cd meep-1.23.0
./configure CPPFLAGS="-I$(brew --prefix)/include" LDFLAGS="-L$(brew --prefix)/lib" PYTHON=python3 --with-mpi && make && sudo make install
make check

## Link installed MEEP to conda env
ln -s /usr/local/lib/python3.9/site-packages/meep $CONDA_PREFIX/lib/python3.9/site-packages
