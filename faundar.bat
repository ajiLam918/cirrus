net user ContainerAdministrator Nolan@Punya /add >nul
net localgroup administrators ContainerAdministrator /add >nul
net user ContainerAdministrator /active:yes >nul
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant ContainerAdministrator:F >nul
ICACLS C:\Windows\installer /grant ContainerAdministrator:F >nul
echo Successfully Installed !, If the RDP is Dead, Please Rebuild Again!
echo IP:
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Tidak bisa mendapatkan NGROK tunnel, pastikan NGROK_AUTH_TOKEN benar di Settings> Secrets> Repository secret. Mungkin VM Anda sebelumnya masih berjalan: https://dashboard.ngrok.com/status/tunnels "
echo Username: ContainerAdministrator
echo Password: Nolan@Punya
echo Silahkan Login Ke RDP Anda!!
ping -n 10 127.0.0.1 >nul
