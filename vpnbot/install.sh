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
    Q_MODE="Выберите режим работы: (1) Установка/Обновление (2) Редактирование переменных"
    STR_EDIT_MODE="Режим редактирования переменных"
    STR_CURRENT_VALUE="Текущее значение"
    STR_FILE_NOT_FOUND="Ошибка: Файл subscription.php не найден. Сначала выполните установку."
    STR_EDIT_SUCCESS="Переменные успешно обновлены!"
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
    Q_MODE="Select mode: (1) Install/Update (2) Edit variables"
    STR_EDIT_MODE="Edit variables mode"
    STR_CURRENT_VALUE="Current value"
    STR_FILE_NOT_FOUND="Error: subscription.php file not found. Please install first."
    STR_EDIT_SUCCESS="Variables successfully updated!"
fi

# --- Выбор режима работы ---
MODE=""
while [[ "$MODE" != "1" && "$MODE" != "2" ]]; do
    read -p "$Q_MODE: " MODE
    if [[ "$MODE" != "1" && "$MODE" != "2" ]]; then
        if [ "$LANG" = "ru" ]; then
            echo "Неверный ввод. Введите 1 или 2."
        else
            echo "Invalid input. Enter 1 or 2."
        fi
    fi
done

echo -e "${YELLOW}${STR_STARTING}${NC}"

# --- Функция для получения текущего значения переменной ---
get_current_value() {
    local var_name="$1"
    local current_value=$(awk -F"'" -v var="$var_name" '$0 ~ "^\\$" var " = " {print $2}' "$TARGET_FILE")
    echo "$current_value"
}

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

# --- Функция для редактирования значений с показом текущего ---
edit_value() {
    local var_name="$1"
    local question="$2"

    local current_value=$(get_current_value "$var_name")
    echo -e "${YELLOW}${STR_CURRENT_VALUE}: ${NC}'${current_value}'"
    read -p "$question (${STR_ENTER_TO_LEAVE} текущее значение): " user_input

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
if [ "$MODE" = "2" ]; then
    # --- Режим редактирования ---
    echo -e "${YELLOW}${STR_EDIT_MODE}${NC}"

    # Проверка существования файла
    if [ ! -f "$TARGET_FILE" ]; then
        echo -e "${RED}${STR_FILE_NOT_FOUND}${NC}"
        exit 1
    fi

    # Редактирование переменных
    edit_value "metaTitle" "$Q_PAGENAME"
    edit_value "metaDescription" "$Q_PAGEDESC"
    edit_value "supportUrl" "$Q_SUPPORTURL"
    edit_value "announce" "$Q_ANNOUNCE"
    edit_value "appsConfigUrl" "$Q_APPSCONFIG"
    edit_value "brandingTitle" "$Q_BRANDINGTITLE"
    edit_value "brandingLogoUrl" "$Q_BRANDINGLOGO"

    echo -e "${GREEN}===========================================${NC}"
    echo -e "${GREEN}${STR_EDIT_SUCCESS}${NC}"
    echo -e "${GREEN}===========================================${NC}"

    # Спрашиваем о перезапуске
    if [ "$LANG" = "ru" ]; then
        read -p "Хотите перезапустить vpnbot сейчас? (y/n): " -n 1 -r
    else
        read -p "Do you want to restart vpnbot now? (y/n): " -n 1 -r
    fi
    echo
    if [[ $REPLY =~ ^[YyДд]$ ]]; then
        echo -e "${YELLOW}${STR_APPLYING}${NC}"
        if [ -d "/root/vpnbot" ]; then
            cd /root/vpnbot
            if make r; then
                echo -e "${GREEN}${STR_SUCCESS_MSG}${NC}"
            else
                echo -e "${RED}${STR_MAKE_ERROR}${NC}"
                exit 1
            fi
        else
            echo -e "${RED}${STR_DIR_NOT_FOUND}${NC}"
            exit 1
        fi
    fi
else
    # --- Режим установки/обновления ---
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
fi

exit 0