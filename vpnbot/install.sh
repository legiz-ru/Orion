#!/bin/bash

# Цвета для красивого вывода в консоль
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Путь к файлу конфигурации
TARGET_FILE="/root/vpnbot/app/subscription.php"
# URL для загрузки файла
DOWNLOAD_URL="https://raw.githubusercontent.com/legiz-ru/Orion/refs/heads/claude/add-encrypted-link-variables-2Jktz/vpnbot/subscription.php"

# --- Выбор языка ---
LANG=""
while [[ "$LANG" != "ru" && "$LANG" != "en" ]]; do
    read -p "Выберите язык / Choose language (ru/en): " LANG
    LANG=$(echo "$LANG" | tr '[:upper:]' '[:lower:]')
    if [[ "$LANG" != "ru" && "$LANG" != "en" ]]; then
        echo "Неверный ввод. Пожалуйста, введите 'ru' или 'en'."
        echo "Invalid input. Please enter 'ru' or 'en'."
    fi
done

# --- Тексты на разных языках ---
if [ "$LANG" = "ru" ]; then
    STR_STARTING="Запуск скрипта установки страницы подписки..."
    STR_DOWNLOADING="Загрузка файла subscription.php..."
    STR_DOWNLOAD_ERROR="Ошибка: Не удалось загрузить файл subscription.php. Проверьте подключение к интернету."
    STR_VALUE_CHANGED="Значение для"
    STR_SUCCESSFULLY_CHANGED="успешно изменено."
    STR_DEFAULT_LEFT="Оставлено значение по умолчанию."
    STR_ENTER_TO_LEAVE="нажмите Enter, чтобы оставить"
    Q_PAGENAME="Хотите указать своё имя страницы?"
    Q_PAGEDESC="Хотите указать своё описание внизу страницы?"
    Q_SUPPORTURL="Хотите указать свою ссылку портала поддержки?"
    Q_ANNOUNCE="Хотите указать своё сообщение анонс?"
    Q_APPSCONFIG="Хотите использовать свой список приложений? (Формат списка Remnawave 2.1.0+)"
    Q_BRANDINGTITLE="Хотите указать свой заголовок бренда?"
    Q_BRANDINGLOGO="Хотите указать свой логотип бренда (URL)?"
    STR_APPLYING="Применяем изменения и перезапускаем vpnbot..."
    STR_SUCCESS_MSG="Страница подписки успешно установлена!"
    STR_MAKE_ERROR="Ошибка: Команда 'make r' завершилась с ошибкой."
    STR_DIR_NOT_FOUND="Ошибка: Директория /root/vpnbot не найдена."
    Q_PRESERVE_DATA="Найден существующий файл конфигурации. Сохранить ваши кастомные данные? (y/n)"
    STR_PRESERVING_DATA="Сохранение пользовательских данных..."
    STR_DATA_PRESERVED="Пользовательские данные успешно перенесены."
    STR_SKIPPING_QUESTIONS="Пропускаем вопросы, так как данные были восстановлены."
else
    STR_STARTING="Starting the subscription page installation script..."
    STR_DOWNLOADING="Downloading subscription.php file..."
    STR_DOWNLOAD_ERROR="Error: Failed to download subscription.php. Check your internet connection."
    STR_VALUE_CHANGED="Value for"
    STR_SUCCESSFULLY_CHANGED="has been changed successfully."
    STR_DEFAULT_LEFT="Default value has been kept."
    STR_ENTER_TO_LEAVE="press Enter to leave"
    Q_PAGENAME="Do you want to specify your page name?"
    Q_PAGEDESC="Do you want to specify your description at the bottom of the page?"
    Q_SUPPORTURL="Do you want to specify your support portal link?"
    Q_ANNOUNCE="Do you want to specify your announcement message?"
    Q_APPSCONFIG="Do you want to use your list of applications? (App list format Remnawave 2.1.0+)"
    Q_BRANDINGTITLE="Do you want to specify your brand title?"
    Q_BRANDINGLOGO="Do you want to specify your brand logo (URL)?"
    STR_APPLYING="Applying changes and restarting vpnbot..."
    STR_SUCCESS_MSG="Subscription page installed successfully!"
    STR_MAKE_ERROR="Error: 'make r' command failed."
    STR_DIR_NOT_FOUND="Error: Directory /root/vpnbot not found."
    Q_PRESERVE_DATA="Existing configuration file found. Do you want to preserve your custom data? (y/n)"
    STR_PRESERVING_DATA="Preserving user data..."
    STR_DATA_PRESERVED="User data successfully migrated."
    STR_SKIPPING_QUESTIONS="Skipping questions as data has been restored."
fi

echo -e "${YELLOW}${STR_STARTING}${NC}"

