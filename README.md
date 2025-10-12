<img width="2948" height="497" alt="rsg_framework" src="https://github.com/user-attachments/assets/638791d8-296d-4817-a596-785325c1b83a" />

# 🎬 rsg-loading
**Custom RedM loading screen for RSG Core framework.**

![Platform](https://img.shields.io/badge/platform-RedM-darkred)
![License](https://img.shields.io/badge/license-GPL--3.0-green)

> A stylish and lightweight loading screen using Vue 3 and Quasar.  
> Features animated background video, background music, and RSG Framework branding.

---

## 🛠️ Dependencies
- **None required** — this resource runs standalone.  
- Compatible with **RSG Core** servers.  

**License:** GPL‑3.0

---

## ✨ Features
- 🎥 **Animated video background** (default: `assets/video/freestockvideo.mp4`).  
- 🎧 **Background music** (default: `assets/audio/noncopyright.mp3`, looping enabled).  
- 🖼️ **Custom branding** — RSG logo and framework visuals.  
- 🧩 **Vue 3 + Quasar UI framework** for smooth transitions.  
- 🖱️ **Visible cursor** and **manual loadscreen shutdown**.  
- 🌍 **Easily customizable HTML/CSS structure.**

---

## ⚙️ Configuration (`fxmanifest.lua`)
```lua
fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'This is a custom RedM loading screen.'

loadscreen 'html/index.html'
loadscreen_cursor 'yes'
loadscreen_manual_shutdown 'yes'

files {
    'html/index.html',
    'html/assets/**',
    'html/assets/audio/**',
    'html/assets/video/**',
    'html/assets/images/**',
    'html/app.js',
    'html/styles.css'
}
```

> Edit the `html/assets` folder to replace the **video**, **audio**, or **images** with your own branding.

---

## 🎨 Customization
- Replace the background video:  
  `html/assets/video/freestockvideo.mp4`
- Replace the music file:  
  `html/assets/audio/noncopyright.mp3`
- Adjust volume and autoplay behavior in `app.js`.
- Change text, progress bar, and style via `index.html` and `styles.css`.

---

## 📂 Installation
1. Copy the folder `rsg-loading` into your `resources/[rsg]` directory.  
2. In your `server.cfg`, add:
   ```cfg
   ensure rsg-loading
   ```
3. (Optional) Replace video/audio assets with your own files.  
4. Restart your RedM server.

---

## 💡 Example Preview
The default setup shows the RSG Framework logo, an animated video background, and looping music during player connection.

---

## 💎 Credits
- **qb-loading** — Original base script  
- **RSG / Rexshack‑RedM** — adaptation & maintenance  
- **Community contributors & translators**  
- License: GPL‑3.0
