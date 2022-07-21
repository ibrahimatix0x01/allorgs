TARGET=$1
if ! [ $TARGET ]; then
  echo "[!] No target provided."
  echo ">> $0 <targets.txt>"
  exit 1
fi
OUT_DIR=$(pwd)
mkdir $TARGET
echo [*] Executing ALLORGS against: ${TARGET}
echo "[*] Launching Subfinder"
subfinder -dL $TARGET -o $OUT_DIR/$TARGET/subfinder.txt
RES=$(cat subfinder.txt | wc -l)
echo -e "\n[+] AllORGS complete with ${RES} results"
echo "[+] Output are saved to: $OUT_DIR/$TARGET/subfinder.txt"
echo [*] Executing ALLORGS against: All the domains
cat $OUT_DIR/$TARGET/subfinder.txt | httprobe > $OUT_DIR/$TARGET/probed.txt
echo "[+] Live subdomains are saved to: $OUT_DIR/$TARGET/probed.txt"
nuclei -list $OUT_DIR/$TARGET/probed.txt -o $OUT_DIR/$TARGET/final.txt
echo "[+] Final results are saved to: $OUT_DIR/$TARGET/final.txt"
exit 0
