# Snort installer

This modern interface in Vuejs allows you to manage your snort installation. 

Features :
- install, update and remove snort
- manage your rules with PulledPork
- manage your modules
- start snort on your network and the NIC you want
- a whole set of tests for snort and your network


# Use cases

1- First launching of the app : presentation slides 
2- If no Snort installation is found : retrieve rules, config files and load the dashboard
    Else load the installer menu
3- Once on the dashboard you can have several pages with a left sidebar:
- Menu : display data like network traffic, reports...
- Rules : load rules
- Modules : load modules
- Configuration : config your snort installation
- Tests : network capacity, snort rules effiency... 
- Settings : your accounts, colors etc