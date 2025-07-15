[Русская версия](README.md) | [English Version](README_en.md)

[صفحه‌ی نمایشی](https://legiz-ru.github.io/Orion)

# Orion

یک صفحه اشتراک مدرن، سریع و واکنش‌گرا برای پنل پروکسی Remnawave. این صفحه از ابتدا برای ارائه تجربه کاربری بهتر، عملکرد بالا و سفارشی‌سازی آسان ساخته شده است.

## ویژگی‌های کلیدی

*   **طراحی مدرن و واکنش‌گرا:** رابط کاربری تمیز و بصری که بر روی هر دستگاهی، از دسکتاپ تا گوشی‌های هوشمند، عالی به نظر می‌رسد و کار می‌کند.

*   **پشتیبانی از تم‌ها:** جابجایی خودکار یا دستی بین تم‌های روشن، تاریک و سیستمی برای راحتی چشم در هر زمان از روز.

*   **پیکربندی انعطاف‌پذیر برنامه‌ها:** سفارشی‌سازی کامل لیست برنامه‌ها، پشتیبانی از برنامه‌های "ویژه" و راهنماهای نصب چند مرحله‌ای از طریق [فایل قابل تنظیم `app-config.json`](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps).
    *   **گروه‌های سفارشی:** قابلیت افزودن گروه‌های اضافی به بخش برنامه‌ها از طریق فایل یکپارچه‌سازی، [به عنوان مثال `بخش تلویزیون`](https://github.com/legiz-ru/my-remnawave/blob/main/sub-page/multiapp/app-config.json).

*   **کپی کردن لینک‌ها و کدهای QR:** کپی کردن آسان لینک‌های فردی (`vless://`, `trojan://`) و لینک اشتراک اصلی با یک کلیک. برای هر لینک می‌توان یک کد QR تطبیق‌پذیر تولید کرد.

*   **پشتیبانی چند زبانه:** صفحه به زبان‌های **روسی، انگلیسی و فارسی** در دسترس است. زبان به طور خودکار بر اساس تنظیمات مرورگر کاربر تشخیص داده می‌شود، با امکان تغییر دستی.

*   **ادغام با Telegram Mini App:** قابلیت استفاده از صفحه اشتراک به عنوان یک اپلیکیشن کوچک تلگرام در ربات شما.

## اسکرین‌شات‌ها

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

## نصب

۱. **دانلود فایل صفحه:**
   فایل `index.html` را با استفاده از `curl` در همان پوشه‌ای که `docker-compose.yml` شما قرار دارد، دانلود کنید:

    ```bash
    curl -o index.html https://raw.githubusercontent.com/legiz-ru/Orion/main/index.html
    ```

۲. **پیکربندی Docker Compose:**
   در فایل `docker-compose.yml` خود، مسیر فایل `index.html` دانلود شده را با استفاده از `volumes` به کانتینر `remnawave-subscription-page` متصل کنید.

   مثال برای نصب استاندارد:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
    ```

   اگر قصد دارید از [لیست برنامه‌های سفارشی](https://remna.st/docs/install/remnawave-subscription-page#custom-app-configjson-custom-apps) (`app-config.json`) استفاده کنید، `volume` مربوطه را اضافه کنید:

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
          - ./app-config.json:/opt/app/frontend/assets/app-config.json
    ```

۳. **راه‌اندازی مجدد کانتینر:**
   برای اعمال تغییرات، کانتینر Docker را مجدداً راه‌اندازی کنید:

    ```bash
    docker compose down remnawave-subscription-page && docker compose up -d remnawave-subscription-page
    ```

## ارتباط

*   [کانال تلگرام](https://t.me/legiz_trashbag)

## حمایت از پروژه

اگر از این پروژه لذت می‌برید و می‌خواهید از توسعه آن حمایت کنید، می‌توانید کمک مالی کنید:

*   [Tribute on Telegram](https://t.me/tribute/app?startapp=drzu)
*   TON USDT: `UQAGQTQZYCx5TWj5cmTLpo7164PFsXqZZJ6t6x88n7sHW9gU`