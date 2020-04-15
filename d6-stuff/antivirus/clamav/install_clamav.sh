#!/bin/bash

( brew list --versions clamav > /dev/null ) || brew install clamav || exit

# next run install_clamav_configs.sh (assuming patches are premade)
# next run install_clamav_daemons.sh (assuming plists are premade)

echo "execute install_clamav_configs.sh now."
