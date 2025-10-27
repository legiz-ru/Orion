[English Version](README_en.md) | [中文版本](README_zh.md) | [نسخه فارسی](README_fa.md)

[Демонстрационная страница](https://legiz-ru.github.io/Orion)

# Orion

Современная, быстрая и адаптивная страница подписки для панели Remnawave. Она создана с нуля, чтобы обеспечить лучший пользовательский опыт, высокую производительность и простоту настройки.

## Ключевые особенности

*   **Современный и адаптивный дизайн:** Чистый, интуитивно понятный интерфейс, который отлично выглядит и работает на любых устройствах, от настольных ПК до смартфонов.

*   **Поддержка тем:** Автоматическое или ручное переключение между светлой, темной и системной темами для комфорта глаз в любое время суток.

*   **Гибкая настройка приложений:** Полная кастомизация списка приложений, поддержка "рекомендуемых" приложений и многошаговые инструкции по установке через [настраиваемый файл `app-config.json`](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps).
    *   **Кастомные группы:** Возможность добавлять дополнительные группы в раздел приложений через файл интеграции, [например `секцию TV`](https://github.com/legiz-ru/my-remnawave/blob/main/sub-page/multiapp/app-config.json).

*   **Поддержка брендинга:** Настройка логотипа и ссылки на поддержку через параметры `logoUrl` и `supportUrl` в конфигурации `app-config.json` для персонализации внешнего вида страницы.

*   **Копирование ссылок и QR-коды:** Удобное копирование индивидуальных ссылок (`vless://`, `trojan://`) и основной ссылки-подписки в один клик. Для каждой ссылки можно сгенерировать адаптивный QR-код.

*   **Многоязычная поддержка:** Страница доступна на **русском, английском, узбекском, турецком, фарси и китайском**. Язык определяется автоматически на основе настроек браузера пользователя, с возможностью ручного переключения.

*   **Поддержка remnawave-json:** Возможность интеграции страницы подписки в https://github.com/Jolymmiels/remnawave-json (адаптированный файл index.html расположен в папке remnawave-json).

*   **Интеграция с Telegram Mini App:** Возможность использовать страницу подписки как Telegram Mini App в вашем боте.
    *   **Переадресация/Redirect-страница:** Возможность использовать собственную или внешнюю страницу переадресации (актуально для Telegram Mini App, например в стиле Orion — [демо](https://legiz-ru.github.io/Orion/redirect-page/?redirect_to=), self-host по [Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html)).

## Скриншоты

<div align="center">
  <img src="./screenshots/orion-main-light.jpg" width="75%" alt="تم روشن">
  <img src="./screenshots/orion-main-dark.jpg" width="75%" alt="تم تاریک">
  <img src="./screenshots/orion-apps.jpg" width="75%" alt="بخش برنامه‌ها">
  <img src="./screenshots/orion-modal-guide.jpg" width="75%" alt="راهنمای نصب">
  <img src="./screenshots/orion-settings.jpg" width="75%" alt="تنظیمات">
</div>

<div align="center">
  <img src="./screenshots/orion-mobile.jpg" width="20%" alt="Mobile">
</div>

<div align="center">
  <img src="./screenshots/orion-redirect-page.jpg" width="66%" alt="Orion Redirect Page">
</div>

## Установка для Remnawave

1.  **Загрузка файла страницы:**
    Скачайте файл `index.html` в ту же папку, где находится ваш `docker-compose.yml`, используя `curl`:

    ```bash
    curl -o index.html https://raw.githubusercontent.com/legiz-ru/Orion/main/index.html
    ```

2.  **Настройка Docker Compose:**
    Пропишите путь к скачанному `index.html` в вашем `docker-compose.yml` через проброс `volumes` в контейнер `remnawave-subscription-page`.

    Пример для стандартной установки:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
    ```

    Если вы планируете использовать [кастомный список приложений](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps) (`app-config.json`), добавьте соответствующий `volume`:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
          - ./app-config.json:/opt/app/frontend/assets/app-config.json
    ```

3.  **(Опционально) Настройка redirect-страницы для переадресации**  
    Для интеграции с Telegram Mini App или для кастомной логики переадресации укажите свою redirect-страницу в index.html:
    ```js
    const redirect_link = 'https://legiz-ru.github.io/Orion/redirect-page/?redirect_to=';
    ```
    или используйте свой self-hosted вариант. Например: [Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html) ,[redirect-page от SawGoD](https://github.com/SawGoD/redirect-page) или [redirect-page от maposia](https://github.com/maposia/redirect-page/).

4.  **Перезапуск контейнера:**
    Для применения изменений перезапустите контейнер Docker:

    ```bash
    docker compose down remnawave-subscription-page && docker compose up -d remnawave-subscription-page
    ```

## Установка для vpnbot

Запустите скрипт установки на вашем сервере vpnbot:

```bash
bash <(curl -s https://raw.githubusercontent.com/legiz-ru/Orion/refs/heads/main/vpnbot/install.sh)
```

## Установка для marzban

**Автоматическая установка:**  
Выполните установку автоматическим скриптом, как описано в [marz-sub](https://github.com/legiz-ru/marz-sub/blob/main/README.md).

**Ручная установка:**  
<details>
<summary>Пошаговая инструкция</summary>

1. Скачайте файл страницы:
   ```bash
   sudo wget -N -P /var/lib/marzban/templates/subscription/ https://raw.githubusercontent.com/legiz-ru/Orion/main/marzban/index.html
   ```

2. Укажите путь к шаблону страницы подписки в `.env` Marzban:
   ```bash
   echo 'CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"' | sudo tee -a /opt/marzban/.env
   echo 'SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"' | sudo tee -a /opt/marzban/.env
   ```

   Или отредактируйте `.env` вручную:
   ```
   CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"
   SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"
   ```

3. **Замените значения `<%= metaTitle %>` и `<%= metaDescription %>` на свои во всех местах файла `index.html`.**

4. Перезапустите Marzban:
   ```bash
   marzban restart
   ```
</details>

## Связь

*   [Telegram-канал](https://t.me/legiz_trashbag)

## Поддержка проекта

Если вам нравится этот проект и вы хотите поддержать его развитие, вы можете сделать пожертвование:

*   [Tribute on Telegram](https://t.me/tribute/app?startapp=drzu)
*   TON USDT: `UQAGQTQZYCx5TWj5cmTLpo7164PFsXqZZJ6t6x88n7sHW9gU`
