#!/bin/bash
# Solution for 'Programmer not responding on OSX 10.9
cd /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns
sudo mv AppleUSBFTDI.kext AppleUSBFTDI.disabled
sudo touch /System/Library/Extensions
