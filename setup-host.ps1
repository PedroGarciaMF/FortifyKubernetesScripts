
# Download Vagrant MSI installer - https://developer.hashicorp.com/vagrant/downloads
Invoke-WebRequest -Uri "https://releases.hashicorp.com/vagrant/2.3.4/vagrant_2.3.4_windows_amd64.msi"  -OutFile "vagrant.msi"

# Download Vagrant VMware Utility MSI installer - https://developer.hashicorp.com/vagrant/downloads/vmware
Invoke-WebRequest -Uri "https://releases.hashicorp.com/vagrant-vmware-utility/1.0.21/vagrant-vmware-utility_1.0.21_x86_64.msi" -OutFile "vagrant-vmware-utility.msi"

# Install Vagrant
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i vagrant.msi /quiet /norestart" -Wait

# Install Vagrant VMware Utility
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i vagrant-vmware-utility.msi /quiet /norestart" -Wait

# Display Vagrant version and installed plugins
Write-Host "Installing Vagrant VMWare Desktop plugin:"
vagrant plugin install vagrant-vmware-desktop

Write-Host "Vagrant version:"
vagrant --version

Write-Host "Installed Vagrant plugins:"
vagrant plugin list
