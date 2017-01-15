#!/bin/bash
# For some unknown reason, this fixes network bugs.
sudo systemctl restart network || true;
/bin/sleep 5;
