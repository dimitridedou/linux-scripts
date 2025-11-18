#!/bin/bash

echo "Χρήση δίσκου:"
df -h

# Έλεγχος μνήμης
echo "Χρήση μνήμης:"
free -h

# Έλεγχος χρήσης CPU
echo "Χρήση CPU:"
top -bn1 | grep "Cpu(s)"
