printf "# Preparing environment..."
echo "ngrok-v3-stable-windows-amd64.zip" > ngrok_zip_name
echo $env:UserName > ssh_user
printf " [DONE]\n\n"
echo "# Install SSH server"
curl https://dl.bitvise.com/BvSshServer-Inst.exe --output BvSshServer-Inst.exe
.\BvSshServer-Inst.exe -acceptEULA -defaultInstance
printf "# Setting up the SSH server to allow access..."
$cfg = new-object -com "Bitvise.Bsscfg"
$cfg.settings.SetDefaults()
$cfg.settings.access.SetDefaults()
$cfg.settings.access.winGroups.Clear()
$cfg.settings.access.winGroups.new.SetDefaults()
$cfg.settings.access.winGroups.new.loginAllowed = $true
$cfg.settings.access.winGroups.NewCommit()
$cfg.settings.Save()
printf " [DONE]\n\n"
echo "# Add Firewall rule to allow inbound TCP connection on local port 22"
New-NetFirewallRule -Name ngrok -DisplayName 'ngrok' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
echo "# Start the SSH server"
net start BvSshServer
echo "# Change the SSH user password"
net user $env:UserName magalih123@+
