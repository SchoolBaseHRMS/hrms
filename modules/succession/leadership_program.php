<?php
require 'config/db.php';

// ADD
if(isset($_POST['add'])){
    $program = $_POST['program_name'];
    $name = $_POST['employee_name'];
    $start = $_POST['start_date'];
    $end = $_POST['end_date'];
    $status = $_POST['status'];

    if(!$conn->query("INSERT INTO spcd_leadership_program (program_name, employee_name, start_date, end_date, status)
        VALUES ('$program','$name','$start','$end','$status')")){
        die("Insert failed: " . $conn->error);
    }
    header("Location: leadership_program.php");
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
    $program = $_POST['program_name'];
    $name = $_POST['employee_name'];
    $start = $_POST['start_date'];
    $end = $_POST['end_date'];
    $status = $_POST['status'];

    if(!$conn->query("UPDATE spcd_leadership_program SET 
        program_name='$program', 
        employee_name='$name', 
        start_date='$start', 
        end_date='$end', 
        status='$status' 
        WHERE id=$id")){
        die("Update failed: " . $conn->error);
    }
    header("Location: leadership_program.php");
    exit;
}

// DELETE
if(isset($_GET['delete'])){
    $id = $_GET['delete'];
    if(!$conn->query("DELETE FROM spcd_leadership_program WHERE id=$id")){
        die("Delete failed: " . $conn->error);
    }
    header("Location: leadership_program.php");
    exit;
}

// READ
$result = $conn->query("SELECT * FROM spcd_leadership_program");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leadership Development Programs</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css"> 
    <script src="assets/js/bootstrap.bundle.min.js"></script>
</head>
<body style="background-color: #1e3c72">

<div class="container mt-5">
    <h2 style="color: #fff">Leadership Development Programs</h2>
    <br>
    <button class="btn btn-secondary mb-3"><a href="dashboard.php" style="color:white;text-decoration:none;">Back</a></button>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#programModal" onclick="openAddModal()">Add Program</button>

    <!-- Search -->
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search...">

    <!-- Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Program Name</th>
                <th>Employee Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="programTable">
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['program_name'] ?></td>
                <td><?= $row['employee_name'] ?></td>
                <td><?= $row['start_date'] ?></td>
                <td><?= $row['end_date'] ?></td>
                <td><?= $row['status'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal" 
                        data-bs-target="#programModal"
                        onclick="openEditModal(
                            '<?= $row['id'] ?>',
                            '<?= $row['program_name'] ?>',
                            '<?= $row['employee_name'] ?>',
                            '<?= $row['start_date'] ?>',
                            '<?= $row['end_date'] ?>',
                            '<?= $row['status'] ?>'
                        )">Edit</button>
                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="programModal" tabindex="-1">
  <div class="modal-dialog">
    <form method="POST" class="modal-content" id="employeeForm">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">Add Program</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="prog_id">
        <input type="text" name="program_name" id="prog_name" class="form-control mb-2" placeholder="Program Name" minlength="2" maxlength="100" required>
        <input type="text" name="employee_name" id="prog_emp" class="form-control mb-2" placeholder="Employee Name" minlength="2" maxlength="100" required >
        <input type="date" name="start_date" id="prog_start" class="form-control mb-2" title="Put the Start Date" required>
        <input type="date" name="end_date" id="prog_end" class="form-control mb-2" title="Put the End Date" required>
        <select name="status" id="prog_status" class="form-control mb-2" title="Choose one of status">
            <option value="Ongoing">Ongoing</option>
            <option value="Completed">Completed</option>
            <option value="Planned">Planned</option>
        </select>
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
    document.getElementById("modalTitle").innerText = "Add Program";
    document.getElementById("addBtn").classList.remove("d-none");
    document.getElementById("updateBtn").classList.add("d-none");
    document.getElementById("prog_id").value = "";
    document.getElementById("prog_name").value = "";
    document.getElementById("prog_emp").value = "";
    document.getElementById("prog_start").value = "";
    document.getElementById("prog_end").value = "";
    document.getElementById("prog_status").value = "Ongoing";
}

// Open modal for Edit
function openEditModal(id, program, emp, start, end, status) {
    document.getElementById("modalTitle").innerText = "Edit Program";
    document.getElementById("addBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
    document.getElementById("prog_id").value = id;
    document.getElementById("prog_name").value = program;
    document.getElementById("prog_emp").value = emp;
    document.getElementById("prog_start").value = start;
    document.getElementById("prog_end").value = end;
    document.getElementById("prog_status").value = status;
}

// Simple search filter
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#programTable tr");
    rows.forEach(r => {
        let text = r.innerText.toLowerCase();
        r.style.display = text.includes(filter) ? "" : "none";
    });
});

// Validate
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('employeeForm');
    const empnameInput = document.getElementById('prog_emp');
    

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
