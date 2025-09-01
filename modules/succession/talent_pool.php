<?php
require 'config/db.php';

// CREATE
if(isset($_POST['add'])){
    $name = $_POST['employee_name'];
    $emp_id = $_POST['employee_id'];
    $dept = $_POST['department'];
    $pos = $_POST['position'];
    $potential = $_POST['potential_level'];
    $date = $_POST['date_identified'];

    if(!$conn->query("INSERT INTO spcd_talent_pool (employee_name, employee_id, department, position, potential_level, date_identified) 
        VALUES ('$name','$emp_id','$dept','$pos','$potential','$date')")){
        die("Insert failed: " . $conn->error);
    }
    header("Location: talent_pool.php");
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
    $emp_id = $_POST['employee_id'];
    $dept = $_POST['department'];
    $pos = $_POST['position'];
    $potential = $_POST['potential_level'];
    $date = $_POST['date_identified'];

    if(!$conn->query("UPDATE spcd_talent_pool SET 
        employee_name='$name', 
        employee_id='$emp_id', 
        department='$dept', 
        position='$pos', 
        potential_level='$potential', 
        date_identified='$date' 
        WHERE id=$id")){
        die("Update failed: " . $conn->error);
    }
    header("Location: talent_pool.php");
    exit;
}

// DELETE
if(isset($_GET['delete'])){
    $delete_id = $_GET['delete'];
    if(!$conn->query("DELETE FROM spcd_talent_pool WHERE id=$delete_id")){
        die("Delete failed: " . $conn->error);
    }
    header("Location: talent_pool.php");
    exit;
}

// READ
$result = $conn->query("SELECT * FROM spcd_talent_pool");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Talent Pool</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>

</head>
<body style="background-color: #1e3c72">

<div class="container mt-5">
    <h2 style="color: #fff">Talent Pool Identification</h2>
    <br>
    <button class="btn btn-secondary mb-3"><a href="dashboard.php" style="color:white;text-decoration:none;">Back</a></button>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#employeeModal" onclick="openAddModal()">Add Employee</button>

    <!-- Search -->
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search employee...">

    <!-- Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Employee Name</th>
                <th>Employee ID</th>
                <th>Department</th>
                <th>Position</th>
                <th>Potential Level</th>
                <th>Date Identified</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="employeeTable">
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['employee_name'] ?></td>
                <td><?= $row['employee_id'] ?></td>
                <td><?= $row['department'] ?></td>
                <td><?= $row['position'] ?></td>
                <td><?= $row['potential_level'] ?></td>
                <td><?= $row['date_identified'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm" 
                        data-bs-toggle="modal" 
                        data-bs-target="#employeeModal"
                        onclick="openEditModal(
                            '<?= $row['id'] ?>',
                            '<?= $row['employee_name'] ?>',
                            '<?= $row['employee_id'] ?>',
                            '<?= $row['department'] ?>',
                            '<?= $row['position'] ?>',
                            '<?= $row['potential_level'] ?>',
                            '<?= $row['date_identified'] ?>'
                        )">Edit</button>
                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="employeeModal" tabindex="-1">
  <div class="modal-dialog">
    <form method="POST" class="modal-content" id="employeeForm">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">Add Employee</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="emp_id">
        <input type="text" name="employee_name" id="emp_name" class="form-control mb-2" placeholder="Employee Name" minlength="2" maxlength="100" required>
        <input type="text" name="employee_id" id="emp_code" class="form-control mb-2" placeholder="Employee ID" minlength="2" maxlength="20" required>
        <input type="text" name="department" id="emp_dept" class="form-control mb-2" placeholder="Department" minlength="2" maxlength="50" required>
        <input type="text" name="position" id="emp_pos" class="form-control mb-2" placeholder="Position" minlength="2" maxlength="50" required>
        <select name="potential_level" id="emp_potential" class="form-control mb-2" required>
            <option value="">-- Select Potential Level --</option>
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
        </select>
        <input type="date" name="date_identified" id="emp_date" class="form-control mb-2" title="Date Identified" required>
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
    document.getElementById("modalTitle").innerText = "Add Employee";
    document.getElementById("addBtn").classList.remove("d-none");
    document.getElementById("updateBtn").classList.add("d-none");
    document.getElementById("emp_id").value = "";
    document.getElementById("emp_name").value = "";
    document.getElementById("emp_code").value = "";
    document.getElementById("emp_dept").value = "";
    document.getElementById("emp_pos").value = "";
    document.getElementById("emp_potential").value = "";
    document.getElementById("emp_date").value = "";
}

// Open modal for Edit
function openEditModal(id, name, emp_code, dept, pos, potential, date) {
    document.getElementById("modalTitle").innerText = "Edit Employee";
    document.getElementById("addBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
    document.getElementById("emp_id").value = id;
    document.getElementById("emp_name").value = name;
    document.getElementById("emp_code").value = emp_code;
    document.getElementById("emp_dept").value = dept;
    document.getElementById("emp_pos").value = pos;
    document.getElementById("emp_potential").value = potential;
    document.getElementById("emp_date").value = date;
}

// Simple search filter
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#employeeTable tr");
    rows.forEach(r => {
        let text = r.innerText.toLowerCase();
        r.style.display = text.includes(filter) ? "" : "none";
    });
});

// Validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('employeeForm'); // Make sure your form has id="employeeForm"
    const empnameInput = document.getElementById('emp_name'); // Employee Name input
    const ageInput = document.getElementById('age'); // Age input

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


