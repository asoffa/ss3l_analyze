# ss3l_analyze

HEP analysis with a kick.


## Installation and environment setup

1. Install [Crystal](https://github.com/crystal-lang/crystal/releases) if not already installed
2. `export CRYSTAL_DIR="/path/to/crystal"` (with `path/to/crystal` replaced by the actual path to the Crystal directory)
3. Set up the ATLAS software and ROOT:
    * `export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase`
    * `source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh`
    * `lsetup root --skipConfirm`
4. `make`

You are then ready to run the executables in the `bin` directory that is created.

