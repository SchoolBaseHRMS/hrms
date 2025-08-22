<?php
$active = 'dashboard';
$base = '/hrms/public'; 
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="<?php echo $base; ?>/img/k.png" type="image/png">
  <link rel="stylesheet" href="<?php echo $base; ?>/css/dashboard.css">
  <title>Kupal University Admin Dashboard</title>
</head>
<body>

  <?php include_once __DIR__ . '/partials/sidebar.php'; ?>

  <?php include_once __DIR__ . '/partials/header.php'; ?>

</body>
</html>
