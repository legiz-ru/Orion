[Russian Version](README.md) | [English Version](README_en.md) | [نسخه فارسی](README_fa.md)

[演示页面](https://legiz-ru.github.io/Orion)

# Orion

为 Remnawave 面板设计的现代化、快速且响应式的订阅页面。从零开始构建，为订阅管理提供最佳用户体验。

## 主要特性

*   **现代化响应式设计：** 简洁直观的界面，在所有设备上都能完美显示和运行。

*   **主题支持：** 可在浅色、深色和系统主题之间自动或手动切换，使用更加舒适。

*   **灵活的应用配置：** 完全自定义应用列表，支持"推荐"应用和添加自定义链接，可通过 remnawave 面板侧的 subpage 配置进行设置。

*   **品牌支持：** 通过 subpage config 配置中的 `logoUrl` 和 `supportUrl` 参数设置徽标和支持链接，实现页面个性化。

*   **链接复制和二维码：** 一键方便复制单个链接（`vless://`、`trojan://`）和主订阅链接，还能生成二维码便于快速设置。

*   **多语言支持：** 页面提供 subpage 配置编辑器的全部 20 种语言，包括俄语、英语、波斯语和中文。语言将根据用户的浏览器设置自动识别，并支持手动切换。

*   **remnawave-json 支持：** 可将订阅页面集成到 https://github.com/Jolymmiels/remnawave-json（适配的 index.html 文件位于 remnawave-json 文件夹中）。

*   **Telegram Mini App 集成：** 可将订阅页面用作 Telegram 机器人中的 Mini App。
    *   **重定向页面：** 可选择使用自定义或外部重定向页面，更好地集成 Telegram Mini App。

## 截图

<div align="center">
  <img src="./screenshots/orion-main-light.jpg" width="75%" alt="浅色主题">
  <img src="./screenshots/orion-main-dark.jpg" width="75%" alt="深色主题">
  <img src="./screenshots/orion-apps.jpg" width="75%" alt="应用部分">
  <img src="./screenshots/orion-modal-guide.jpg" width="75%" alt="安装指南">
  <img src="./screenshots/orion-settings.jpg" width="75%" alt="设置">
</div>

<div align="center">
  <img src="./screenshots/orion-mobile.jpg" width="20%" alt="移动版本">
</div>

<div align="center">
  <img src="./screenshots/orion-redirect-page.jpg" width="66%" alt="Orion 重定向页面">
</div>

## 安装 Remnawave

1.  **下载页面文件：**
    使用 `curl` 将 `index.html` 文件下载到 `docker-compose.yml` 所在的同一文件夹：

    ```bash
    curl -o index.html https://raw.githubusercontent.com/legiz-ru/Orion/main/index.html
    ```

2.  **配置 Docker Compose：**
    在 `docker-compose.yml` 中通过 `volumes` 挂载将下载的 `index.html` 路径映射到 `remnawave-subscription-page` 容器。

    标准安装示例：

    ```yaml
    services:
      remnawave-subscription-page:
        image: remnawave/subscription-page:latest
        volumes:
          - ./index.html:/opt/app/frontend/index.html
    ```

3.  **（可选）配置重定向页面**  
    对于 Telegram Mini App 集成或自定义重定向逻辑，在 index.html 中指定您的重定向页面：
    ```js
    const redirect_link = 'https://legiz-ru.github.io/Orion/redirect-page/?redirect_to=';
    ```
    或使用自托管版本。例如：[Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html) 或 [Orion redirect-page](https://github.com/legiz-ru/Orion/blob/main/docs/redirect-page/index.html).

4.  **重启容器：**
    要应用更改，请重启 Docker 容器：

    ```bash
    docker compose down remnawave-subscription-page && docker compose up -d remnawave-subscription-page
    ```

## 安装 vpnbot

在您的 vpnbot 服务器上运行安装脚本：

```bash
bash <(curl -s https://raw.githubusercontent.com/legiz-ru/Orion/refs/heads/main/vpnbot/install.sh)
```

## Marzban 安装

**自动安装:**  
参考 [marz-sub](https://github.com/legiz-ru/marz-sub/blob/main/README.md) 使用自动脚本进行安装。

**手动安装:**  
<details>
<summary>分步说明</summary>

1. 下载订阅页面文件：
   ```bash
   sudo wget -N -P /var/lib/marzban/templates/subscription/ https://raw.githubusercontent.com/legiz-ru/Orion/main/marzban/index.html
   ```

2. 在 Marzban `.env` 文件中设置订阅页面模板路径：
   ```bash
   echo 'CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"' | sudo tee -a /opt/marzban/.env
   echo 'SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"' | sudo tee -a /opt/marzban/.env
   ```

   或手动编辑 `.env` 文件：
   ```
   CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"
   SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"
   ```

3. **在 `index.html` 文件中替换以下值为你自己的内容：**
   - `<%= metaTitle %>` - 元标题
   - `<%= metaDescription %>` - 元描述和页面页脚内容
   - `<%= brandingTitle %>` - 页面上显示的品牌名称
   - `<%= brandingLogoUrl %>` - 页面上显示的品牌徽标
   - `<%= brandingSupportUrl %>` - 页面上显示的支持链接
   - `<%= subPageConfig %>` - 订阅页面配置 (remnawave 2.4-2.5 格式)

4. 重启 Marzban：
   ```bash
   marzban restart
   ```
</details>

## 联系方式

*   [Telegram 频道](https://t.me/legiz_trashbag)

## 项目支持

如果您喜欢这个项目并希望支持其发展，可以进行捐赠：

*   [Telegram Tribute](https://t.me/tribute/app?startapp=drzu)
*   TON USDT: `UQAGQTQZYCx5TWj5cmTLpo7164PFsXqZZJ6t6x88n7sHW9gU`