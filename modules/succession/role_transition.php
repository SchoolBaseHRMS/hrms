<?php
require 'config/db.php';

// ADD
if(isset($_POST['add'])){
    $employee = $_POST['employee_name'];
    $current = $_POST['current_role'];
    $newrole = $_POST['new_role'];
    $date = $_POST['transition_date'];
    $manager = $_POST['responsible_manager'];

    if(!$conn->query("INSERT INTO spcd_role_transition (employee_name, `current_role`, `new_role`, transition_date, responsible_manager)
        VALUES ('$employee','$current','$newrole','$date','$manager')")){
        die("Insert failed: " . $conn->error);
    }
    header("Location: role_transition.php");
    exit;

     // Validate employee name (letters and spaces only)
    if (!preg_match("/^[a-zA-Z\s]+$/", $employee_name)) {
    echo "Error: Employee name can only contain letters and spaces.";
    exit();  // Stop execution if validation fails
    }
}

// UPDATE
if(isset($_POST['update'])){
    $id = $_POST['id'];
    $employee = $_POST['employee_name'];
    $current = $_POST['current_role'];
    $newrole = $_POST['new_role'];
    $date = $_POST['transition_date'];
    $manager = $_POST['responsible_manager'];

    if(!$conn->query("UPDATE spcd_role_transition SET 
        employee_name='$employee',
        `current_role`='$current',
        `new_role`='$newrole',
        transition_date='$date',
        responsible_manager='$manager'
        WHERE id=$id")){
        die("Update failed: " . $conn->error);
    }
    header("Location: role_transition.php");
    exit;
}

// DELETE
if(isset($_GET['delete'])){
    $id = $_GET['delete'];
    if(!$conn->query("DELETE FROM spcd_role_transition WHERE id=$id")){
        die("Delete failed: " . $conn->error);
    }
    header("Location: role_transition.php");
    exit;
}

// READ
$result = $conn->query("SELECT * FROM spcd_role_transition");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Role Transition Planning</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css"> 
    <script src="assets/js/bootstrap.bundle.min.js"></script>
</head>
<body style="background-color: #1e3c72">

<div class="container mt-5">
    <h2 style="color: #fff">Role Transition Planning</h2>
    <br>
    <button class="btn btn-secondary mb-3"><a href="dashboard.php" style="color:white;text-decoration:none;">Back</a></button>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#transitionModal" onclick="openAddModal()">Add Transition</button>

    <!-- Search -->
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search...">

    <!-- Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Employee Name</th>
                <th>Current Role</th>
                <th>New Role</th>
                <th>Transition Date</th>
                <th>Responsible Manager</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="transitionTable">
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['employee_name'] ?></td>
                <td><?= $row['current_role'] ?></td>
                <td><?= $row['new_role'] ?></td>
                <td><?= $row['transition_date'] ?></td>
                <td><?= $row['responsible_manager'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal" 
                        data-bs-target="#transitionModal"
                        onclick="openEditModal(
                            '<?= $row['id'] ?>',
                            '<?= $row['employee_name'] ?>',
                            '<?= $row['current_role'] ?>',
                            '<?= $row['new_role'] ?>',
                            '<?= $row['transition_date'] ?>',
                            '<?= $row['responsible_manager'] ?>'
                        )">Edit</button>
                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="transitionModal" tabindex="-1">
  <div class="modal-dialog">
    <form method="POST" class="modal-content" id="employeeForm">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">Add Transition</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="trans_id">
        <input type="text" name="employee_name" id="trans_emp" class="form-control mb-2" placeholder="Employee Name" minlength="2" maxlength="100" required>
        <input type="text" name="current_role" id="trans_current" class="form-control mb-2" placeholder="Current Role" minlength="2" maxlength="100" required>
        <input type="text" name="new_role" id="trans_new" class="form-control mb-2" placeholder="New Role" required minlength="2" maxlength="100">
        <input type="date" name="transition_date" id="trans_date" class="form-control mb-2" title="Transition Date" required>
        <input type="text" name="responsible_manager" id="trans_manager" class="form-control mb-2" placeholder="Responsible Manager" minlength="2" maxlength="100" required>
      </div>
      <div class="modal-footer">
        <button type="submit" name="add" id="addBtn" class="btn btn-primary">Add</button>
        <button type="submit" name="update" id="updateBtn" class="btn btn-success d-none">Update</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </form>
  </div>
</div>

<script>
// Open modal for Add
function openAddModal() {
    document.getElementById("modalTitle").innerText = "Add Transition";
    document.getElementById("addBtn").classList.remove("d-none");
    document.getElementById("updateBtn").classList.add("d-none");
    document.getElementById("trans_id").value = "";
    document.getElementById("trans_emp").value = "";
    document.getElementById("trans_current").value = "";
    document.getElementById("trans_new").value = "";
    document.getElementById("trans_date").value = "";
    document.getElementById("trans_manager").value = "";
}

// Open modal for Edit
function openEditModal(id, emp, current, newrole, date, manager) {
    document.getElementById("modalTitle").innerText = "Edit Transition";
    document.getElementById("addBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
    document.getElementById("trans_id").value = id;
    document.getElementById("trans_emp").value = emp;
    document.getElementById("trans_current").value = current;
    document.getElementById("trans_new").value = newrole;
    document.getElementById("trans_date").value = date;
    document.getElementById("trans_manager").value = manager;
}

// Simple search filter
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#transitionTable tr");
    rows.forEach(r => {
        let text = r.innerText.toLowerCase();
        r.style.display = text.includes(filter) ? "" : "none";
    });
});

// Validate
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('employeeForm');
    const empnameInput = document.getElementById('trans_emp');
    

    form.addEventListener('submit', function(event) {
        // ✅ Validate Employee Name
        if (!/^[a-zA-Z\s]+$/.test(empnameInput.value)) {
            event.preventDefault();
            alert('Employee name can only contain letters and spaces.');
            empnameInput.focus();
            return;
        }
    });

    // ✅ Prevent typing invalid characters in Employee Name
    empnameInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^a-zA-Z\s]/g, '');
    });

});

</script>

</body>
</html>
