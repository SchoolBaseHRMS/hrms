<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Succession Planning and Career Development</title>
  <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
  <link rel="stylesheet" href="assets/css/dashboard.css"> 
  <link rel="stylesheet" href="assets/fontawesome-free-7.0.0-web/css/all.min.css">
  <script defer src="js/bootstrap.min.js"></script>
</head>
<body class="d-flex flex-column min-vh-100">

<div class="d-flex vh-100" class="wrapper">
  <!-- Sidebar -->
  <nav class="custom-sidebar d-flex flex-column">
    <!-- Header -->
    <div class="p-3 d-flex justify-content-between align-items-center">
      <h1 class="mb-1"><a href="dashboard.php" class="logo text-decoration-none">HRMS</a></h1>
    </div>
    <div class="p-4 d-flex justify-content-between align-items-center">
      <h6 class="spcd-dashboard mb-2 text-light">Succession Planning and Career Development Dashboard</h6>
    </div>

    <!-- Nav Items -->
     <!-- List Group for Navigation -->
    <div class="flex-grow-1 overflow-auto p-3">
      <div class="list-group list-group-flush p-6">
          <a href="talent_pool.php" class="list-group-item list-group-item-action"><i class="fa-solid fa-table-list"></i> Talent Pool Identification</a>
          <br>
          <a href="career_path.php" class="list-group-item list-group-item-action"><i class="fa-solid fa-table-list"></i> Career Path Mapping</a>
          <br>
          <a href="high_potential.php" class="list-group-item list-group-item-action"><i class="fa-solid fa-table-list"></i> High-Potential Employee Tracking</a>
          <br>
          <a href="leadership_program.php" class="list-group-item list-group-item-action"><i class="fa-solid fa-table-list"></i> Leadership Development Programs</a>
          <br>
          <a href="role_transition.php" class="list-group-item list-group-item-action"><i class="fa-solid fa-table-list"></i> Role Transition Planning</a>
      </div>
    </div>

    <!-- Footer (Newsletter Form) -->
    <div class="p-1">
      <!-- 
      <h6 class="mb-3">Subscribe for newsletter</h6>
      <form action="#" class="subscribe-form">
        <div class="input-group">
          <input type="email" class="form-control" placeholder="Enter Email Address">
          <button class="btn btn-primary" type="submit">
            <i class="fa fa-paper-plane"></i>
          </button>
        </div>
      </form>
      -->
      <!-- FOOTER -->
      <footer class="footer py-1 mt-auto text-center">
      <p class="mb-0">&copy; <?php echo date("Y"); ?> HRMS Succession Planning and Career Development Mark John Abia Website Design. All Rights Reserved.</p>
      </footer>
    </div>
  </nav>

  <!-- Page Content -->
  <div id="page-content-wrapper" class="flex-grow-1 p-4">
    <!-- Your main content goes here -->
  </div>
  
</div>

</body>
</html>