# --- Функция для замены значений ---
replace_value() {
    local var_name="$1"
    local question="$2"
    local default_value="$3"
    
    read -p "$question (${STR_ENTER_TO_LEAVE} '${default_value}'): " user_input
    
    if [ -n "$user_input" ]; then
        local escaped_input=$(echo "$user_input" | sed -e 's/[]\/$*.^[]/\\&/g')
        sed -i "s/\$$var_name = '.*';/\$$var_name = '$escaped_input';/" "$TARGET_FILE"
        echo -e "${GREEN}${STR_VALUE_CHANGED} '$var_name' ${STR_SUCCESSFULLY_CHANGED}${NC}"
    else
        echo "$STR_DEFAULT_LEFT"
    fi
}

# --- Функция для сохранения старых данных ---
preserve_data() {
    echo -e "${YELLOW}${STR_PRESERVING_DATA}${NC}"
    local backup_file="$TARGET_FILE.bak"
    mv "$TARGET_FILE" "$backup_file"

    # Загрузка нового файла
    echo "$STR_DOWNLOADING"
    if ! curl -sSL "$DOWNLOAD_URL" -o "$TARGET_FILE"; then
        echo -e "${RED}${STR_DOWNLOAD_ERROR}${NC}"
        mv "$backup_file" "$TARGET_FILE" # Возвращаем бэкап
        exit 1
    fi

    # Извлечение и вставка старых значений
    vars_to_preserve=("metaTitle" "metaDescription" "supportUrl" "announce" "appsConfigUrl" "brandingTitle" "brandingLogoUrl")
    for var_name in "${vars_to_preserve[@]}"; do
        # Используем awk для надежного извлечения значения между кавычками
        local old_value=$(awk -F"'" -v var="$var_name" '$0 ~ "^\\$" var " = " {print $2}' "$backup_file")
        if [ -n "$old_value" ]; then
            # Экранируем спецсимволы для sed
            local escaped_value=$(echo "$old_value" | sed -e 's/[]\/$*.^[]/\\&/g')
            # Заменяем значение в новом файле
            sed -i "s/\$$var_name = '.*';/\$$var_name = '$escaped_value';/" "$TARGET_FILE"
        fi
    done
    
    rm "$backup_file"
    echo -e "${GREEN}${STR_DATA_PRESERVED}${NC}"
}

# --- Основная логика ---
PRESERVE=false
if [ -f "$TARGET_FILE" ]; then
    read -p "$Q_PRESERVE_DATA " -n 1 -r
    echo
    if [[ $REPLY =~ ^[YyДд]$ ]]; then
        preserve_data
        PRESERVE=true
    fi
fi

if [ "$PRESERVE" = false ]; then
    # Загрузка файла, если он не был загружен в preserve_data
    if [ ! -f "$TARGET_FILE" ]; then
        echo "$STR_DOWNLOADING"
        mkdir -p /root/vpnbot/app
        if ! curl -sSL "$DOWNLOAD_URL" -o "$TARGET_FILE"; then
            echo -e "${RED}${STR_DOWNLOAD_ERROR}${NC}"
            exit 1
        fi
    fi
    # --- Задаем вопросы и меняем значения ---
    replace_value "metaTitle" "$Q_PAGENAME" "vpnbot Sub"
    replace_value "metaDescription" "$Q_PAGEDESC" "Manage your vpnbot subscription and download configuration files for various clients."
    replace_value "supportUrl" "$Q_SUPPORTURL" "https://t.me/yourID"
    replace_value "announce" "$Q_ANNOUNCE" "welcome to the club"
    replace_value "appsConfigUrl" "$Q_APPSCONFIG" "https://cdn.jsdelivr.net/gh/legiz-ru/my-remnawave@refs/heads/main/sub-page/subpage-config/multiapp.json"
    replace_value "brandingTitle" "$Q_BRANDINGTITLE" "vpnbot"
    replace_value "brandingLogoUrl" "$Q_BRANDINGLOGO" "https://cdn.jsdelivr.net/gh/arpicme/Proxy-App-Icon-set@refs/heads/main/white_background/Prizrak-box.svg"
else
    echo -e "${YELLOW}${STR_SKIPPING_QUESTIONS}${NC}"
fi

# --- Выполнение команды make ---
echo -e "${YELLOW}${STR_APPLYING}${NC}"
if [ -d "/root/vpnbot" ]; then
    cd /root/vpnbot
    if make r; then
        echo -e "${GREEN}===========================================${NC}"
        echo -e "${GREEN}${STR_SUCCESS_MSG}${NC}"
        echo -e "${GREEN}===========================================${NC}"
    else
        echo -e "${RED}${STR_MAKE_ERROR}${NC}"
        exit 1
    fi
else
    echo -e "${RED}${STR_DIR_NOT_FOUND}${NC}"
    exit 1
fi

exit 0