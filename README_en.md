[Russian Version](README.md) | [中文版本](README_zh.md) | [نسخه فارسی](README_fa.md)

[Demo page](https://legiz-ru.github.io/Orion)

# Orion

A modern, fast, and responsive subscription page for the Remnawave proxy panel. Built from the ground up to provide a better user experience, high performance, and easy customization.

## Key Features

*   **Modern & Responsive Design:** A clean, intuitive interface that looks and works great on any device, from desktops to smartphones.

*   **Theme Support:** Automatic or manual switching between light, dark, and system themes for eye comfort at any time of day.

*   **Flexible App Configuration:** Full customization of the application list, support for "featured" apps, and multi-step setup guides via a customizable subpage configuration on the remnawave panel side.

*   **Branding Support:** Configure logo and support link through `logoUrl` and `supportUrl` parameters in subpage config for page personalization.

*   **Link Copying & QR Codes:** Convenient one-click copying of individual links (`vless://`, `trojan://`) and the main subscription link. An adaptive QR code can be generated for each link.

*   **Multilingual support:** The page is available in all 20 languages of the subpage configuration editor, including Russian, English, Farsi, and Chinese. The language is detected automatically based on the user's browser settings, with an option to switch manually.

*   **remnawave-json Support:** Ability to integrate the subscription page into https://github.com/Jolymmiels/remnawave-json (adapted index.html file is located in the remnawave-json folder).

*   **Telegram Mini App Integration:** The ability to use the subscription page as a Telegram Mini App in your bot.
    *   **Redirect page:** Ability to use your own or external redirect page (relevant for Telegram Mini App, for example in Orion style — [demo](https://legiz-ru.github.io/Orion/redirect-page/?redirect_to=), self-host via [Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html)).

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

<div align="center">
  <img src="./screenshots/orion-redirect-page.jpg" width="66%" alt="Orion Redirect Page">
</div>

## Installation for Remnawave

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

3.  **(Optional) Redirect page setup for redirection**  
    For integration with Telegram Mini App or custom redirection logic, set your redirect page in `index.html`:
    ```js
    const redirect_link = 'https://legiz-ru.github.io/Orion/redirect-page/?redirect_to=';
    ```
    or use your own self-hosted variant. For example: [Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html) or [redirect-page from maposia](https://github.com/maposia/redirect-page/).

4.  **Restart container:**
    To apply changes, restart the Docker container:

    ```bash
    docker compose down remnawave-subscription-page && docker compose up -d remnawave-subscription-page
    ```

## Installing for vpnbot

Run the installation script on your vpnbot server:

```bash
bash <(curl -s https://raw.githubusercontent.com/legiz-ru/Orion/refs/heads/main/vpnbot/install.sh)
```

## Installation for marzban

**Automatic installation:**  
Use the automatic script as described in [marz-sub](https://github.com/legiz-ru/marz-sub/blob/main/README.md).

**Manual installation:**  
<details>
<summary>Step-by-step instructions</summary>

1. Download the subscription page file:
   ```bash
   sudo wget -N -P /var/lib/marzban/templates/subscription/ https://raw.githubusercontent.com/legiz-ru/Orion/main/marzban/index.html
   ```

2. Set the subscription page template path in Marzban `.env`:
   ```bash
   echo 'CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"' | sudo tee -a /opt/marzban/.env
   echo 'SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"' | sudo tee -a /opt/marzban/.env
   ```

   Or edit `.env` manually:
   ```
   CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"
   SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"
   ```

3. **Replace the following values in `index.html` with your own:**
   - `<%= metaTitle %>` - meta title
   - `<%= metaDescription %>` - meta description and page footer content
   - `<%= brandingTitle %>` - brand name displayed on the page
   - `<%= brandingLogoUrl %>` - brand logo displayed on the page
   - `<%= brandingSupportUrl %>` - support link displayed on the page
   - `<%= subPageConfig %>` - subscription page configuration (remnawave 2.4-2.5 format)

4. Restart Marzban:
   ```bash
   marzban restart
   ```
</details>

## Contact

*   [Telegram Channel](https://t.me/legiz_trashbag)

## Support the Project

If you like this project and want to support its development, you can make a donation:

*   [Tribute on Telegram](https://t.me/tribute/app?startapp=drzu)
*   TON USDT: `UQAGQTQZYCx5TWj5cmTLpo7164PFsXqZZJ6t6x88n7sHW9gU`