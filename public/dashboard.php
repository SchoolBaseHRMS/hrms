<?php
$base_url = '/hrms/';
$active = 'dashboard';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="<?php echo $base; ?>/img/k.png" type="image/png">
  <link rel="stylesheet" href="/hrms/public/styles/header.css">
  <link rel="stylesheet" href="/hrms/public/styles/sidebar.css">
  <link rel="stylesheet" href="/hrms/public/styles/dashboard.css">
  <title>Kupal University Admin Dashboard</title>
</head>
<body>
  <?php
    include_once('partials/header.php');
    include_once('partials/sidebar.php');
  ?>  
</body>
</html>
