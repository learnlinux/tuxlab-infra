#!/bin/bash
# For some unknown reason, this fixes network bugs.
/bin/sleep 5;
sudo systemctl restart network || true;
/bin/sleep 5;
