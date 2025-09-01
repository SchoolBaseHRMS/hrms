<?php
require 'config/db.php';

// ADD
if(isset($_POST['add'])){
    $name = $_POST['employee_name'];
    $current = $_POST['current_position'];
    $target = $_POST['target_position'];
    $actions = $_POST['development_actions'];
    $date = $_POST['expected_completion_date'];

    if(!$conn->query("INSERT INTO spcd_career_path (employee_name,current_position,target_position,development_actions,expected_completion_date)
        VALUES ('$name','$current','$target','$actions','$date')")){
        die("Insert failed: " . $conn->error);
    }
    header("Location: career_path.php");
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
    $name = $_POST['employee_name'];
    $current = $_POST['current_position'];
    $target = $_POST['target_position'];
    $actions = $_POST['development_actions'];
    $date = $_POST['expected_completion_date'];

    if(!$conn->query("UPDATE spcd_career_path SET 
        employee_name='$name', 
        current_position='$current', 
        target_position='$target', 
        development_actions='$actions', 
        expected_completion_date='$date' 
        WHERE id=$id")){
        die("Update failed: " . $conn->error);
    }
    header("Location: career_path.php");
    exit;
}

// DELETE
if(isset($_GET['delete'])){
    $id = $_GET['delete'];
    if(!$conn->query("DELETE FROM spcd_career_path WHERE id=$id")){
        die("Delete failed: " . $conn->error);
    }
    header("Location: career_path.php");
    exit;
}

// READ
$result = $conn->query("SELECT * FROM spcd_career_path");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Path Mapping</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css"> 
    <script src="assets/js/bootstrap.bundle.min.js"></script>
</head>
<body style="background-color: #1e3c72">

<div class="container mt-5">
    <h2 style="color: #fff">Career Path Mapping</h2>
    <br>
    <button class="btn btn-secondary mb-3"><a href="dashboard.php" style="color:white;text-decoration:none;">Back</a></button>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#careerModal" onclick="openAddModal()">Add Career Path</button>

    <!-- Search -->
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search...">

    <!-- Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Employee Name</th>
                <th>Current Position</th>
                <th>Target Position</th>
                <th>Development Actions</th>
                <th>Expected Completion</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="careerTable">
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['employee_name'] ?></td>
                <td><?= $row['current_position'] ?></td>
                <td><?= $row['target_position'] ?></td>
                <td><?= $row['development_actions'] ?></td>
                <td><?= $row['expected_completion_date'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal" 
                        data-bs-target="#careerModal"
                        onclick="openEditModal(
                            '<?= $row['id'] ?>',
                            '<?= $row['employee_name'] ?>',
                            '<?= $row['current_position'] ?>',
                            '<?= $row['target_position'] ?>',
                            '<?= $row['development_actions'] ?>',
                            '<?= $row['expected_completion_date'] ?>'
                        )">Edit</button>
                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="careerModal" tabindex="-1">
  <div class="modal-dialog">
    <form method="POST" class="modal-content" id="employeeForm">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">Add Career Path</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="career_id">
        <input type="text" name="employee_name" id="career_name" class="form-control mb-2" placeholder="Employee Name" minlength="2" maxlength="100" required>
        <input type="text" name="current_position" id="career_current" class="form-control mb-2" placeholder="Current Position" minlength="2" maxlength="50" required>
        <input type="text" name="target_position" id="career_target" class="form-control mb-2" placeholder="Target Position" minlength="2" maxlength="50" required>
        <input type="text" name="development_actions" id="career_actions" class="form-control mb-2" placeholder="Development Actions" minlength="5" maxlength="100" required>
        <input type="date" name="expected_completion_date" id="career_date" class="form-control mb-2" title="Expected Completion Date" required>
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
    document.getElementById("modalTitle").innerText = "Add Career Path";
    document.getElementById("addBtn").classList.remove("d-none");
    document.getElementById("updateBtn").classList.add("d-none");
    document.getElementById("career_id").value = "";
    document.getElementById("career_name").value = "";
    document.getElementById("career_current").value = "";
    document.getElementById("career_target").value = "";
    document.getElementById("career_actions").value = "";
    document.getElementById("career_date").value = "";
}

// Open modal for Edit
function openEditModal(id, name, current, target, actions, date) {
    document.getElementById("modalTitle").innerText = "Edit Career Path";
    document.getElementById("addBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
    document.getElementById("career_id").value = id;
    document.getElementById("career_name").value = name;
    document.getElementById("career_current").value = current;
    document.getElementById("career_target").value = target;
    document.getElementById("career_actions").value = actions;
    document.getElementById("career_date").value = date;
}

// Simple search filter
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#careerTable tr");
    rows.forEach(r => {
        let text = r.innerText.toLowerCase();
        r.style.display = text.includes(filter) ? "" : "none";
    });
});

// Validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('employeeForm'); // Make sure your form has id="employeeForm"
    const empnameInput = document.getElementById('career_name'); // Employee Name input

    form.addEventListener('submit', function(event) {
        // Validate Employee Name (letters and spaces only)
        if (!/^[a-zA-Z\s]+$/.test(empnameInput.value)) {
            event.preventDefault();
            alert('Employee name can only contain letters and spaces.');
            empnameInput.focus();
            return;
        }
    });

    // Prevent typing invalid characters in Employee Name
    empnameInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^a-zA-Z\s]/g, '');
    });
});

</script>

</body>
</html>
