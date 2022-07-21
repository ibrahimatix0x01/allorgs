echo [*] Executing ALLORGS against: Targets
echo "[*] Launching Subfinder"
subfinder -dL targets.txt -o subfinder.txt
RES=$(cat subfinder.txt | wc -l)
echo -e "\n[+] Subfinder completed with ${RES} results"
echo "[+] Output are saved to: subfinder.txt"
echo [*] Executing HTTPROBE against: Subfinder result
cat subfinder.txt | httprobe > probed.txt
echo "[+] Live subdomains are saved to: probed.txt"
nuclei -list probed.txt -o final.txt
echo "[+] Final results are saved to: final.txt"

