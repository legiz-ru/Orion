[Русская версия](README.md) | [نسخه فارسی](README_fa.md)

[Demo page](https://legiz-ru.github.io/Orion)

# Orion

A modern, fast, and responsive subscription page for the Remnawave proxy panel. Built from the ground up to provide a better user experience, high performance, and easy customization.

## Key Features

*   **Modern & Responsive Design:** A clean, intuitive interface that looks and works great on any device, from desktops to smartphones.

*   **Theme Support:** Automatic or manual switching between light, dark, and system themes for eye comfort at any time of day.

*   **Flexible App Configuration:** Full customization of the application list, support for "featured" apps, and multi-step setup guides via a [customizable `app-config.json` file](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps).
    *   **Custom Groups:** Ability to add extra groups to the apps section via the integration file, [e.g., a `TV section`](https://github.com/legiz-ru/my-remnawave/blob/main/sub-page/multiapp/app-config.json).

*   **Link Copying & QR Codes:** Convenient one-click copying of individual links (`vless://`, `trojan://`) and the main subscription link. An adaptive QR code can be generated for each link.

*   **Multilingual Support:** The page is available in **Russian, English, and Farsi**. The language is detected automatically based on the user's browser settings, with a manual override option.

*   **Telegram Mini App Integration:** The ability to use the subscription page as a Telegram Mini App in your bot.

## Screenshots

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

## Installation

1.  **Download the Page File:**
    Download the `index.html` file to the same directory as your `docker-compose.yml` using `curl`:

    ```bash
    curl -o index.html https://raw.githubusercontent.com/legiz-ru/Orion/main/index.html
    ```

2.  **Configure Docker Compose:**
    In your `docker-compose.yml`, specify the path to the downloaded `index.html` by mounting it as a `volume` in the `remnawave-subscription-page` container.

    Example for a standard installation:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
    ```

    If you plan to use a [custom app list](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps) (`app-config.json`), add the corresponding `volume`:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
          - ./app-config.json:/opt/app/frontend/assets/app-config.json
    ```

3.  **Restart the Container:**
    To apply the changes, restart the Docker container:

    ```bash
    docker compose down remnawave-subscription-page && docker compose up -d remnawave-subscription-page
    ```

## Contact

*   [Telegram Channel](https://t.me/legiz_trashbag)

## Support the Project

If you like this project and want to support its development, you can make a donation:

*   [Tribute on Telegram](https://t.me/tribute/app?startapp=drzu)
*   TON USDT: `UQAGQTQZYCx5TWj5cmTLpo7164PFsXqZZJ6t6x88n7sHW9gU`