import os
import subprocess
import signal

gpid = subprocess.check_output(["pgrep","itekiserv"])
os.kill(int(gpid), signal.SIGUSR1)
