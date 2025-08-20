<?php

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href=/hrms/public/styles/header.css>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="/hrms/public/js/header.js" defer></script>
    <title>Header</title>
</head>
<body>
    <header class="main-header">


    <div class="header-right">
      <nav class="nav-actions">
        <i class="bx bx-bell" title="Notifications" role="button"></i>
        <i class="bx bx-message" title="Messages" role="button"></i>
        <i class="bx bx-moon toggle-theme" id="themeToggle" title="Toggle theme" role="button" tabindex="0"></i>

        <div class="profile" id="profileBtn">
            <span class="name">Andrie</span>
            <img src="hrms/public/img/ako.jpg"/>
          <div class="dropdown" id="profileDropdown" role="menu">
            <a href="#" role="menuitem">Profile</a>
            <a href="#" role="menuitem">Settings</a>
            <a href="#" role="menuitem">Logout</a>
          </div>
        </div>
      </nav>
    </div>
  </header>
</body>
</html>