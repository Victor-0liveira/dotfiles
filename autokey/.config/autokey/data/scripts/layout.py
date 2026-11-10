import time
from subprocess import check_output

# Nome dos processos a serem monitorados
TARGET_APPS = ["code", "alacritty"]

def is_app_running(app_name):
    try:
        # Lista todos os processos e verifica se o app está em execução
        processes = check_output(["pgrep", "-fl", app_name]).decode("utf-8")
        return app_name in processes
    except:
        return False

# Loop para verificar o processo
while True:
    for app in TARGET_APPS:
        if is_app_running(app):
            # Pressiona Super + Space quando o app é detectado
            keyboard.send_keys("<super>+<space>")
            # Aguarda um pouco para evitar repetição
            time.sleep(5)
    time.sleep(1)  # Aguarda antes de verificar novamente
